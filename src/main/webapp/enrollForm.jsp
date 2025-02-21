<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.edumanager.model.Student" %>
<%@ page import="com.example.edumanager.model.Course" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscrire un étudiant à un cours</title>
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
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h2 class="mb-0"><i class="fas fa-user-plus mr-2"></i>Inscrire un étudiant à un cours</h2>
        </div>
        <div class="card-body">
            <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/enrollments/enroll" method="post">
                <div class="form-group">
                    <label for="studentId"><i class="fas fa-user mr-1"></i>Étudiant</label>
                    <select class="form-control" id="studentId" name="studentId" required>
                        <option value="">Sélectionner un étudiant</option>
                        <%
                            List<Student> students = (List<Student>) request.getAttribute("students");
                            if (students != null) {
                                for (Student student : students) {
                        %>
                        <option value="<%= student.getId() %>"><%= student.getPrenom() %> <%= student.getNom() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="courseId"><i class="fas fa-book mr-1"></i>Cours</label>
                    <select class="form-control" id="courseId" name="courseId" required>
                        <option value="">Sélectionner un cours</option>
                        <%
                            List<Course> courses = (List<Course>) request.getAttribute("courses");
                            if (courses != null) {
                                for (Course course : courses) {
                        %>
                        <option value="<%= course.getId() %>"><%= course.getNomCours() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-check mr-1"></i>Inscrire
                    </button>
                    <a href="${pageContext.request.contextPath}/enrollments" class="btn btn-secondary ml-2">
                        <i class="fas fa-arrow-left mr-1"></i>Retour
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>



<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>