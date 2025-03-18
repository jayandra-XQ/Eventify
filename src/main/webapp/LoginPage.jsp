<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="components/navbar.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(to bottom right, #e0eafc, #cfdef3); min-height: 100vh; display: flex; flex-direction: column; }
        .login-container { width: 900px; border-radius: 15px; box-shadow: 0 6px 12px rgba(0,0,0,0.15); background: white; }
        .image-side { width: 40%; background: url('images/party1.jpg') center/cover; } /* Change image path */
        .form-side { width: 60%; padding: 40px; }
        .form-title { font-size: 1.8rem; font-weight: 600; color: #333; }
        footer { margin-top: auto; }
    </style>
</head>
<body>
    
    <main class="container d-flex justify-content-center align-items-center py-5">
        <div class="login-container d-flex">
            <div class="image-side"></div>
            <div class="form-side">
                <h2 class="form-title text-center mb-4">Event Login</h2>
                <hr>
                
                <%-- Error/Success Messages --%>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger">${errorMessage}</div>
                <% } %>
                <% if (request.getParameter("registration") != null) { %>
                    <div class="alert alert-success">Registration successful! Please login.</div>
                <% } %>

                <form action="login" method="POST">
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>
            </div>
        </div>
    </main>

    <%@ include file="components/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>