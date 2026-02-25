<%@ Page Title="Manage Tickets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageTickets.aspx.cs" Inherits="CineSeats.ManageTickets" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <h2 class="display-5 mb-4">Ticket Management</h2>

            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h4>Ticket Details</h4>
                        <asp:HiddenField ID="hfTicketId" runat="server" />
                        <div class="mb-3">
                            <label class="form-label">Booking ID</label>
                            <asp:TextBox ID="txtBookingId" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary" TextMode="Number">
                            </asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Seat Number</label>
                            <asp:TextBox ID="txtSeatNumber" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server"
                                CssClass="form-select bg-dark text-white border-secondary">
                                <asp:ListItem Text="Valid" Value="Valid"></asp:ListItem>
                                <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                                <asp:ListItem Text="Used" Value="Used"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Save Ticket"
                                CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                                OnClick="btnClear_Click" />
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card p-3">
                        <asp:GridView ID="gvTickets" runat="server" AutoGenerateColumns="False" CssClass="grid-view"
                            OnRowCommand="gvTickets_RowCommand" OnRowDeleting="gvTickets_RowDeleting"
                            DataKeyNames="TICKET_ID">
                            <Columns>
                                <asp:BoundField DataField="TICKET_ID" HeaderText="Ticket ID" />
                                <asp:BoundField DataField="BOOKING_ID" HeaderText="Booking ID" />
                                <asp:BoundField DataField="SEAT_NUMBER" HeaderText="Seat" />
                                <asp:BoundField DataField="TICKET_STATUS" HeaderText="Status" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditTicket"
                                            CommandArgument='<%# Eval("TICKET_ID") %>'
                                            CssClass="btn btn-sm btn-outline-info">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                            CssClass="btn btn-sm btn-outline-danger"
                                            OnClientClick="return confirm('Delete this ticket?');">Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </asp:Content>