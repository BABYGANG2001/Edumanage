package com.example.edumanager.controllers;

import com.example.edumanager.dao.CourseDAO;
import com.example.edumanager.dao.EnrollmentDAO;
import com.example.edumanager.dao.StudentDAO;
import com.example.edumanager.model.Course;
import com.example.edumanager.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


public class EnrollmentServlet extends HttpServlet {
    private EnrollmentDAO enrollmentDAO;
    private StudentDAO studentDAO;
    private CourseDAO courseDAO;

    @Override
    public void init() {
        enrollmentDAO = new EnrollmentDAO();
        studentDAO = new StudentDAO();
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI().substring(request.getContextPath().length());

        if (path.equals("/enrollments")) {
            listEnrollmentsByStudent(request, response);
        } else if (path.startsWith("/enrollments/student/")) {
            showStudentCourses(request, response);
        } else if (path.equals("/enrollments/showEnrollForm")) {
            showEnrollForm(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/enrollments");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI().substring(request.getContextPath().length());

        if (path.equals("/enrollments/enroll")) {
            enrollStudent(request, response);
        } else if (path.equals("/enrollments/unenroll")) {
            unenrollStudent(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/enrollments");
        }
    }

    private void listEnrollmentsByStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();

        for (Student student : students) {
            List<Course> courses = enrollmentDAO.getCoursesForStudent(student.getId());
            request.setAttribute("courses_" + student.getId(), courses);
        }

        request.setAttribute("students", students);
        request.getRequestDispatcher("/enrollmentList.jsp").forward(request, response);
    }

    private void showStudentCourses(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 1) {
            try {
                int studentId = Integer.parseInt(pathInfo.substring(1));
                Student student = studentDAO.getStudentById(studentId);
                List<Course> enrolledCourses = enrollmentDAO.getCoursesForStudent(studentId);

                request.setAttribute("student", student);
                request.setAttribute("enrolledCourses", enrolledCourses);
                request.getRequestDispatcher("/studentCourses.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/enrollments");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/enrollments");
        }
    }

    private void showEnrollForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        List<Course> courses = courseDAO.getAllCourses();

        request.setAttribute("students", students);
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/enrollForm.jsp").forward(request, response);
    }

    private void enrollStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        // Check if already enrolled
        if (!enrollmentDAO.isStudentEnrolledInCourse(studentId, courseId)) {
            enrollmentDAO.enrollStudentInCourse(studentId, courseId);
        }

        response.sendRedirect(request.getContextPath() + "/enrollments");
    }

    private void unenrollStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        enrollmentDAO.unenrollStudentFromCourse(studentId, courseId);
        response.sendRedirect(request.getContextPath() + "/enrollments");
    }
}