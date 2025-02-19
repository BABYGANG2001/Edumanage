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

@WebServlet("/readCourse")
public class ReadSC extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() {
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Course> courseList = courseDAO.getAllCourses();
        request.setAttribute("courseList", courseList);
        request.getRequestDispatcher("courseList.jsp").forward(request, response);
    }
}