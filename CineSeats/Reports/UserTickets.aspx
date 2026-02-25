<%@ Page Title="User Tickets Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="UserTickets.aspx.cs" Inherits="CineSeats.Reports.UserTickets" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <h2 class="display-5 mb-4">User Ticket Report</h2>

            <div class="card p-4 mb-4">
                <div class="row align-items-end">
                    <div class="col-md-6">
                        <label class="form-label">Select User</label>
                        <asp:DropDownList ID="ddlUser" runat="server"
                            CssClass="form-select bg-dark text-white border-secondary"></asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnViewReport" runat="server" Text="Generate Report"
                            CssClass="btn btn-primary w-100" OnClick="btnViewReport_Click" />
                    </div>
                </div>
                <div class="mt-2 text-muted fst-italic">
                    * Showing tickets bought in the last 6 months.
                </div>
            </div>

            <asp:Panel ID="pnlReport" runat="server" Visible="false">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card p-3 mb-4">
                            <h4>User Details</h4>
                            <hr class="border-secondary" />
                            <p><strong>Name:</strong>
                                <asp:Literal ID="litUserName" runat="server"></asp:Literal>
                            </p>
                            <p><strong>Email:</strong>
                                <asp:Literal ID="litEmail" runat="server"></asp:Literal>
                            </p>
                            <p><strong>Phone:</strong>
                                <asp:Literal ID="litPhone" runat="server"></asp:Literal>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="card p-3">
                            <h4>Ticket History</h4>
                            <asp:GridView ID="gvUserTickets" runat="server" AutoGenerateColumns="False"
                                CssClass="grid-view">
                                <Columns>
                                    <asp:BoundField DataField="TICKET_ID" HeaderText="Ticket ID" />
                                    <asp:BoundField DataField="TITLE" HeaderText="Movie" />
                                    <asp:BoundField DataField="SHOW_DATE" HeaderText="Show Date"
                                        DataFormatString="{0:yyyy-MM-dd}" />
                                    <asp:BoundField DataField="SHOW_TIME" HeaderText="Time" />
                                    <asp:BoundField DataField="SEAT_NUMBER" HeaderText="Seat" />
                                    <asp:BoundField DataField="TICKET_STATUS" HeaderText="Status" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center p-3">No tickets found for this user in the last 6 months.
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </asp:Content>