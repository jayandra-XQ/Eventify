<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="components/navbar.jsp" %>
<%@ page import="java.util.List, model.Event, dao.EventDAO" %>


<%
    // Security check using existing 'role' variable from navbar.jsp
    if (!"admin".equals(role)) {
        response.sendRedirect("index.jsp");
        return;
    }

    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getAllEvents();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event List Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: url('images/coprate.avif') no-repeat center center/cover;
        }
        h2 {
            text-align: center;
            margin-top: 30px;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        main {
            flex: 1;
            padding: 40px 0;
        }
        .event-type-container {
            width: 90%;
            max-width: 1000px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #123A85;
            color: white;
        }
        tbody tr:hover {
            background-color: rgba(0, 0, 0, 0.05);
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            border: none;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

    <h2>Event Type List</h2>

    <main>
        <div class="event-type-container">
            <% if(events.isEmpty()) { %>
                <div class="alert alert-info">No events found. Add your first event!</div>
            <% } else { %>
                <table class="table">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Event Name</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Event event : events) { %>
                            <tr>
                                <td><%= event.getId() %></td>
                                <td><%= event.getEventName() %></td>
                                <td><%= event.getDescription() %></td>
                                <td>
                                    <form action="delete-event" method="POST" style="display: inline-block;">
                                        <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                        <button type="submit" class="btn-delete">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <%@ include file="components/footer.jsp" %>
</body>
</html>