<%@ Page Title="Manage Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageMovies.aspx.cs" Inherits="CineSeats.ManageMovies" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">

        <div class="cs-page-header">
            <div class="cs-page-icon"><i class="bi bi-camera-reels"></i></div>
            <div>
                <h2>Movie Management</h2>
                <p class="text-muted mb-0" style="font-size:0.82rem;">Add, edit or remove movies from the catalog</p>
            </div>
        </div>

        <div class="row g-3">
            <!-- Form Panel -->
            <div class="col-lg-4">
                <div class="card p-3">
                    <div class="d-flex align-items-center gap-2 mb-3">
                        <i class="bi bi-pencil-square text-danger"></i>
                        <h6 class="mb-0 fw-semibold">Movie Details</h6>
                    </div>
                    <asp:HiddenField ID="hfMovieId" runat="server" />
                    <div class="mb-3">
                        <label class="form-label">Title</label>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Duration (mins)</label>
                        <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Language</label>
                        <asp:TextBox ID="txtLanguage" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Genre</label>
                        <asp:TextBox ID="txtGenre" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Release Date</label>
                        <asp:TextBox ID="txtReleaseDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="d-flex gap-2 mt-2">
                        <asp:Button ID="btnSave" runat="server" Text="Save Movie" CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary" OnClick="btnClear_Click" />
                    </div>
                </div>
            </div>

            <!-- Grid Panel -->
            <div class="col-lg-8">
                <div class="card p-3">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div class="d-flex align-items-center gap-2">
                            <i class="bi bi-table text-danger"></i>
                            <h6 class="mb-0 fw-semibold">Movie Catalog</h6>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvMovies" runat="server" AutoGenerateColumns="False"
                            CssClass="grid-view" OnRowCommand="gvMovies_RowCommand"
                            OnRowDeleting="gvMovies_RowDeleting" DataKeyNames="MOVIE_ID"
                            AllowPaging="True" PageSize="7" OnPageIndexChanging="gvMovies_PageIndexChanging">
                            <PagerStyle CssClass="grid-pager" />
                            <Columns>
                                <asp:BoundField DataField="MOVIE_ID" HeaderText="ID" />
                                <asp:BoundField DataField="TITLE" HeaderText="Title" />
                                <asp:BoundField DataField="LANGUAGE" HeaderText="Language" />
                                <asp:BoundField DataField="GENRE" HeaderText="Genre" />
                                <asp:BoundField DataField="RELEASE_DATE" HeaderText="Release" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" CommandName="EditMovie"
                                            CommandArgument='<%# Eval("MOVIE_ID") %>'
                                            CssClass="btn btn-sm btn-outline-info me-1">Edit</asp:LinkButton>
                                        <asp:LinkButton runat="server" CommandName="Delete"
                                            CssClass="btn btn-sm btn-outline-danger"
                                            OnClientClick="return confirm('Delete?');">Del</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="text-center py-5 text-muted">
                                    <i class="bi bi-camera-reels" style="font-size:2.5rem;opacity:0.3;"></i>
                                    <p class="mt-2 mb-0">No movies found. Add one using the form.</p>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>