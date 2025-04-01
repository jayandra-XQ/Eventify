<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.VenueDAO, model.Venue, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        h1 {
            color: #123A85;
            text-align: left;
            margin: 30px 0;
        }
        main {
            flex: 1;
            padding: 40px 20px;
        }
        .venue-container {
            max-width: 1600px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .venue-image {
            width: 200px;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .table thead th {
            background-color: #2D3378;
            color: white;
            font-weight: 600;
            border-bottom: 2px solid #D7B687;
        }
        .book-button {
            background-color: #2D3378;
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            transition: all 0.3s ease;
            border: none;
        }
        .book-button:hover {
            background-color: #1A1F4D;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .cost-badge {
            background-color: #D7B687;
            color: #2D3378;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <%
        // Fetch all venues from database
        VenueDAO venueDAO = new VenueDAO();
        List<Venue> venues = venueDAO.getAllVenues();
    %>

    <header>
        <h1>EVENTIFY!!</h1>
    </header>
    
    <%@ include file="components/navbar.jsp" %>

    <main>
        <div class="venue-container">
            <h2 class="mb-4" style="color: #2D3378;">Available Events</h2>
            
            <% if (venues.isEmpty()) { %>
                <div class="alert alert-info" role="alert">
                    No venues available at the moment. Please check back later!
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Venue</th>
                                <th>Location</th>
                                <th>Capacity</th>
                                <th>Price</th>
                                <th>Event Date</th>
                                <th>Event Type</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Venue venue : venues) { %>
                                <tr>
                                    <td>
                                        <% if (venue.getPhotoUrl() != null && !venue.getPhotoUrl().isEmpty()) { %>
                                            <img src="uploads/<%= venue.getPhotoUrl() %>" 
                                                alt="Venue Image" 
                                                class="venue-image">
                                        <% } else { %>
                                            <div class="venue-image bg-secondary"></div>
                                        <% } %>
                                    </td>
                                    <td class="fw-bold" style="color: #2D3378;"><%= venue.getLocation() %></td>
                                    <td><%= venue.getCapacity() %> people</td>
                                    <td>
                                        <span class="cost-badge">
                                            ₹<%= String.format("%,.2f", venue.getCost()) %>
                                        </span>
                                    </td>
                                    <td><%= venue.getEventDate() %></td>
                                    <td class="fst-italic"><%= venue.getEventType() %></td>
                                    <td>
                                        <button class="book-button" 
                                                onclick="redirectToPayment(<%= venue.getId() %>)">
                                            Book Now
                                        </button>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
    </main>

    <script>
        function redirectToPayment(venueId) {
            window.location.href = "PaymentPage.jsp?venueId=" + venueId;
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <footer class="mt-auto">
        <%@ include file="components/footer.jsp" %>
    </footer>
</body>
</html>