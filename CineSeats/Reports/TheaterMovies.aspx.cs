using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats.Reports
{
    public partial class TheaterMovies : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTheaters();
                ddlHall.Items.Insert(0, new ListItem("-- Select Theater First --", ""));
            }
        }

        private void LoadTheaters()
        {
            ddlTheater.DataSource = DatabaseHelper.ExecuteQuery("SELECT THEATER_ID, THEATER_NAME FROM THEATER ORDER BY THEATER_NAME");
            ddlTheater.DataTextField = "THEATER_NAME";
            ddlTheater.DataValueField = "THEATER_ID";
            ddlTheater.DataBind();
            ddlTheater.Items.Insert(0, new ListItem("-- Select Theater --", ""));
        }

        protected void ddlTheater_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlTheater.SelectedValue))
            {
                ddlHall.Items.Clear();
                ddlHall.Items.Insert(0, new ListItem("-- Select Theater First --", ""));
                return;
            }

            int theaterId = int.Parse(ddlTheater.SelectedValue);
            ddlHall.DataSource = DatabaseHelper.ExecuteQuery("SELECT HALL_ID, HALL_NAME FROM HALL WHERE THEATER_ID = :tid ORDER BY HALL_NAME", new OracleParameter[] { new OracleParameter("tid", theaterId) });
            ddlHall.DataTextField = "HALL_NAME";
            ddlHall.DataValueField = "HALL_ID";
            ddlHall.DataBind();
            ddlHall.Items.Insert(0, new ListItem("All Halls", "0"));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlTheater.SelectedValue)) return;

            string query = @"SELECT m.TITLE, m.LANGUAGE, m.GENRE, s.SHOW_DATE, s.SHOW_TIME, s.TICKET_PRICE, s.IS_HOLIDAY 
                            FROM SHOWTIME s 
                            JOIN MOVIE m ON s.MOVIE_ID = m.MOVIE_ID 
                            JOIN HALL h ON s.HALL_ID = h.HALL_ID 
                            WHERE h.THEATER_ID = :tid";
            
            OracleParameter[] cmdParams;
            if (ddlHall.SelectedValue != "0" && !string.IsNullOrEmpty(ddlHall.SelectedValue))
            {
                query += " AND s.HALL_ID = :hid";
                cmdParams = new OracleParameter[] { 
                    new OracleParameter("tid", ddlTheater.SelectedValue),
                    new OracleParameter("hid", ddlHall.SelectedValue)
                };
            }
            else
            {
                cmdParams = new OracleParameter[] { new OracleParameter("tid", ddlTheater.SelectedValue) };
            }

            query += " ORDER BY s.SHOW_DATE, s.SHOW_TIME";
            gvSchedule.DataSource = DatabaseHelper.ExecuteQuery(query, cmdParams);
            gvSchedule.DataBind();
        }
    }
}
