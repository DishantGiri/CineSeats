using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats
{
    public partial class ManageHalls : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTheaters();
                LoadHalls();
            }
        }

        private void LoadTheaters()
        {
            DataTable dt = DatabaseHelper.ExecuteQuery("SELECT THEATER_ID, THEATER_NAME FROM THEATER");
            ddlTheater.DataSource = dt;
            ddlTheater.DataTextField = "THEATER_NAME";
            ddlTheater.DataValueField = "THEATER_ID";
            ddlTheater.DataBind();
            ddlTheater.Items.Insert(0, new ListItem("-- Select Theater --", ""));
        }

        private void LoadHalls()
        {
            try
            {
                string query = "SELECT h.*, t.THEATER_NAME FROM HALL h JOIN THEATER t ON h.THEATER_ID = t.THEATER_ID ORDER BY h.HALL_ID DESC";
                gvHalls.DataSource = DatabaseHelper.ExecuteQuery(query);
                gvHalls.DataBind();
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
                if (string.IsNullOrEmpty(hfHallId.Value))
                {
                    string query = "INSERT INTO HALL (HALL_ID, HALL_NAME, CAPACITY, HALL_TYPE, THEATER_ID) VALUES (HALL_ID_SEQ.NEXTVAL, :name, :cap, :type, :theaterId)";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("name", txtHallName.Text),
                        new OracleParameter("cap", txtCapacity.Text),
                        new OracleParameter("type", txtHallType.Text),
                        new OracleParameter("theaterId", ddlTheater.SelectedValue)
                    });
                }
                else
                {
                    string query = "UPDATE HALL SET HALL_NAME = :name, CAPACITY = :cap, HALL_TYPE = :type, THEATER_ID = :theaterId WHERE HALL_ID = :id";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("name", txtHallName.Text),
                        new OracleParameter("cap", txtCapacity.Text),
                        new OracleParameter("type", txtHallType.Text),
                        new OracleParameter("theaterId", ddlTheater.SelectedValue),
                        new OracleParameter("id", hfHallId.Value)
                    });
                }
                ClearForm();
                LoadHalls();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void gvHalls_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditHall")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataTable dt = DatabaseHelper.ExecuteQuery("SELECT * FROM HALL WHERE HALL_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfHallId.Value = row["HALL_ID"].ToString();
                    txtHallName.Text = row["HALL_NAME"].ToString();
                    txtCapacity.Text = row["CAPACITY"].ToString();
                    txtHallType.Text = row["HALL_TYPE"].ToString();
                    ddlTheater.SelectedValue = row["THEATER_ID"].ToString();
                    btnSave.Text = "Update Hall";
                }
            }
        }

        protected void gvHalls_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvHalls.DataKeys[e.RowIndex].Value);
                DatabaseHelper.ExecuteNonQuery("DELETE FROM HALL WHERE HALL_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                LoadHalls();
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
            hfHallId.Value = "";
            txtHallName.Text = "";
            txtCapacity.Text = "";
            txtHallType.Text = "";
            ddlTheater.SelectedIndex = 0;
            btnSave.Text = "Save Hall";
        }
    }
}
