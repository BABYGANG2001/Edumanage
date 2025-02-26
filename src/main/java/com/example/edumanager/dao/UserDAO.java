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

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public User getUser() {
        User user = null;
        String query = "SELECT * FROM users WHERE id = 1 ";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
