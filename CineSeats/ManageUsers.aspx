<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageUsers.aspx.cs" Inherits="CineSeats.ManageUsers" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <div class="row">
                <div class="col-12">
                    <h2 class="display-5 mb-4">User Management</h2>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h4>Add / Edit User</h4>
                        <asp:HiddenField ID="hfUserId" runat="server" />
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <asp:TextBox ID="txtPhone" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">User Type</label>
                            <asp:DropDownList ID="ddlUserType" runat="server"
                                CssClass="form-select bg-dark text-white border-secondary">
                                <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                                <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                                <asp:ListItem Text="Staff" Value="Staff"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Save User"
                                CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                                OnClick="btnClear_Click" />
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card p-3">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4>Registered Users</h4>
                            <div class="d-flex gap-2">
                                <asp:TextBox ID="txtSearch" runat="server"
                                    CssClass="form-control bg-dark text-white border-secondary"
                                    placeholder="Search users..."></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Search"
                                    CssClass="btn btn-outline-primary" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                        <div class="table-responsive">
                            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
                                CssClass="grid-view table-borderless" OnRowCommand="gvUsers_RowCommand"
                                OnRowDeleting="gvUsers_RowDeleting" DataKeyNames="USER_ID" AllowPaging="True"
                                PageSize="5" OnPageIndexChanging="gvUsers_PageIndexChanging">
                                <PagerStyle CssClass="grid-pager" />
                                <Columns>
                                    <asp:BoundField DataField="USER_ID" HeaderText="ID" />
                                    <asp:BoundField DataField="FULL_NAME" HeaderText="Full Name" />
                                    <asp:BoundField DataField="EMAIL" HeaderText="Email" />
                                    <asp:BoundField DataField="PHONE" HeaderText="Phone" />
                                    <asp:BoundField DataField="USER_TYPE" HeaderText="Type" />
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditUser"
                                                CommandArgument='<%# Eval("USER_ID") %>'
                                                CssClass="btn btn-sm btn-outline-info">Edit</asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                                CssClass="btn btn-sm btn-outline-danger"
                                                OnClientClick="return confirm('Delete this user?');">Delete
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