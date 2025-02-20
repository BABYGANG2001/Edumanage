package com.example.edumanager.controllers;

import com.example.edumanager.dao.StudentDAO;
import com.example.edumanager.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class StudentServlet extends HttpServlet {
    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI().substring(request.getContextPath().length());

        try {
            if (action.endsWith("/students/create")) {
                createStudent(request, response);
            } else if (action.endsWith("/students/update")) {
                updateStudent(request, response);
            } else if (action.endsWith("/students/delete")) {
                deleteStudent(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/students/read");
            }
        } catch (Exception e) {
            throw new ServletException("An error occurred processing POST request", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getRequestURI().substring(request.getContextPath().length());

        try {
            if (action.endsWith("/students/showCreateForm")) {
                showCreateForm(request, response);
            } else if (action.endsWith("/students/showUpdateForm")) {
                showUpdateForm(request, response);
            } else if (action.endsWith("/students/read")) {
                listStudents(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/students/read");
            }
        } catch (Exception e) {
            throw new ServletException("An error occurred processing GET request", e);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/createStudentForm.jsp").forward(request, response);
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(id);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/updateStudentForm.jsp").forward(request, response);
    }

    private void createStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String dateNaissanceStr = request.getParameter("date_naissance");

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateNaissance = sdf.parse(dateNaissanceStr);

            Student student = new Student(nom, prenom, email, dateNaissance);
            studentDAO.createStudent(student);

            response.sendRedirect(request.getContextPath() + "/students/read");
        } catch (ParseException e) {
            request.setAttribute("error", "Format de date invalide");
            request.getRequestDispatcher("/createStudentForm.jsp").forward(request, response);
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> studentList = studentDAO.getAllStudents();
        request.setAttribute("studentList", studentList);
        request.getRequestDispatcher("/studentList.jsp").forward(request, response);
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        studentDAO.deleteStudent(id);

        response.sendRedirect(request.getContextPath() + "/students/read");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String dateNaissanceStr = request.getParameter("date_naissance");

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateNaissance = sdf.parse(dateNaissanceStr);

            Student student = new Student(nom, prenom, email, dateNaissance);
            student.setId(id);
            studentDAO.updateStudent(student);

            response.sendRedirect(request.getContextPath() + "/students/read");
        } catch (ParseException e) {
            request.setAttribute("error", "Format de date invalide");
            Student student = studentDAO.getStudentById(id);
            request.setAttribute("student", student);
            request.getRequestDispatcher("/updateStudentForm.jsp").forward(request, response);
        }
    }
}