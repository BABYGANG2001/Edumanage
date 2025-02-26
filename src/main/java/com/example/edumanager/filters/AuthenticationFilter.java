package com.example.edumanager.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;


@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation du filtre
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String path = httpRequest.getServletPath();

        // Vérifier si le chemin est public
        if ("/".equals(path) || "/login".equals(path) || "/login.jsp".equals(path)) {
            // Autoriser l'accès sans authentification
            chain.doFilter(request, response);
        }else {
            // Vérifier si l'utilisateur est authentifié
            HttpSession session = httpRequest.getSession(false);
            boolean isAuthenticated = (session != null && session.getAttribute("username") != null);

            if (isAuthenticated) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            }

        }

    }
    /*
    @Override
    public void destroy() {
        // Nettoyage des ressources
    }

     */



}
