<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List, model.Venue, dao.VenueDAO" %>
<%
    // Fetch all venues
    VenueDAO venueDAO = new VenueDAO();
    List<Venue> venues = venueDAO.getAllVenues();
%>

<%@ page import="dao.EventDAO, model.Event" %>  <%-- Add this import --%>
<%
    // Add this code to fetch events
    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getAllEvents();
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Venue Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background: linear-gradient(to bottom right, #e0eafc, #cfdef3);
        }

        h1 {
            color: #123A85;
        }

        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 80px 0; 
        }

        .venue-container {
            width: 90%; 
            max-width: 1300px;
            background-color: white;
            padding: 60px; 
            border-radius: 15px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.18); 
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        h2 {
            text-align: center;
            margin-bottom: 40px;
            color: #343a40;
            font-size: 2rem; 
            font-weight: 600;
            width: 100%;
        }

        .form-group {
            margin-bottom: 30px; 
            width: calc(50% - 20px); 
        }
        @media (max-width: 768px) {
            .form-group {
                width: 100%; 
            }
        }

        label {
            font-weight: 500;
            color: #343a40;
            margin-bottom: 10px;
            font-size: 1.1rem; 
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 15px; 
            width: 500px;
            font-size: 1.1rem; 
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.08); 
        }

        .btn-primary {
            background: linear-gradient(to right, #4d77e1, #3a60c4);
            border: none;
            color: white;
            border-radius: 8px;
            padding: 15px 30px; 
            font-size: 1.1rem; 
            transition: background 0.3s ease;
            width: auto;
            margin: 25px auto 0; 
            display: block;
        }

        .btn-primary:hover {
            background: linear-gradient(to right, #3a60c4, #4d77e1);
            cursor: pointer;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1); 
        }

        .image-gallery {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-bottom: 40px; 
        }

        .image-gallery img {
            width: calc(33.33% - 30px); 
            height: 250px; 
            object-fit: cover;
            border-radius: 12px; 
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.12); 
            margin: 15px; 
            transition: transform 0.2s ease;
        }
        .image-gallery img:hover{
            transform: scale(1.03);
        }
        

        @media (max-width: 768px) {
            .image-gallery img {
                width: calc(50% - 30px); 
            }
        }
        @media (max-width: 500px) {
            .image-gallery img {
                width: 100%; 
            }
        }
        
        
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .form-select {
		    border-radius: 8px;
		    border: 1px solid #ced4da;
		    padding: 15px;
		    width: 500px;
		    font-size: 1.1rem;
		    box-shadow: 0 3px 6px rgba(0,0,0,0.08);
		    background-color: white;
		}
		
		.image-card {
        position: relative;
        margin: 15px;
        border-radius: 12px;
        overflow: hidden;
    }
    
    .image-overlay {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
        padding: 15px;
        color: white;
    }
    
    .event-name {
        margin: 0;
        font-size: 1.2rem;
        font-weight: 600;
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
        <div class="venue-container">
            <h2>Coming Up...</h2>
            <hr>
            
            <%-- Display success message --%>
            <% if (request.getParameter("success") != null) { %>
                <div id="successMessage" class="alert alert-success">
                    <%= request.getParameter("success") %>
                </div>
            <% } %>
            
            
            <div class="image-gallery">
			    <% for (Venue venue : venues) { 
			        if (venue.getPhotoUrl() != null) { %>
			            <div class="image-card">
			                <img src="uploads/<%= venue.getPhotoUrl() %>" 
			                     alt="Venue Photo" 
			                     style="width: 100%; height: 250px; object-fit: cover; border-radius: 12px; box-shadow: 0 6px 12px rgba(0,0,0,0.12);">
			                <div class="image-overlay">
			                    <h3 class="event-name"><%= venue.getEventType() %></h3>
			                </div>
			            </div>
			    <% } 
			    } %>
			</div>
            <form action="add-venue" method="POST"  enctype="multipart/form-data">
            
            	<div class="form-group">
				    <label for="eventType" class="form-label">Event Type:</label>
				    <select class="form-select" id="eventType" name="eventType" required>
				        <option value="">Select Event Type</option>
				        <% for (Event event : events) { %>
				           <option value="<%= event.getEventName() %>"><%= event.getEventName()%></option>
				        <% } %>
				    </select>
				</div>
               
                <div class="form-group">
                    <label for="capacity" class="form-label">Capacity:</label>
                    <input type="number" class="form-control" id="capacity" name="capacity" required>
                </div>
                <div class="form-group">
                    <label for="cost" class="form-label">Cost:</label>
                    <input type="number" class="form-control" id="cost" name="cost" required>
                </div>
                <div class="form-group">
                    <label for="location" class="form-label">Location:</label>
                    <input type="text" class="form-control" id="location" name="location" required>
                </div>
                <div class="form-group">
                    <label for="contact" class="form-label">Contact:</label>
                    <input type="text" class="form-control" id="contact" name="contact" required>
                </div>
                <div class="form-group">
                    <label for="date" class="form-label">Date:</label>
                    <input type="date" class="form-control" id="eventDate" name="eventDate" required>
                </div>
                <div class="form-group" style="width: 100%;">
                    <label for="eventPhoto" class="form-label">Event Photo:</label>
                    <input class="form-control" type="file" id="eventPhoto" name="eventPhoto">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            
        </div>
    </main>




    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Auto-hide success message after 3 seconds
        const successMessage = document.getElementById('successMessage');
        if (successMessage) {
            setTimeout(function() {
                successMessage.style.display = 'none';
            }, 3000); // 3000 milliseconds = 3 seconds
        }
    </script>

    <footer class="mt-auto">
        <%@ include file="components/footer.jsp" %>
    </footer>
    
    

</body>

</html>