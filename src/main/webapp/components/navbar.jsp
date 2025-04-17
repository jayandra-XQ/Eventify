<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Navbar</title>
    <style>
        .navbar {
            height: 83px; 
            background-color: #676B98; 
        }
        .navbar-brand, .navbar-nav .nav-link {
            color: #2D3378 !important; 
            font-weight:500;
        }
        .navbar-brand{
            font-size: 24px;
            font-weight: 700;
        }
        .nav-item .nav-link{
            font-size: 20px;
        }
        .navbar-nav .nav-link.active {
            color: #2D3378 !important;
        }
        .dropdown-menu {
            background-color: #FFFFFF; 
        }
        .dropdown-item {
            color: #2D3378; 
        }
        .btn{
            background-color: #2D3378;
            color: white;
            border-radius: 30px;
            padding: 10px 20px;
        }
        .btn:hover{
            background-color: #2D3378;
            color: white;
        }
        .navbar-nav .nav-item {
            margin-left: 20px;
        }
        .navbar-toggler{
            border: none;
        }
    </style>
</head>
<body>
   <nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" 
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0" id="nav-items">
                <li class="nav-item"><a class="nav-link" href="./index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="./AboutPage.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="./CategoriesPage.jsp">Categories</a></li>
            </ul>
            <div class="d-flex" id="auth-buttons">
                <div class="dropdown">
                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" 
                            aria-expanded="false" id="authText">
                        Let's Connect
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" id="authMenu">
                        <li><a class="dropdown-item" href="./LoginPage.jsp">Login</a></li>
                        <li><a class="dropdown-item" href="./RegisterPage.jsp">Sign Up</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<%-- Server-side session checks --%>
<%
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = (role != null && !role.isEmpty());
    User user = (User) session.getAttribute("user");
%>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const navItems = document.getElementById('nav-items');
        const authText = document.getElementById('authText');
        const authMenu = document.getElementById('authMenu');

        // Get server-side values
        const isLoggedIn = <%= isLoggedIn %>;
        const userRole = '<%= role != null ? role : "" %>';
        const firstName = '<%= user != null && user.getFirstName() != null ? user.getFirstName() : "" %>';

        if (isLoggedIn) {
            // Add role-specific menu items
            if (userRole === 'admin') {
                navItems.innerHTML += `
                    <li class="nav-item"><a class="nav-link" href="./UserListPage.jsp">User List</a></li>
                    <li class="nav-item"><a class="nav-link" href="./AllBookingsPage.jsp">Booking History</a></li>
                    <li class="nav-item"><a class="nav-link" href="./VenuePage.jsp">Venue</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="eventDropdown" role="button" 
                           data-bs-toggle="dropdown" aria-expanded="false">
                            Event Type
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="eventDropdown">
                            <li><a class="dropdown-item" href="./AddEventPage.jsp">Add Event</a></li>
                            <li><a class="dropdown-item" href="./EventListPage.jsp">Event List</a></li>
                        </ul>
                    </li>
                `;
            } else if (userRole === 'user') {
                navItems.innerHTML += `
                    <li class="nav-item"><a class="nav-link" href="./BookPage.jsp">Book</a></li>
                    <li class="nav-item"><a class="nav-link" href="./BookingHistoryPage.jsp">Booking History</a></li>
                    <li class="nav-item"><a class="nav-link" href="./ContactPage.jsp">Contact</a></li>
                `;
            }

            // Update auth dropdown
            authText.innerText = firstName || 'Profile';
            authMenu.innerHTML = `
                <li><a class="dropdown-item" href="./ProfilePage.jsp">Profile</a></li>
                <li><a class="dropdown-item" href="./logout" id="logoutBtn">Logout</a></li>
            `;
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" 
        crossorigin="anonymous"></script>
</body>
</html>