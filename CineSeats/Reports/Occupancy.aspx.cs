using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats.Reports
{
    public partial class Occupancy : Page
    {
        protected global::System.Web.UI.WebControls.DropDownList ddlMovie;
        protected global::System.Web.UI.WebControls.Button btnAnalyze;
        protected global::System.Web.UI.WebControls.Panel pnlResults;
        protected global::System.Web.UI.WebControls.Repeater rptTop3;
        protected global::System.Web.UI.WebControls.GridView gvAllOccupancy;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMovies();
            }
        }

        private void LoadMovies()
        {
            ddlMovie.DataSource = DatabaseHelper.ExecuteQuery("SELECT MOVIE_ID, TITLE FROM MOVIE ORDER BY TITLE");
            ddlMovie.DataTextField = "TITLE";
            ddlMovie.DataValueField = "MOVIE_ID";
            ddlMovie.DataBind();
            ddlMovie.Items.Insert(0, new ListItem("-- Select Movie to Analyze --", ""));
        }

        protected void btnAnalyze_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlMovie.SelectedValue)) return;

            int movieId = int.Parse(ddlMovie.SelectedValue);
            LoadOccupancyReport(movieId);
            pnlResults.Visible = true;
        }

        private void LoadOccupancyReport(int movieId)
        {
            string query = @"
                SELECT * FROM (
                    SELECT 
                        t.THEATER_NAME, 
                        h.HALL_NAME, 
                        h.CAPACITY,
                        (SELECT COUNT(*) FROM TICKET tk 
                         JOIN BOOKING b ON tk.BOOKING_ID = b.BOOKING_ID
                         WHERE b.SHOWTIME_ID = s.SHOWTIME_ID 
                         AND tk.TICKET_STATUS = 'Paid') as SOLD_TICKETS,
                        ((SELECT COUNT(*) FROM TICKET tk 
                          JOIN BOOKING b ON tk.BOOKING_ID = b.BOOKING_ID
                          WHERE b.SHOWTIME_ID = s.SHOWTIME_ID 
                          AND tk.TICKET_STATUS = 'Paid') / h.CAPACITY * 100) as OCCUPANCY_PERCENT
                    FROM SHOWTIME s
                    JOIN HALL h ON s.HALL_ID = h.HALL_ID
                    JOIN THEATER t ON h.THEATER_ID = t.THEATER_ID
                    WHERE s.MOVIE_ID = :mid
                ) ORDER BY OCCUPANCY_PERCENT DESC";

            DataTable dt = DatabaseHelper.ExecuteQuery(query, new OracleParameter[] { new OracleParameter("mid", movieId) });

            // Top 3 for repeater
            DataTable top3 = dt.Clone();
            for (int i = 0; i < dt.Rows.Count && i < 3; i++)
            {
                top3.ImportRow(dt.Rows[i]);
            }
            rptTop3.DataSource = top3;
            rptTop3.DataBind();

            // All for grid
            gvAllOccupancy.DataSource = dt;
            gvAllOccupancy.DataBind();
        }

        protected void gvAllOccupancy_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (string.IsNullOrEmpty(ddlMovie.SelectedValue)) return;
            gvAllOccupancy.PageIndex = e.NewPageIndex;
            LoadOccupancyReport(int.Parse(ddlMovie.SelectedValue));
        }

        public static Unit GetProgressUnit(object occupancyPercent)
        {
            if (occupancyPercent == null || occupancyPercent == DBNull.Value)
                return Unit.Percentage(0);
            double percent = 0;
            double.TryParse(occupancyPercent.ToString(), out percent);
            percent = Math.Max(0, Math.Min(percent, 100));
            return Unit.Percentage(percent);
        }
    }
}