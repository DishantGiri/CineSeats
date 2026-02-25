using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats
{
    public partial class ManageShowtimes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDropdowns();
                LoadShowtimes();
            }
        }

        private void LoadDropdowns()
        {
            ddlMovie.DataSource = DatabaseHelper.ExecuteQuery("SELECT MOVIE_ID, TITLE FROM MOVIE");
            ddlMovie.DataTextField = "TITLE";
            ddlMovie.DataValueField = "MOVIE_ID";
            ddlMovie.DataBind();
            ddlMovie.Items.Insert(0, new ListItem("-- Select Movie --", ""));

            ddlHall.DataSource = DatabaseHelper.ExecuteQuery("SELECT HALL_ID, HALL_NAME FROM HALL");
            ddlHall.DataTextField = "HALL_NAME";
            ddlHall.DataValueField = "HALL_ID";
            ddlHall.DataBind();
            ddlHall.Items.Insert(0, new ListItem("-- Select Hall --", ""));
        }

        private void LoadShowtimes()
        {
            try
            {
                string query = @"SELECT s.*, m.TITLE, h.HALL_NAME 
                                FROM SHOWTIME s 
                                JOIN MOVIE m ON s.MOVIE_ID = m.MOVIE_ID 
                                JOIN HALL h ON s.HALL_ID = h.HALL_ID 
                                ORDER BY s.SHOW_DATE DESC, s.SHOW_TIME DESC";
                gvShowtimes.DataSource = DatabaseHelper.ExecuteQuery(query);
                gvShowtimes.DataBind();
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
                DateTime showDate = DateTime.Parse(txtShowDate.Text);
                string isHoliday = chkIsHoliday.Checked ? "Y" : "N";

                if (string.IsNullOrEmpty(hfShowtimeId.Value))
                {
                    string query = @"INSERT INTO SHOWTIME (SHOWTIME_ID, MOVIE_ID, HALL_ID, SHOW_DATE, SHOW_TIME, TICKET_PRICE, IS_HOLIDAY) 
                                    VALUES (SHOWTIME_ID_SEQ.NEXTVAL, :movieId, :hallId, :sDate, :sTime, :price, :holiday)";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("movieId", ddlMovie.SelectedValue),
                        new OracleParameter("hallId", ddlHall.SelectedValue),
                        new OracleParameter("sDate", showDate),
                        new OracleParameter("sTime", txtShowTime.Text),
                        new OracleParameter("price", txtPrice.Text),
                        new OracleParameter("holiday", isHoliday)
                    });
                }
                else
                {
                    string query = @"UPDATE SHOWTIME SET MOVIE_ID = :movieId, HALL_ID = :hallId, SHOW_DATE = :sDate, 
                                    SHOW_TIME = :sTime, TICKET_PRICE = :price, IS_HOLIDAY = :holiday WHERE SHOWTIME_ID = :id";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("movieId", ddlMovie.SelectedValue),
                        new OracleParameter("hallId", ddlHall.SelectedValue),
                        new OracleParameter("sDate", showDate),
                        new OracleParameter("sTime", txtShowTime.Text),
                        new OracleParameter("price", txtPrice.Text),
                        new OracleParameter("holiday", isHoliday),
                        new OracleParameter("id", hfShowtimeId.Value)
                    });
                }
                ClearForm();
                LoadShowtimes();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void gvShowtimes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditShowtime")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataTable dt = DatabaseHelper.ExecuteQuery("SELECT * FROM SHOWTIME WHERE SHOWTIME_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfShowtimeId.Value = row["SHOWTIME_ID"].ToString();
                    ddlMovie.SelectedValue = row["MOVIE_ID"].ToString();
                    ddlHall.SelectedValue = row["HALL_ID"].ToString();
                    txtShowDate.Text = Convert.ToDateTime(row["SHOW_DATE"]).ToString("yyyy-MM-dd");
                    txtShowTime.Text = row["SHOW_TIME"].ToString();
                    txtPrice.Text = row["TICKET_PRICE"].ToString();
                    chkIsHoliday.Checked = row["IS_HOLIDAY"].ToString() == "Y";
                    btnSave.Text = "Update Showtime";
                }
            }
        }

        protected void gvShowtimes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvShowtimes.DataKeys[e.RowIndex].Value);
                DatabaseHelper.ExecuteNonQuery("DELETE FROM SHOWTIME WHERE SHOWTIME_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                LoadShowtimes();
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
            hfShowtimeId.Value = "";
            ddlMovie.SelectedIndex = 0;
            ddlHall.SelectedIndex = 0;
            txtShowDate.Text = "";
            txtShowTime.Text = "";
            txtPrice.Text = "";
            chkIsHoliday.Checked = false;
            btnSave.Text = "Save Showtime";
        }
    }
}
