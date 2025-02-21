<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.edumanager.model.Student" %>
<%@ page import="com.example.edumanager.model.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails des Cours de l'Étudiant</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .course-card {
            transition: transform 0.2s;
            margin-bottom: 15px;
        }
        .course-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-graduation-cap mr-2"></i>EduManager
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/read">Cours</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/students/read">Étudiants</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/enrollments">Inscriptions</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-user-graduate mr-2"></i>Détails de l'Étudiant</h2>
        <a href="${pageContext.request.contextPath}/enrollments" class="btn btn-secondary">
            <i class="fas fa-arrow-left mr-1"></i>Retour aux inscriptions
        </a>
    </div>

    <%
        Student student = (Student) request.getAttribute("student");
        List<Course> enrolledCourses = (List<Course>) request.getAttribute("enrolledCourses");

        if (student != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    %>

    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0"><i class="fas fa-id-card mr-2"></i>Profil de l'étudiant</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <div class="text-center mb-3">
                        <div style="width: 120px; height: 120px; background-color: #e9ecef; border-radius: 50%; display: inline-flex; justify-content: center; align-items: center; margin-bottom: 15px;">
                            <i class="fas fa-user-graduate" style="font-size: 3rem; color: #6c757d;"></i>
                        </div>
                        <h4><%= student.getPrenom() %> <%= student.getNom() %></h4>
                        <span class="badge badge-info">ID: <%= student.getId() %></span>
                    </div>
                </div>
                <div class="col-md-8">
                    <table class="table table-borderless">
                        <tbody>
                        <tr>
                            <th><i class="fas fa-envelope text-primary mr-2"></i>Email:</th>
                            <td><%= student.getEmail() %></td>
                        </tr>
                        <tr>
                            <th><i class="fas fa-birthday-cake text-primary mr-2"></i>Date de naissance:</th>
                            <td><%= sdf.format(student.getDateNaissance()) %></td>
                        </tr>
                        <tr>
                            <th><i class="fas fa-book-reader text-primary mr-2"></i>Cours inscrits:</th>
                            <td><span class="badge badge-pill badge-primary"><%= enrolledCourses != null ? enrolledCourses.size() : 0 %></span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Enrolled Courses Section -->
    <div class="card">
        <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
            <h3 class="mb-0"><i class="fas fa-book mr-2"></i>Cours inscrits</h3>
            <a href="${pageContext.request.contextPath}/enrollments/showEnrollForm" class="btn btn-light btn-sm">
                <i class="fas fa-plus-circle mr-1"></i>Ajouter un cours
            </a>
        </div>
        <div class="card-body">
            <% if (enrolledCourses != null && !enrolledCourses.isEmpty()) { %>
            <div class="row">
                <% for (Course course : enrolledCourses) { %>
                <div class="col-md-6">
                    <div class="card course-card mb-3">
                        <div class="card-header bg-light">
                            <h5 class="mb-0"><i class="fas fa-chalkboard-teacher mr-2 text-success"></i><%= course.getNomCours() %></h5>
                        </div>
                        <div class="card-body">
                            <p><strong>Description:</strong> <%= course.getDescription() %></p>
                            <p><strong>ID du cours:</strong> <%= course.getId() %></p>
                            <form action="${pageContext.request.contextPath}/enrollments/unenroll" method="post" class="mt-3">
                                <input type="hidden" name="studentId" value="<%= student.getId() %>" />
                                <input type="hidden" name="courseId" value="<%= course.getId() %>" />
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Êtes-vous sûr de vouloir désinscrire cet étudiant de ce cours?')">
                                    <i class="fas fa-user-minus mr-1"></i>Désinscrire
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="alert alert-info">
                <i class="fas fa-info-circle mr-2"></i>Cet étudiant n'est inscrit à aucun cours actuellement.
            </div>
            <a href="${pageContext.request.contextPath}/enrollments/showEnrollForm" class="btn btn-primary">
                <i class="fas fa-plus-circle mr-1"></i>Inscrire à un cours
            </a>
            <% } %>
        </div>
    </div>
    <% } else { %>
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-circle mr-2"></i>Étudiant non trouvé.
    </div>
    <% } %>
</div>



<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>