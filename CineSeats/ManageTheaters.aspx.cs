using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats
{
    public partial class ManageTheaters : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTheaters();
            }
        }

        private void LoadTheaters()
        {
            try
            {
                string query = "SELECT * FROM THEATER ORDER BY THEATER_ID DESC";
                gvTheaters.DataSource = DatabaseHelper.ExecuteQuery(query);
                gvTheaters.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(hfTheaterId.Value))
                {
                    string query = "INSERT INTO THEATER (THEATER_ID, THEATER_NAME, CITY, ADDRESS, CONTACT_NUMBER) VALUES (THEATER_ID_SEQ.NEXTVAL, :name, :city, :address, :contact)";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("name", txtTheaterName.Text),
                        new OracleParameter("city", txtCity.Text),
                        new OracleParameter("address", txtAddress.Text),
                        new OracleParameter("contact", txtContact.Text)
                    });
                }
                else
                {
                    string query = "UPDATE THEATER SET THEATER_NAME = :name, CITY = :city, ADDRESS = :address, CONTACT_NUMBER = :contact WHERE THEATER_ID = :id";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("name", txtTheaterName.Text),
                        new OracleParameter("city", txtCity.Text),
                        new OracleParameter("address", txtAddress.Text),
                        new OracleParameter("contact", txtContact.Text),
                        new OracleParameter("id", hfTheaterId.Value)
                    });
                }
                ClearForm();
                LoadTheaters();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void gvTheaters_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditTheater")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataTable dt = DatabaseHelper.ExecuteQuery("SELECT * FROM THEATER WHERE THEATER_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfTheaterId.Value = row["THEATER_ID"].ToString();
                    txtTheaterName.Text = row["THEATER_NAME"].ToString();
                    txtCity.Text = row["CITY"].ToString();
                    txtAddress.Text = row["ADDRESS"].ToString();
                    txtContact.Text = row["CONTACT_NUMBER"].ToString();
                    btnSave.Text = "Update Theater";
                }
            }
        }

        protected void gvTheaters_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvTheaters.DataKeys[e.RowIndex].Value);
                DatabaseHelper.ExecuteNonQuery("DELETE FROM THEATER WHERE THEATER_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                LoadTheaters();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfTheaterId.Value = "";
            txtTheaterName.Text = "";
            txtCity.Text = "";
            txtAddress.Text = "";
            txtContact.Text = "";
            btnSave.Text = "Save Theater";
        }
    }
}
