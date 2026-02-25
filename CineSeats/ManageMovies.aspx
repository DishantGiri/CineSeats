<%@ Page Title="Manage Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageMovies.aspx.cs" Inherits="CineSeats.ManageMovies" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <h2 class="display-5 mb-4">Movie Management</h2>

            <div class="row">
                <div class="col-md-4">
                    <div class="card p-3">
                        <h4>Movie Details</h4>
                        <asp:HiddenField ID="hfMovieId" runat="server" />
                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <asp:TextBox ID="txtTitle" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Duration (mins)</label>
                            <asp:TextBox ID="txtDuration" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary" TextMode="Number">
                            </asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Language</label>
                            <asp:TextBox ID="txtLanguage" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Genre</label>
                            <asp:TextBox ID="txtGenre" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Release Date</label>
                            <asp:TextBox ID="txtReleaseDate" runat="server"
                                CssClass="form-control bg-dark text-white border-secondary" TextMode="Date">
                            </asp:TextBox>
                        </div>
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Save Movie"
                                CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary"
                                OnClick="btnClear_Click" />
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card p-3">
                        <asp:GridView ID="gvMovies" runat="server" AutoGenerateColumns="False" CssClass="grid-view"
                            OnRowCommand="gvMovies_RowCommand" OnRowDeleting="gvMovies_RowDeleting"
                            DataKeyNames="MOVIE_ID">
                            <Columns>
                                <asp:BoundField DataField="MOVIE_ID" HeaderText="ID" />
                                <asp:BoundField DataField="TITLE" HeaderText="Title" />
                                <asp:BoundField DataField="LANGUAGE" HeaderText="Language" />
                                <asp:BoundField DataField="GENRE" HeaderText="Genre" />
                                <asp:BoundField DataField="RELEASE_DATE" HeaderText="Release Date"
                                    DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditMovie"
                                            CommandArgument='<%# Eval("MOVIE_ID") %>'
                                            CssClass="btn btn-sm btn-outline-info">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                            CssClass="btn btn-sm btn-outline-danger"
                                            OnClientClick="return confirm('Delete this movie?');">Delete
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