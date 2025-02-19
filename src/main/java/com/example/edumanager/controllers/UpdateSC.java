package com.example.edumanager.controllers;

import com.example.edumanager.dao.CourseDAO;
import com.example.edumanager.model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateCourse")
public class UpdateSC extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() {
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Course course = courseDAO.getCourseById(id);
        request.setAttribute("course", course);
        request.getRequestDispatcher("updateCourseForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nomCours = request.getParameter("nom_cours");
        String description = request.getParameter("description");

        Course course = new Course(nomCours, description);
        course.setId(id);
        courseDAO.updateCourse(course);

        response.sendRedirect("readCourse");
    }
}