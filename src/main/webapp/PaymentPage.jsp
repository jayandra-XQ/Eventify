<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.VenueDAO, model.Venue" %>
<%
    String venueId = request.getParameter("venueId");
    VenueDAO venueDAO = new VenueDAO();
    Venue venue = venueDAO.getVenueById(Integer.parseInt(venueId));
    
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Page</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        background: linear-gradient(to bottom right, #e0eafc, #cfdef3);
    }
    .payment-container {
        width: 50%;
        max-width: 500px;
        background-color: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin: 40px auto;
    }
    .form-control {
        border-radius: 8px;
        padding: 12px;
    }
    .btn-primary {
        background: linear-gradient(to right, #2D3378, #676B98);
        border: none;
        padding: 12px 25px;
        width: 100%;
    }
</style>
</head>
<body>
    <header>
        <div>  
            <h1>EVENTIFY!!</h1>
        </div>
    </header>
    <%@ include file="components/navbar.jsp" %>

    <main>
        <div class="payment-container">
            <% if (error != null) { %>
                <div class="alert alert-danger text-center">
                    <%= error %>
                </div>
            <% } %>

            <h2 class="text-center mb-4">Payment Details</h2>
            
            <form action="payment" method="POST">
                <input type="hidden" name="venueId" value="<%= venueId %>">
                
                <div class="mb-3">
                    <label class="form-label">Cardholder Name</label>
                    <input type="text" class="form-control" name="personName" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Card Number</label>
                    <input type="text" class="form-control" name="cardNumber" 
                           pattern="\d{16}" placeholder="4242424242424242" required>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label">Expiry (MM/YY)</label>
                        <input type="text" class="form-control" name="expiry" 
                               pattern="(0[1-9]|1[0-2])\/2[2-9]}" placeholder="12/25" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">CVV</label>
                        <input type="text" class="form-control" name="cvv" 
                               pattern="\d{3}" placeholder="123" required>
                    </div>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary">
                        Pay ₹<%= String.format("%,.2f", venue.getCost()) %>
                    </button>
                </div>
            </form>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>