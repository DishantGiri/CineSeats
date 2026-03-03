<%@ Page Title="Manage Halls" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageHalls.aspx.cs" Inherits="CineSeats.ManageHalls" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <h2 class="display-5 mb-4">Hall Management</h2>

            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h4>Hall Details</h4>
                        <asp:HiddenField ID="hfHallId" runat="server" />
                        <div class="mb-3">
                            <label class="form-label">Theater</label>
                            <asp:DropDownList ID="ddlTheater" runat="server"
                                CssClass="form-select bg-dark text-white border-secondary"></asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Hall Name</label>
                            <asp:TextBox ID="txtHallName" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capacity</label>
                            <asp:TextBox ID="txtCapacity" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary" TextMode="Number">
                            </asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Hall Type</label>
                            <asp:TextBox ID="txtHallType" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"
                                placeholder="e.g. IMAX, 4DX"></asp:TextBox>
                        </div>
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Save Hall"
                                CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                                OnClick="btnClear_Click" />
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card p-3">
                        <div class="table-responsive">
                            <asp:GridView ID="gvHalls" runat="server" AutoGenerateColumns="False"
                                CssClass="grid-view table-borderless" OnRowCommand="gvHalls_RowCommand"
                                OnRowDeleting="gvHalls_RowDeleting" DataKeyNames="HALL_ID" AllowPaging="True"
                                PageSize="5" OnPageIndexChanging="gvHalls_PageIndexChanging">
                                <PagerStyle CssClass="grid-pager" />
                                <Columns>
                                    <asp:BoundField DataField="HALL_ID" HeaderText="ID" />
                                    <asp:BoundField DataField="THEATER_NAME" HeaderText="Theater" />
                                    <asp:BoundField DataField="HALL_NAME" HeaderText="Hall Name" />
                                    <asp:BoundField DataField="CAPACITY" HeaderText="Capacity" />
                                    <asp:BoundField DataField="HALL_TYPE" HeaderText="Type" />
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditHall"
                                                CommandArgument='<%# Eval("HALL_ID") %>'
                                                CssClass="btn btn-sm btn-outline-info">Edit</asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                                CssClass="btn btn-sm btn-outline-danger"
                                                OnClientClick="return confirm('Delete this hall?');">Delete
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </asp:Content>