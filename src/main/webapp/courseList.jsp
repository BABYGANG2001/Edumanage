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
</head>
<body>
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
                <a href="updateCourse?id=<%= course.getId() %>" class="btn btn-warning btn-sm">Modifier</a>
                <form action="deleteCourse" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= course.getId() %>" />
                    <input type="submit" value="Supprimer" class="btn btn-danger btn-sm" />
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
    <a href="createCourse" class="btn btn-success">Créer un cours</a>
</div>
</body>
</html>