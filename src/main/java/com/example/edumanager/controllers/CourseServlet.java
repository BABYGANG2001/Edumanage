package com.example.edumanager.controllers;

import com.example.edumanager.dao.CourseDAO;
import com.example.edumanager.model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


public class CourseServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() {
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/create":
                    createCourse(request, response);
                    break;
                case "/update":
                    updateCourse(request, response);
                    break;
                case "/delete":
                    deleteCourse(request, response);
                    break;
                default:
                    response.sendRedirect("read");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("An error occurred processing POST request", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/showCreateForm":
                    showCreateForm(request, response);
                    break;
                case "/showUpdateForm":
                    showUpdateForm(request, response);
                    break;
                case "/read":
                    listCourses(request, response);
                    break;
                case "/":
                    response.sendRedirect("read");
                    break;
                default:
                    listCourses(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("An error occurred processing GET request", e);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("createCourseForm.jsp").forward(request, response);
    }

    private void createCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nomCours = request.getParameter("nom_cours");
        String description = request.getParameter("description");

        if (nomCours != null && description != null) {
            Course course = new Course(nomCours, description);
            courseDAO.createCourse(course);
            response.sendRedirect("read");
        } else {
            request.setAttribute("error", "Les champs ne peuvent pas être vides");
            request.getRequestDispatcher("createCourseForm.jsp").forward(request, response);
        }
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Course course = courseDAO.getCourseById(id);
        request.setAttribute("course", course);
        request.getRequestDispatcher("updateCourseForm.jsp").forward(request, response);
    }

    private void updateCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nomCours = request.getParameter("nom_cours");
        String description = request.getParameter("description");

        Course course = new Course(nomCours, description);
        course.setId(id);
        courseDAO.updateCourse(course);
        response.sendRedirect("read");
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        courseDAO.deleteCourse(id);
        response.sendRedirect("read");
    }

    private void listCourses(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Course> courseList = courseDAO.getAllCourses();
        request.setAttribute("courseList", courseList);
        request.getRequestDispatcher("courseList.jsp").forward(request, response);
    }
}