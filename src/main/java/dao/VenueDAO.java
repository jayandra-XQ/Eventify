package dao;
import model.Venue;
import util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VenueDAO {
    public boolean addVenue(Venue venue) {
        String sql = "INSERT INTO venues (event_type, capacity, cost, location, contact, event_date, photo_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, venue.getEventType());
            pstmt.setInt(2, venue.getCapacity());
            pstmt.setDouble(3, venue.getCost());
            pstmt.setString(4, venue.getLocation());
            pstmt.setString(5, venue.getContact());
            pstmt.setDate(6, venue.getEventDate());
            pstmt.setString(7, venue.getPhotoUrl());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // For transactions (with existing connection)
    public Venue getVenueById(Connection conn, int venueId) throws SQLException {
        return queryVenueById(conn, venueId);
    }

    // For non-transactional use (self-managed connection)
    public Venue getVenueById(int venueId) throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection()) {
            return queryVenueById(conn, venueId);
        }
    }

    private Venue queryVenueById(Connection conn, int venueId) throws SQLException {
        String sql = "SELECT * FROM venues WHERE id = ?";
        Venue venue = null;
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, venueId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                venue = new Venue();
                venue.setId(rs.getInt("id"));
                venue.setEventType(rs.getString("event_type"));
                venue.setCapacity(rs.getInt("capacity"));
                venue.setCost(rs.getDouble("cost"));
                venue.setLocation(rs.getString("location"));
                venue.setPhotoUrl(rs.getString("photo_url"));
            }
        }
        return venue;
    }

    public List<Venue> getAllVenues() {
        List<Venue> venues = new ArrayList<>();
        String sql = "SELECT * FROM venues ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Venue venue = new Venue();
                venue.setId(rs.getInt("id"));
                venue.setEventType(rs.getString("event_type"));
                venue.setCapacity(rs.getInt("capacity"));
                venue.setCost(rs.getDouble("cost"));
                venue.setLocation(rs.getString("location"));
                venue.setContact(rs.getString("contact"));
                venue.setEventDate(rs.getDate("event_date"));
                venue.setPhotoUrl(rs.getString("photo_url"));
                venues.add(venue);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return venues;
    }
    
    public Venue getLatestVenue() {
        String sql = "SELECT * FROM venues ORDER BY id DESC LIMIT 1";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                Venue venue = new Venue();
                venue.setId(rs.getInt("id"));
                venue.setEventType(rs.getString("event_type"));
                venue.setCapacity(rs.getInt("capacity"));
                venue.setCost(rs.getDouble("cost"));
                venue.setLocation(rs.getString("location"));
                venue.setContact(rs.getString("contact"));
                venue.setEventDate(rs.getDate("event_date"));
                venue.setPhotoUrl(rs.getString("photo_url"));
                return venue;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}