using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats
{
    public partial class ManageTickets : Page
    {
        protected global::System.Web.UI.WebControls.GridView gvTickets;
        protected global::System.Web.UI.WebControls.HiddenField hfTicketId;
        protected global::System.Web.UI.WebControls.TextBox txtBookingId;
        protected global::System.Web.UI.WebControls.TextBox txtSeatNumber;
        protected global::System.Web.UI.WebControls.DropDownList ddlStatus;
        protected global::System.Web.UI.WebControls.Button btnSave;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTickets();
            }
        }

        private void LoadTickets()
        {
            try
            {
                gvTickets.DataSource = DatabaseHelper.ExecuteQuery("SELECT * FROM TICKET ORDER BY TICKET_ID DESC");
                gvTickets.DataBind();
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
                if (string.IsNullOrEmpty(hfTicketId.Value))
                {
                    string query = "INSERT INTO TICKET (TICKET_ID, BOOKING_ID, SEAT_NUMBER, TICKET_STATUS) VALUES (TICKET_ID_SEQ.NEXTVAL, :bid, :seat, :status)";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("bid", txtBookingId.Text),
                        new OracleParameter("seat", txtSeatNumber.Text),
                        new OracleParameter("status", ddlStatus.SelectedValue)
                    });
                }
                else
                {
                    string query = "UPDATE TICKET SET BOOKING_ID = :bid, SEAT_NUMBER = :seat, TICKET_STATUS = :status WHERE TICKET_ID = :id";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("bid", txtBookingId.Text),
                        new OracleParameter("seat", txtSeatNumber.Text),
                        new OracleParameter("status", ddlStatus.SelectedValue),
                        new OracleParameter("id", hfTicketId.Value)
                    });
                }
                ClearForm();
                LoadTickets();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void gvTickets_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditTicket")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataTable dt = DatabaseHelper.ExecuteQuery("SELECT * FROM TICKET WHERE TICKET_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfTicketId.Value = row["TICKET_ID"].ToString();
                    txtBookingId.Text = row["BOOKING_ID"].ToString();
                    txtSeatNumber.Text = row["SEAT_NUMBER"].ToString();
                    ddlStatus.SelectedValue = row["TICKET_STATUS"].ToString();
                    btnSave.Text = "Update Ticket";
                }
            }
        }

        protected void gvTickets_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvTickets.DataKeys[e.RowIndex].Value);
                DatabaseHelper.ExecuteNonQuery("DELETE FROM TICKET WHERE TICKET_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                LoadTickets();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void gvTickets_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTickets.PageIndex = e.NewPageIndex;
            LoadTickets();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfTicketId.Value = "";
            txtBookingId.Text = "";
            txtSeatNumber.Text = "";
            ddlStatus.SelectedIndex = 0;
            btnSave.Text = "Save Ticket";
        }
    }
}
