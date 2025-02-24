package com.example.edumanager.filters;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Filtre pour vérifier l'authentification des utilisateurs
 * avant d'autoriser l'accès aux ressources protégées
 */
public class AuthenticationFilter implements Filter {

    // Liste des chemins qui ne nécessitent pas d'authentification
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
            "/login",
            "/login.jsp",
            "/logout",
            "/css/",
            "/js/",
            "/images/"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation du filtre
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Obtenir le chemin de la requête
        String path = httpRequest.getServletPath();

        // Vérifier si le chemin est public
        if (isPublicPath(path)) {
            // Autoriser l'accès sans authentification
            chain.doFilter(request, response);
            return;
        }

        // Vérifier si l'utilisateur est authentifié
        HttpSession session = httpRequest.getSession(false);
        boolean isAuthenticated = (session != null && session.getAttribute("username") != null);

        if (isAuthenticated) {
            // L'utilisateur est authentifié, continuer la chaîne de filtres
            chain.doFilter(request, response);
        } else {
            // L'utilisateur n'est pas authentifié, rediriger vers la page de connexion
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Nettoyage des ressources
    }

    /**
     * Vérifie si le chemin demandé est public (ne nécessite pas d'authentification)
     */
    private boolean isPublicPath(String path) {
        return PUBLIC_PATHS.stream().anyMatch(path::startsWith);
    }
}