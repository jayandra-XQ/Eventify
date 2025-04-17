<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookingDAO, dao.PaymentDAO, dao.VenueDAO, model.*, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .history-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 25px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.9em;
        }
        .success-badge {
            background-color: #28a745;
            color: white;
        }
        .failed-badge {
            background-color: #dc3545;
            color: white;
        }
        .card-masked {
            font-family: monospace;
            letter-spacing: 2px;
        }
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>

    <% 
    // Session check
    if(user == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }
    
    // Get messages
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    
    // Get bookings
    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> bookings = bookingDAO.getUserBookings(user.getId());
    %>

    <main class="history-container">
        <%-- Messages --%>
        <% if(success != null) { %>
            <div class="alert alert-success mb-4">
                <%= success %>
            </div>
        <% } %>
        
        <% if(error != null) { %>
            <div class="alert alert-danger mb-4">
                <%= error %>
            </div>
        <% } %>

        <h2 class="mb-4 text-center">Booking History</h2>
        
        <% if(bookings.isEmpty()) { %>
            <div class="alert alert-info text-center">
                No bookings found. Book your first event!
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                        
                            <th>Event Type</th>
                            <th>Ticket Number</th>
                            <th>Location</th>
                            <th>Booking Date</th>
                            <th>Amount</th>
                            <th>Card Used</th>
                           
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Booking booking : bookings) { 
                            Venue venue = new VenueDAO().getVenueById(booking.getVenueId());
                            Payment payment = new PaymentDAO().getPaymentByBookingId(booking.getId());
                        %>
                            <tr>
                                <td><%= venue != null ? venue.getEventType() : "N/A" %></td>
                                <td><%= booking.getTicketNumber() %></td>
                                <td><%= venue != null ? venue.getLocation() : "N/A" %></td>
                                <td><%= booking.getBookingDate() %></td>
                                <td>
                                    <% if(payment != null) { %>
                                        ₹<%= String.format("%,.2f", payment.getAmount()) %>
                                    <% } else { %>
                                        Payment Failed
                                    <% } %>
                                </td>
                                <td class="card-masked">
                                    <% if(payment != null && payment.getCardNumber() != null) { 
                                        String cardNumber = payment.getCardNumber();
                                        if(cardNumber.length() >= 16) { %>
                                            **** **** **** <%= cardNumber.substring(12) %>
                                        <% } else { %>
                                            Invalid Card
                                        <% } %>
                                    <% } else { %>
                                        N/A
                                    <% } %>
                                </td>
                                <td>
                                    <span class="status-badge <%= booking.getStatus().equalsIgnoreCase("confirmed") ? "success-badge" : "failed-badge" %>">
                                        <%= booking.getStatus() %>
                                    </span>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <footer class="mt-auto">
        <%@ include file="components/footer.jsp" %>
    </footer>
</body>
</html>