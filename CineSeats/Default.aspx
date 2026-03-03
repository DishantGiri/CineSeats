<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="CineSeats._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">

        <!-- Hero -->
        <div class="row mb-4 align-items-center">
            <div class="col">
                <h1 class="fw-800 mb-1" style="font-size:2rem; font-weight:800;">
                    Welcome back, <span style="color:#e50914;">Admin</span>
                </h1>
                <p class="text-muted mb-0" style="font-size:0.9rem;">
                    <i class="bi bi-clock me-1"></i>
                    <%= DateTime.Now.ToString("dddd, MMMM d yyyy — hh:mm tt") %>
                </p>
            </div>
            <div class="col-auto">
                <a href="ManageMovies" class="btn btn-primary px-4">
                    <i class="bi bi-plus-lg me-1"></i>Add Movie
                </a>
            </div>
        </div>

        <!-- Stats Row -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="card cs-stat-card cs-stat-red">
                    <i class="bi bi-people-fill cs-stat-icon"></i>
                    <span class="cs-stat-value text-white">
                        <asp:Literal ID="litTotalUsers" runat="server">0</asp:Literal>
                    </span>
                    <span class="cs-stat-label">Total Users</span>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card cs-stat-card cs-stat-blue">
                    <i class="bi bi-camera-reels-fill cs-stat-icon"></i>
                    <span class="cs-stat-value text-white">
                        <asp:Literal ID="litTotalMovies" runat="server">0</asp:Literal>
                    </span>
                    <span class="cs-stat-label">Active Movies</span>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card cs-stat-card cs-stat-green">
                    <i class="bi bi-building-fill cs-stat-icon"></i>
                    <span class="cs-stat-value text-white">
                        <asp:Literal ID="litTotalTheaters" runat="server">0</asp:Literal>
                    </span>
                    <span class="cs-stat-label">Theaters</span>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card cs-stat-card cs-stat-gold">
                    <i class="bi bi-ticket-perforated-fill cs-stat-icon"></i>
                    <span class="cs-stat-value text-white">
                        <asp:Literal ID="litTotalTickets" runat="server">0</asp:Literal>
                    </span>
                    <span class="cs-stat-label">Tickets Sold</span>
                </div>
            </div>
        </div>

        <!-- Quick Access + Reports -->
        <div class="row g-3 mb-4">
            <div class="col-md-6">
                <div class="card h-100">
                    <div class="card-header d-flex align-items-center gap-2">
                        <i class="bi bi-sliders text-danger"></i> Quick Management
                    </div>
                    <div class="list-group list-group-flush rounded-bottom">
                        <a href="ManageUsers" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-people me-2 text-muted"></i>Registered Users</span>
                            <span class="badge bg-danger">CRUD</span>
                        </a>
                        <a href="ManageTheaters" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-building me-2 text-muted"></i>Theaters</span>
                            <span class="badge bg-danger">CRUD</span>
                        </a>
                        <a href="ManageHalls" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-door-open me-2 text-muted"></i>Halls</span>
                            <span class="badge bg-danger">CRUD</span>
                        </a>
                        <a href="ManageMovies" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-camera-reels me-2 text-muted"></i>Movie Catalog</span>
                            <span class="badge bg-danger">CRUD</span>
                        </a>
                        <a href="ManageShowtimes" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-calendar-event me-2 text-muted"></i>Showtimes</span>
                            <span class="badge bg-danger">CRUD</span>
                        </a>
                        <a href="ManageTickets" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-ticket-perforated me-2 text-muted"></i>Tickets</span>
                            <span class="badge bg-danger">CRUD</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card h-100">
                    <div class="card-header d-flex align-items-center gap-2">
                        <i class="bi bi-bar-chart-line text-danger"></i> Analytics &amp; Reports
                    </div>
                    <div class="list-group list-group-flush rounded-bottom">
                        <a href="Reports/Occupancy" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-graph-up-arrow me-2 text-muted"></i>Seat Occupancy</span>
                            <span class="badge bg-primary">Report</span>
                        </a>
                        <a href="Reports/UserTickets" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-person-badge me-2 text-muted"></i>User Purchase History</span>
                            <span class="badge bg-primary">Report</span>
                        </a>
                        <a href="Reports/TheaterMovies" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-calendar3 me-2 text-muted"></i>Theater Schedule</span>
                            <span class="badge bg-primary">Report</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>