package com.example.edumanager.dao;

import com.example.edumanager.model.Course;
import com.example.edumanager.model.User;

import java.sql.*;

public class UserDAO {
    private Connection connection;

    public UserDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/edumanager", "root", "admin");

            Statement statement = connection.createStatement();

            String createTableSQL = "CREATE TABLE IF NOT EXISTS users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "username VARCHAR(100) NOT NULL, " +
                    "password VARCHAR(255) NOT NULL" +
                    "role VARCHAR(255) NOT NULL" +
                    ");";

            statement.executeUpdate(createTableSQL);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public User getUser(int id) {
        User user = null;
        String query = "SELECT * FROM course WHERE id = ? ";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
