<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.edumanager.model.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des étudiants</title>
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
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/students/read">Étudiants</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center mb-4">Liste des étudiants</h2>
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Email</th>
            <th>Date de naissance</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Student> studentList = (List<Student>) request.getAttribute("studentList");
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            if (studentList != null && !studentList.isEmpty()) {
                for (Student student : studentList) {
        %>
        <tr>
            <td><%= student.getId() %></td>
            <td><%= student.getNom() %></td>
            <td><%= student.getPrenom() %></td>
            <td><%= student.getEmail() %></td>
            <td><%= sdf.format(student.getDateNaissance()) %></td>
            <td>
                <a href="${pageContext.request.contextPath}/students/showUpdateForm?id=<%= student.getId() %>" class="btn btn-warning btn-sm">
                    <i class="fas fa-edit"></i> Modifier
                </a>
                <form action="${pageContext.request.contextPath}/students/delete" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= student.getId() %>" />
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
            <td colspan="6">Aucun étudiant disponible.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/students/showCreateForm" class="btn btn-success">
            <i class="fas fa-plus-circle"></i> Créer un étudiant
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