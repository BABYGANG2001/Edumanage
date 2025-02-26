package com.example.edumanager.controllers;

import com.example.edumanager.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Servlet pour gérer l'authentification des utilisateurs
 */
public class LoginServlet extends HttpServlet {

    // Map des utilisateurs (simulation d'une base de données)
    private static final Map<String, User> users = new HashMap<>();

    // Initialisation des utilisateurs
    static {
        users.put("admin", new User("admin", "admin123", "admin"));
        users.put("prof", new User("prof", "prof123", "teacher"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if("admin".equals(username) && "admin123".equals(password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);
            session.setAttribute("password", password);
            response.sendRedirect("home");
        }else {
            request.setAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }




        /*

        // Vérification des identifiants
        User user = authenticateUser(username, password);
        if (user != null) {
            // Création de la session
            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);
            session.setAttribute("role", user.getRole());

            // Redirection vers la page d'accueil
            response.sendRedirect("home");
        } else {
            // Échec de l'authentification
            request.setAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

         */
    }

    /**


    private User authenticateUser(String username, String password) {
        User user = users.get(username);
        if (user != null && user.checkPassword(password)) {
            return user;
        }
        return null;
    }
     */
    /*
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalider la session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Supprimer les cookies de connexion
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
                }
            }
        }

        // Rediriger vers la page de connexion
        response.sendRedirect("login");
    }

     */
}