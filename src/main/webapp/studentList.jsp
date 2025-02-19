<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.edumanager.model.Student" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des étudiants</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
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
            for (Student student : studentList) {
        %>
        <tr>
            <td><%= student.getId() %></td>
            <td><%= student.getNom() %></td>
            <td><%= student.getPrenom() %></td>
            <td><%= student.getEmail() %></td>
            <td><%= student.getDateNaissance() %></td>
            <td>
                <a href="updateStudent?id=<%= student.getId() %>" class="btn btn-warning btn-sm">Modifier</a>
                <form action="deleteStudent" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= student.getId() %>" />
                    <input type="submit" value="Supprimer" class="btn btn-danger btn-sm" />
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <a href="createStudent" class="btn btn-success">Créer un étudiant</a>
</div>
</body>
</html>