<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="CineSeats._Default" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-5">
            <div class="row mb-5">
                <div class="col-12 text-center">
                    <h1 class="display-3 fw-bold text-primary mb-2">CineSeats</h1>
                    <p class="lead text-muted">Centralized Cinema Management System</p>
                </div>
            </div>

            <!-- Stats Overview -->
            <div class="row g-4 mb-5">
                <div class="col-md-3">
                    <div class="card stat-card border-0 shadow-lg">
                        <div class="card-body">
                            <span class="stat-label">Total Users</span>
                            <span class="stat-value text-white">
                                <asp:Literal ID="litTotalUsers" runat="server">0</asp:Literal>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card border-0 shadow-lg"
                        style="background: linear-gradient(135deg, rgba(13, 110, 253, 0.2), rgba(0,0,0,0.5));">
                        <div class="card-body">
                            <span class="stat-label">Active Movies</span>
                            <span class="stat-value text-white">
                                <asp:Literal ID="litTotalMovies" runat="server">0</asp:Literal>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card border-0 shadow-lg"
                        style="background: linear-gradient(135deg, rgba(25, 135, 84, 0.2), rgba(0,0,0,0.5));">
                        <div class="card-body">
                            <span class="stat-label">Theaters</span>
                            <span class="stat-value text-white">
                                <asp:Literal ID="litTotalTheaters" runat="server">0</asp:Literal>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card stat-card border-0 shadow-lg"
                        style="background: linear-gradient(135deg, rgba(255, 193, 7, 0.2), rgba(0,0,0,0.5));">
                        <div class="card-body">
                            <span class="stat-label">Tickets Sold</span>
                            <span class="stat-value text-white">
                                <asp:Literal ID="litTotalTickets" runat="server">0</asp:Literal>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-5">
                <div class="col-md-6">
                    <div class="card h-100 p-4">
                        <h3>Quick Management</h3>
                        <p class="text-muted">Direct access to core system entities.</p>
                        <div class="list-group list-group-flush">
                            <a href="ManageUsers"
                                class="list-group-item list-group-item-action bg-transparent text-white border-secondary py-3 d-flex justify-content-between align-items-center">
                                Manage Registered Users
                                <span class="badge bg-primary rounded-pill">CRUD</span>
                            </a>
                            <a href="ManageMovies"
                                class="list-group-item list-group-item-action bg-transparent text-white border-secondary py-3 d-flex justify-content-between align-items-center">
                                Manage Movie Catalog
                                <span class="badge bg-primary rounded-pill">CRUD</span>
                            </a>
                            <a href="ManageShowtimes"
                                class="list-group-item list-group-item-action bg-transparent text-white border-secondary py-3 d-flex justify-content-between align-items-center">
                                Setup Showtimes
                                <span class="badge bg-primary rounded-pill">CRUD</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card h-100 p-4">
                        <h3>Insights & Reports</h3>
                        <p class="text-muted">Advanced analytics and business reports.</p>
                        <div class="list-group list-group-flush">
                            <a href="Reports/Occupancy"
                                class="list-group-item list-group-item-action bg-transparent text-white border-secondary py-3">
                                <i class="bi bi-graph-up-arrow me-2"></i> Theater Seat Occupancy
                            </a>
                            <a href="Reports/UserTickets"
                                class="list-group-item list-group-item-action bg-transparent text-white border-secondary py-3">
                                <i class="bi bi-person-badge me-2"></i> User Purchase History
                            </a>
                            <a href="Reports/TheaterMovies"
                                class="list-group-item list-group-item-action bg-transparent text-white border-secondary py-3">
                                <i class="bi bi-calendar3 me-2"></i> Theater Schedule View
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Background Decoration -->
        <style>
            body {
                background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.9)), url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=2070&auto=format&fit=crop');
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </asp:Content>