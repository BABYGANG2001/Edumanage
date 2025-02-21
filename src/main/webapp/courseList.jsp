<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.edumanager.model.Course" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des cours</title>
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
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/read">Cours</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/students/read">Étudiants</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center mb-4">Liste des cours</h2>
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Nom du cours</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Course> courseList = (List<Course>) request.getAttribute("courseList");
            if (courseList != null && !courseList.isEmpty()) {
                for (Course course : courseList) {
        %>
        <tr>
            <td><%= course.getId() %></td>
            <td><%= course.getNomCours() %></td>
            <td><%= course.getDescription() %></td>
            <td>
                <a href="${pageContext.request.contextPath}/showUpdateForm?id=<%= course.getId() %>" class="btn btn-warning btn-sm">
                    <i class="fas fa-edit"></i> Modifier
                </a>
                <form action="${pageContext.request.contextPath}/delete" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= course.getId() %>" />
                    <button type="submit" class="btn btn-danger btn-sm">
                        <i class="fas fa-trash"></i> Supprimer
                    </button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4">Aucun cours disponible.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/showCreateForm" class="btn btn-success">
            <i class="fas fa-plus-circle"></i> Créer un cours
        </a>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary ml-2">
            <i class="fas fa-home"></i> Retour à l'accueil
        </a>
    </div>
</div>



<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>