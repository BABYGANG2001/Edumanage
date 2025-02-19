package com.example.edumanager.controllers;

import com.example.edumanager.dao.StudentDAO;
import com.example.edumanager.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/readStudent")
public class ReadSS extends HttpServlet {
    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> studentList = studentDAO.getAllStudents();
        request.setAttribute("studentList", studentList);
        request.getRequestDispatcher("studentList.jsp").forward(request, response);
    }
}