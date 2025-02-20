<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.edumanager.model.Student" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mise à jour d'étudiant</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Mise à jour d'étudiant</h2>
    <% if(request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <%
        Student student = (Student) request.getAttribute("student");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String dateStr = sdf.format(student.getDateNaissance());
    %>
    <form action="/Edumanager_war_exploded/students/update" method="post">
        <input type="hidden" name="id" value="${student.id}" />
        <div class="form-group">
            <label for="nom">Nom:</label>
            <input type="text" class="form-control" id="nom" name="nom" value="${student.nom}" required />
        </div>
        <div class="form-group">
            <label for="prenom">Prénom:</label>
            <input type="text" class="form-control" id="prenom" name="prenom" value="${student.prenom}" required />
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" value="${student.email}" required />
        </div>
        <div class="form-group">
            <label for="date_naissance">Date de naissance:</label>
            <input type="date" class="form-control" id="date_naissance" name="date_naissance" value="<%= dateStr %>" required />
        </div>
        <button type="submit" class="btn btn-primary">Mettre à jour</button>
        <a href="/Edumanager_war_exploded/students/read" class="btn btn-secondary">Retour</a>
    </form>
</div>
</body>
</html>