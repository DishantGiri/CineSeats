<%@ Page Title="Theater Movies Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="TheaterMovies.aspx.cs" Inherits="CineSeats.Reports.TheaterMovies" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container mt-4">
            <h2 class="display-5 mb-4">Theater Showtime Schedule</h2>

            <div class="card p-4 mb-4">
                <div class="row align-items-end">
                    <div class="col-md-5">
                        <label class="form-label">Select Theater</label>
                        <asp:DropDownList ID="ddlTheater" runat="server"
                            CssClass="form-select bg-dark text-white border-secondary" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlTheater_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label">Select Hall</label>
                        <asp:DropDownList ID="ddlHall" runat="server"
                            CssClass="form-select bg-dark text-white border-secondary"></asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-primary w-100"
                            OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <div class="card p-3">
                <asp:GridView ID="gvSchedule" runat="server" AutoGenerateColumns="False" CssClass="grid-view">
                    <Columns>
                        <asp:BoundField DataField="TITLE" HeaderText="Movie Title" />
                        <asp:BoundField DataField="LANGUAGE" HeaderText="Language" />
                        <asp:BoundField DataField="GENRE" HeaderText="Genre" />
                        <asp:BoundField DataField="SHOW_DATE" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                        <asp:BoundField DataField="SHOW_TIME" HeaderText="Time" />
                        <asp:BoundField DataField="TICKET_PRICE" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:TemplateField HeaderText="Holiday">
                            <ItemTemplate>
                                <span
                                    class='badge <%# Eval("IS_HOLIDAY").ToString() == "Y" ? "bg-danger" : "bg-success" %>'>
                                    <%# Eval("IS_HOLIDAY").ToString()=="Y" ? "Yes" : "No" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center p-3">No movies scheduled for this theater/hall.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </asp:Content>