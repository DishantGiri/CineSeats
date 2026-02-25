<%@ Page Title="Manage Theaters" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageTheaters.aspx.cs" Inherits="CineSeats.ManageTheaters" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <h2 class="display-5 mb-4">Theater Management</h2>

            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h4>Theater Details</h4>
                        <asp:HiddenField ID="hfTheaterId" runat="server" />
                        <div class="mb-3">
                            <label class="form-label">Theater Name</label>
                            <asp:TextBox ID="txtTheaterName" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">City</label>
                            <asp:TextBox ID="txtCity" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <asp:TextBox ID="txtAddress" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary" TextMode="MultiLine"
                                Rows="2"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contact Number</label>
                            <asp:TextBox ID="txtContact" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Save Theater"
                                CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                                OnClick="btnClear_Click" />
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card p-3">
                        <asp:GridView ID="gvTheaters" runat="server" AutoGenerateColumns="False" CssClass="grid-view"
                            OnRowCommand="gvTheaters_RowCommand" OnRowDeleting="gvTheaters_RowDeleting"
                            DataKeyNames="THEATER_ID">
                            <Columns>
                                <asp:BoundField DataField="THEATER_ID" HeaderText="ID" />
                                <asp:BoundField DataField="THEATER_NAME" HeaderText="Name" />
                                <asp:BoundField DataField="CITY" HeaderText="City" />
                                <asp:BoundField DataField="CONTACT_NUMBER" HeaderText="Contact" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditTheater"
                                            CommandArgument='<%# Eval("THEATER_ID") %>'
                                            CssClass="btn btn-sm btn-outline-info">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                            CssClass="btn btn-sm btn-outline-danger"
                                            OnClientClick="return confirm('Delete this theater?');">Delete
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