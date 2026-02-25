using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats.Reports
{
    public partial class UserTickets : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            ddlUser.DataSource = DatabaseHelper.ExecuteQuery("SELECT USER_ID, FULL_NAME FROM USER_TABLE ORDER BY FULL_NAME");
            ddlUser.DataTextField = "FULL_NAME";
            ddlUser.DataValueField = "USER_ID";
            ddlUser.DataBind();
            ddlUser.Items.Insert(0, new ListItem("-- Select User --", ""));
        }

        protected void btnViewReport_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlUser.SelectedValue)) return;

            int userId = int.Parse(ddlUser.SelectedValue);
            LoadUserDetails(userId);
            LoadUserTickets(userId);
            pnlReport.Visible = true;
        }

        private void LoadUserDetails(int userId)
        {
            DataTable dt = DatabaseHelper.ExecuteQuery("SELECT * FROM USER_TABLE WHERE USER_ID = :id", new OracleParameter[] { new OracleParameter("id", userId) });
            if (dt.Rows.Count > 0)
            {
                litUserName.Text = dt.Rows[0]["FULL_NAME"].ToString();
                litEmail.Text = dt.Rows[0]["EMAIL"].ToString();
                litPhone.Text = dt.Rows[0]["PHONE"].ToString();
            }
        }

        private void LoadUserTickets(int userId)
        {
            string query = @"SELECT t.TICKET_ID, t.SEAT_NUMBER, t.TICKET_STATUS, m.TITLE, s.SHOW_DATE, s.SHOW_TIME 
                            FROM TICKET t 
                            JOIN BOOKING b ON t.BOOKING_ID = b.BOOKING_ID 
                            JOIN SHOWTIME s ON b.SHOWTIME_ID = s.SHOWTIME_ID 
                            JOIN MOVIE m ON s.MOVIE_ID = m.MOVIE_ID 
                            WHERE b.USER_ID = :uid 
                            AND b.BOOKING_TIME >= ADD_MONTHS(SYSDATE, -6) 
                            ORDER BY s.SHOW_DATE DESC";
            
            gvUserTickets.DataSource = DatabaseHelper.ExecuteQuery(query, new OracleParameter[] { new OracleParameter("uid", userId) });
            gvUserTickets.DataBind();
        }
    }
}
