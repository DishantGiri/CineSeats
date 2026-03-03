using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats
{
    public partial class ManageUsers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers(string searchTerm = "")
        {
            try
            {
                string query = "SELECT USER_ID, FULL_NAME, EMAIL, PHONE, USER_TYPE FROM USER_TABLE";
                OracleParameter[] parameters = null;

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    query += " WHERE LOWER(FULL_NAME) LIKE :search OR LOWER(EMAIL) LIKE :search";
                    parameters = new OracleParameter[] {
                        new OracleParameter("search", "%" + searchTerm.ToLower() + "%")
                    };
                }

                query += " ORDER BY USER_ID DESC";
                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
            catch (Exception ex)
            {
                // Handle error
                Response.Write("<script>alert('Error loading users: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string userType = ddlUserType.SelectedValue;

                if (string.IsNullOrEmpty(hfUserId.Value))
                {
                    // Insert
                    string query = "INSERT INTO USER_TABLE (USER_ID, FULL_NAME, EMAIL, PHONE, USER_TYPE) VALUES (USER_ID_SEQ.NEXTVAL, :name, :email, :phone, :type)";
                    OracleParameter[] parameters = {
                        new OracleParameter("name", fullName),
                        new OracleParameter("email", email),
                        new OracleParameter("phone", phone),
                        new OracleParameter("type", userType)
                    };
                    DatabaseHelper.ExecuteNonQuery(query, parameters);
                }
                else
                {
                    // Update
                    int userId = int.Parse(hfUserId.Value);
                    string query = "UPDATE USER_TABLE SET FULL_NAME = :name, EMAIL = :email, PHONE = :phone, USER_TYPE = :type WHERE USER_ID = :id";
                    OracleParameter[] parameters = {
                        new OracleParameter("name", fullName),
                        new OracleParameter("email", email),
                        new OracleParameter("phone", phone),
                        new OracleParameter("type", userType),
                        new OracleParameter("id", userId)
                    };
                    DatabaseHelper.ExecuteNonQuery(query, parameters);
                }

                ClearForm();
                LoadUsers();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error saving user: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {
                int userId = Convert.ToInt32(e.CommandArgument);
                DataTable dt = DatabaseHelper.ExecuteQuery("SELECT * FROM USER_TABLE WHERE USER_ID = :id", new OracleParameter[] { new OracleParameter("id", userId) });
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfUserId.Value = row["USER_ID"].ToString();
                    txtFullName.Text = row["FULL_NAME"].ToString();
                    txtEmail.Text = row["EMAIL"].ToString();
                    txtPhone.Text = row["PHONE"].ToString();
                    ddlUserType.SelectedValue = row["USER_TYPE"].ToString();
                    btnSave.Text = "Update User";
                }
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
                DatabaseHelper.ExecuteNonQuery("DELETE FROM USER_TABLE WHERE USER_ID = :id", new OracleParameter[] { new OracleParameter("id", userId) });
                LoadUsers();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error deleting user: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadUsers(txtSearch.Text.Trim());
        }

        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            LoadUsers(txtSearch.Text.Trim());
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfUserId.Value = "";
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            ddlUserType.SelectedIndex = 0;
            btnSave.Text = "Save User";
        }
    }
}
