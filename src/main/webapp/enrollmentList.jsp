<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.edumanager.model.Student" %>
<%@ page import="com.example.edumanager.model.Course" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des inscriptions</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
        <h2><i class="fas fa-users mr-2"></i>Liste des inscriptions par étudiant</h2>
        <a href="${pageContext.request.contextPath}/enrollments/showEnrollForm" class="btn btn-primary">
            <i class="fas fa-plus-circle mr-1"></i>Nouvelle inscription
        </a>
    </div>

    <div class="accordion" id="enrollmentAccordion">
        <%
            List<Student> students = (List<Student>) request.getAttribute("students");
            if (students != null && !students.isEmpty()) {
                for (Student student : students) {
                    List<Course> courses = (List<Course>) request.getAttribute("courses_" + student.getId());
        %>
        <div class="card mb-3">
            <div class="card-header bg-light" id="heading<%= student.getId() %>">
                <h2 class="mb-0">
                    <button class="btn btn-link btn-block text-left text-decoration-none" type="button" data-toggle="collapse"
                            data-target="#collapse<%= student.getId() %>" aria-expanded="true"
                            aria-controls="collapse<%= student.getId() %>">
                        <div class="d-flex justify-content-between">
                            <span>
                                <i class="fas fa-user-graduate mr-2"></i>
                                <strong><%= student.getPrenom() %> <%= student.getNom() %></strong>
                                (<%= student.getEmail() %>)
                            </span>
                            <span class="badge badge-primary badge-pill">
                                <%= courses != null ? courses.size() : 0 %> cours
                            </span>
                        </div>
                    </button>
                </h2>
            </div>

            <div id="collapse<%= student.getId() %>" class="collapse"
                 aria-labelledby="heading<%= student.getId() %>" data-parent="#enrollmentAccordion">
                <div class="card-body">
                    <% if (courses != null && !courses.isEmpty()) { %>
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Cours</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% for (Course course : courses) { %>
                            <tr>
                                <td><%= course.getNomCours() %></td>
                                <td><%= course.getDescription() %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/enrollments/unenroll" method="post" style="display:inline;">
                                        <input type="hidden" name="studentId" value="<%= student.getId() %>" />
                                        <input type="hidden" name="courseId" value="<%= course.getId() %>" />
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="fas fa-user-minus"></i> Désinscrire
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% } else { %>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle mr-2"></i>Cet étudiant n'est inscrit à aucun cours.
                    </div>
                    <% } %>
                    <a href="${pageContext.request.contextPath}/enrollments/student/<%= student.getId() %>"
                       class="btn btn-outline-primary btn-sm mt-2">
                        <i class="fas fa-eye mr-1"></i>Voir détails
                    </a>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="alert alert-warning">
            <i class="fas fa-exclamation-triangle mr-2"></i>Aucun étudiant dans le système.
        </div>
        <%
            }
        %>
    </div>
</div>



<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>