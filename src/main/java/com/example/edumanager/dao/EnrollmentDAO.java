package com.example.edumanager.dao;

import com.example.edumanager.model.Course;
import com.example.edumanager.model.Enrollment;
import com.example.edumanager.model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO {
    private Connection connection;

    public EnrollmentDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/edumanager", "root", "admin");

            Statement statement = connection.createStatement();

            String createTableSQL = "CREATE TABLE IF NOT EXISTS student_course (" +
                    "student_id INT NOT NULL, " +
                    "course_id INT NOT NULL, " +
                    "enrollment_date DATE NOT NULL, " +
                    "PRIMARY KEY (student_id, course_id), " +
                    "FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE, " +
                    "FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE" +
                    ");";

            statement.executeUpdate(createTableSQL);
            System.out.println("Table 'student_course' created successfully (if it did not exist already).");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void enrollStudentInCourse(int studentId, int courseId) {
        String query = "INSERT INTO student_course (student_id, course_id, enrollment_date) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            stmt.setDate(3, new java.sql.Date(new java.util.Date().getTime()));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unenrollStudentFromCourse(int studentId, int courseId) {
        String query = "DELETE FROM student_course WHERE student_id = ? AND course_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Course> getCoursesForStudent(int studentId) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.* FROM course c " +
                "JOIN student_course sc ON c.id = sc.course_id " +
                "WHERE sc.student_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setId(rs.getInt("id"));
                    course.setNomCours(rs.getString("nom_cours"));
                    course.setDescription(rs.getString("description"));
                    courses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    public List<Student> getStudentsForCourse(int courseId) {
        List<Student> students = new ArrayList<>();
        String query = "SELECT s.* FROM student s " +
                "JOIN student_course sc ON s.id = sc.student_id " +
                "WHERE sc.course_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setNom(rs.getString("nom"));
                    student.setPrenom(rs.getString("prenom"));
                    student.setEmail(rs.getString("email"));
                    student.setDateNaissance(rs.getDate("date_naissance"));
                    students.add(student);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public List<Enrollment> getAllEnrollments() {
        List<Enrollment> enrollments = new ArrayList<>();
        String query = "SELECT sc.*, s.nom, s.prenom, c.nom_cours " +
                "FROM student_course sc " +
                "JOIN student s ON sc.student_id = s.id " +
                "JOIN course c ON sc.course_id = c.id";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Enrollment enrollment = new Enrollment();
                enrollment.setStudentId(rs.getInt("student_id"));
                enrollment.setCourseId(rs.getInt("course_id"));
                enrollment.setEnrollmentDate(rs.getDate("enrollment_date"));
                enrollment.setStudentName(rs.getString("prenom") + " " + rs.getString("nom"));
                enrollment.setCourseName(rs.getString("nom_cours"));
                enrollments.add(enrollment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }

    public boolean isStudentEnrolledInCourse(int studentId, int courseId) {
        String query = "SELECT 1 FROM student_course WHERE student_id = ? AND course_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}