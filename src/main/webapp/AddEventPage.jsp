<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Event Page</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
    
    body {
        
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }
    
     h1 {
        color: #123A85;
    }

    
    main {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 0;
         background: url('images/party1.jpg') no-repeat center center/cover;
    }

    .event-type-container {
        width: 50%; 
        max-width: 600px;
        background: rgba(255, 255, 255, 0.9); 
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        backdrop-filter: blur(5px);
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #343a40;
        font-weight: bold;
    }

    label {
        font-weight: 500;
        color: #343a40;
    }

    .form-control {
        border-radius: 10px;
        border: 1px solid #ced4da;
        padding: 12px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    textarea.form-control {
        height: 120px;
    }

    /* Styled Button */
    .btn-primary {
        background-color: #E44D26;
        border-color: #E44D26;
        color: white;
        font-weight: bold;
        border-radius: 5px;
        width: 100%;
        padding: 10px;
        margin-top: 20px;
        transition: background 0.3s ease-in-out;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
    }

    .btn-primary:hover {
        background-color: #C63F19;
        border-color: #C63F19;
        transform: scale(1.05);
    }

    /* Footer Styling */
    footer {
        background: rgba(0, 0, 0, 0.7);
        color: white;
        padding: 15px 0;
        text-align: center;
    }
</style>
</head>
<body>

<header>
    <h1>EVENTIFY</h1>
</header>

<%@ include file="components/navbar.jsp" %>

<main>
    <div class="event-type-container">
        <h2>Add New Event</h2>
        <form action="add-event" method="POST">
            <div class="mb-3">
                <label for="eventName" class="form-label">Event Name:</label>
                <input type="text" class="form-control" id="eventName" name="eventName" required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <textarea class="form-control" id="description" name="description" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Create Event</button>
        </form>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<footer>
    <%@ include file="components/footer.jsp" %>
</footer>

</body>
</html>
