package com.example.edumanager.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import java.io.IOException;

/**
 * Servlet pour gérer l'authentification des utilisateurs
 */
public class LoginServlet extends HttpServlet {

    // Utilisateurs en dur pour la démonstration
    // Dans une application réelle, utiliser une base de données et des mots de passe hashés
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";
    private static final String TEACHER_USERNAME = "prof";
    private static final String TEACHER_PASSWORD = "prof123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Vérifier si l'utilisateur est déjà connecté
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            // Rediriger vers la page d'accueil si déjà connecté
            response.sendRedirect("home");
        } else {
            // Vérifier si un cookie "rememberMe" existe
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("username".equals(cookie.getName())) {
                        request.setAttribute("savedUsername", cookie.getValue());
                        break;
                    }
                }
            }
            // Afficher la page de connexion
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Vérification des identifiants
        if (isValidUser(username, password)) {
            // Création de la session
            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);

            // Déterminer le rôle de l'utilisateur
            String role = ADMIN_USERNAME.equals(username) ? "admin" : "teacher";
            session.setAttribute("role", role);

            // Gestion du "Se souvenir de moi"
            if (rememberMe != null) {
                Cookie usernameCookie = new Cookie("username", username);
                usernameCookie.setMaxAge(60 * 60 * 24 * 30); // 30 jours
                response.addCookie(usernameCookie);
            }

            // Redirection vers la page d'accueil
            response.sendRedirect("home");
        } else {
            // Échec de l'authentification
            request.setAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     * Méthode pour vérifier les identifiants de l'utilisateur
     */
    private boolean isValidUser(String username, String password) {
        if (username == null || password == null) {
            return false;
        }

        return (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) ||
                (TEACHER_USERNAME.equals(username) && TEACHER_PASSWORD.equals(password));
    }

    /**
     * Gère la déconnexion
     */
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
}