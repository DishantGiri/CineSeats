<%@ Page Title="Occupancy Analytics" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Occupancy.aspx.cs" Inherits="CineSeats.Reports.Occupancy" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <h2 class="display-5 mb-4">Movie Occupancy Analytics</h2>

            <div class="card p-4 mb-4">
                <div class="row align-items-end">
                    <div class="col-md-8">
                        <label class="form-label">Select Movie</label>
                        <asp:DropDownList ID="ddlMovie" runat="server"
                            CssClass="form-select bg-dark text-white border-secondary"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <asp:Button ID="btnAnalyze" runat="server" Text="Analyze Top 3" CssClass="btn btn-primary w-100"
                            OnClick="btnAnalyze_Click" />
                    </div>
                </div>
            </div>

            <asp:Panel ID="pnlResults" runat="server" Visible="false">
                <div class="row">
                    <div class="col-12">
                        <h4 class="mb-3">Top 3 Theaters &amp; Halls for this Movie</h4>
                        <div class="row">
                            <asp:Repeater ID="rptTop3" runat="server">
                                <ItemTemplate>
                                    <div class="col-md-4 mb-3">
                                        <div class="card stat-card border-0">
                                            <div class="card-body">
                                                <h5 class="card-title text-uppercase text-muted small">
                                                    <%# Eval("THEATER_NAME") %>
                                                </h5>
                                                <p class="h4">
                                                    <%# Eval("HALL_NAME") %>
                                                </p>
                                                <span class="stat-value text-primary">
                                                    <%# Eval("OCCUPANCY_PERCENT", "{0:F1}" ) %>%
                                                </span>
                                                <span class="stat-label">Seat Occupancy</span>
                                                <div class="progress mt-2"
                                                    style="height: 10px; background: rgba(255,255,255,0.1);">
                                                    <div class="progress-bar bg-primary" role="progressbar"
                                                        style='<%# GetProgressWidth(Eval("OCCUPANCY_PERCENT")) %>'>
                                                    </div>
                                                </div>
                                                <p class="mt-2 mb-0 small text-muted">
                                                    <%# Eval("SOLD_TICKETS") %> Tickets Sold / <%# Eval("CAPACITY") %>
                                                            Seats
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>

                <div class="card p-3 mt-4">
                    <h4>All Hall Analytics for this Movie</h4>
                    <asp:GridView ID="gvAllOccupancy" runat="server" AutoGenerateColumns="False" CssClass="grid-view">
                        <Columns>
                            <asp:BoundField DataField="THEATER_NAME" HeaderText="Theater" />
                            <asp:BoundField DataField="HALL_NAME" HeaderText="Hall" />
                            <asp:BoundField DataField="CAPACITY" HeaderText="Capacity" />
                            <asp:BoundField DataField="SOLD_TICKETS" HeaderText="Sold" />
                            <asp:TemplateField HeaderText="Occupancy %">
                                <ItemTemplate>
                                    <strong>
                                        <%# Eval("OCCUPANCY_PERCENT", "{0:F1}" ) %>%
                                    </strong>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center p-3">No occupancy data available for this movie.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </asp:Panel>
        </div>
    </asp:Content>