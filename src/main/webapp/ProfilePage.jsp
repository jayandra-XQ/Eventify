<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="dao.BookingDAO, model.User" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Page</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
.profile-wrapper {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    min-height: 100vh;
    padding: 40px 0;
}

.profile-card {
    background: white;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    transform: translateY(0);
    transition: all 0.3s ease;
    overflow: hidden;
    max-width: 600px;
    margin: 0 auto;
}

.profile-header {
    background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
    padding: 50px 0;
    text-align: center;
    color: white;
    position: relative;
}

.profile-name {
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
    color: #1f2937;
}

.profile-role {
    font-size: 1.1rem;
    color: #6b7280;
    margin-bottom: 2rem;
}

.detail-card {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    margin: 1rem 0;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);
    border: 1px solid #e5e7eb;
}

.detail-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem;
}

.detail-icon {
    width: 40px;
    height: 40px;
    background: #eef2ff;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #4f46e5;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
    margin: 2rem 0;
}

.stat-item {
    text-align: center;
    padding: 1.5rem;
    background: #f8f9fa;
    border-radius: 10px;
}

.stat-number {
    font-size: 1.5rem;
    font-weight: 700;
    color: #4f46e5;
    margin-bottom: 0.5rem;
}

.delete-btn {
    background: #ef4444;
    border: none;
    padding: 0.8rem 2rem;
    border-radius: 8px;
    color: white;
    font-weight: 600;
    transition: all 0.3s ease;
    width: 100%;
    max-width: 200px;
    margin: 1rem auto;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.delete-btn:hover {
    background: #dc2626;
    transform: translateY(-2px);
}
</style>
</head>
<body class="profile-wrapper">
    <%@ include file="components/navbar.jsp" %>
    
    <% 
        User localUser = (User) session.getAttribute("user");
        String localRole = (String) session.getAttribute("role");
        
        if(localUser == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }
        
        // Get booking counts
        BookingDAO  bookingDAO = new BookingDAO();
        int bookingCount = 0;
        
        if("admin".equalsIgnoreCase(localRole)) {
            bookingCount = bookingDAO.getAllBookingsCount();
        } else {
            bookingCount = bookingDAO.getUserBookingCount(localUser.getId());
        }
        
        String fullName = (localUser.getFirstName() != null ? localUser.getFirstName() : "") 
                        + " " 
                        + (localUser.getLastName() != null ? localUser.getLastName() : "");
        fullName = fullName.trim().isEmpty() ? "User" : fullName;
    %>

    <div class="container">
        <div class="profile-card">
            <div class="profile-header">
                <h2>Account Overview</h2>
            </div>
            
            <div class="p-4">
                <div class="text-center mb-4">
                    <h1 class="profile-name"><%= fullName %></h1>
                    <div class="profile-role">
                        <i class="fas fa-user-shield"></i>
                        <%= "admin".equalsIgnoreCase(localRole) ? "Administrator" : "Standard User" %>
                    </div>
                </div>

                <div class="detail-card">
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div>
                            <h5 class="mb-1">Email Address</h5>
                            <p class="mb-0 text-muted"><%= localUser.getEmail() %></p>
                        </div>
                    </div>
                </div>

                <div class="stats-grid">
				     <div class="stat-item">
				        <div class="stat-number"><%= bookingCount %></div>
				        <small class="text-muted">
				            <%= "admin".equalsIgnoreCase(localRole) ? "Total Bookings" : "Your Bookings" %>
				        </small>
				    </div>
                    <div class="stat-item">
                        <div class="stat-number">1</div>
                        <small class="text-muted">Active Account</small>
                    </div>
                </div>

                <div class="text-center">
                    <form id="deleteForm" method="post" action="delete-account">
                        <button type="button" 
                                class="delete-btn"
                                onclick="confirmDelete()">
                            <i class="fas fa-trash-alt"></i>
                            Delete Account
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
    function confirmDelete() {
        Swal.fire({
            title: 'Delete Account?',
            text: "All your data will be permanently removed!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#ef4444',
            cancelButtonColor: '#64748b',
            confirmButtonText: 'Confirm Delete'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteForm').submit();
            }
        })
    }
    </script>

    <!-- Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>