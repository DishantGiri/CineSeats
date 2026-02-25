<%@ Page Title="Manage Showtimes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageShowtimes.aspx.cs" Inherits="CineSeats.ManageShowtimes" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <h2 class="display-5 mb-4">Showtime Management</h2>

            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h4>Showtime Details</h4>
                        <asp:HiddenField ID="hfShowtimeId" runat="server" />
                        <div class="mb-3">
                            <label class="form-label">Movie</label>
                            <asp:DropDownList ID="ddlMovie" runat="server"
                                CssClass="form-select bg-dark text-white border-secondary"></asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Hall</label>
                            <asp:DropDownList ID="ddlHall" runat="server"
                                CssClass="form-select bg-dark text-white border-secondary"></asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Show Date</label>
                            <asp:TextBox ID="txtShowDate" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary" TextMode="Date">
                            </asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Show Time</label>
                            <asp:TextBox ID="txtShowTime" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary" placeholder="e.g. 14:00">
                            </asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ticket Price</label>
                            <asp:TextBox ID="txtPrice" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary" TextMode="Number"
                                step="0.01"></asp:TextBox>
                        </div>
                        <div class="mb-3 form-check">
                            <asp:CheckBox ID="chkIsHoliday" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label ms-2">Is Holiday?</label>
                        </div>
                        <div class="d-flex gap-2 mt-3">
                            <asp:Button ID="btnSave" runat="server" Text="Save Showtime"
                                CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                                OnClick="btnClear_Click" />
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card p-3">
                        <asp:GridView ID="gvShowtimes" runat="server" AutoGenerateColumns="False" CssClass="grid-view"
                            OnRowCommand="gvShowtimes_RowCommand" OnRowDeleting="gvShowtimes_RowDeleting"
                            DataKeyNames="SHOWTIME_ID">
                            <Columns>
                                <asp:BoundField DataField="SHOWTIME_ID" HeaderText="ID" />
                                <asp:BoundField DataField="TITLE" HeaderText="Movie" />
                                <asp:BoundField DataField="HALL_NAME" HeaderText="Hall" />
                                <asp:BoundField DataField="SHOW_DATE" HeaderText="Date"
                                    DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="SHOW_TIME" HeaderText="Time" />
                                <asp:BoundField DataField="TICKET_PRICE" HeaderText="Price" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditShowtime"
                                            CommandArgument='<%# Eval("SHOWTIME_ID") %>'
                                            CssClass="btn btn-sm btn-outline-info">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                            CssClass="btn btn-sm btn-outline-danger"
                                            OnClientClick="return confirm('Delete this showtime?');">Delete
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