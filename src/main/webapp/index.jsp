<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduManager - Système de Gestion Éducative</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .card {
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #007bff;
        }
        .jumbotron {
            background: linear-gradient(to right, #007bff, #6610f2);
            color: white;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="home">
            <i class="fas fa-graduation-cap mr-2"></i>EduManager
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="home">Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="read">Cours</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="students/read">Étudiants</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="enrollments">Inscriptions</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="jumbotron jumbotron-fluid">
    <div class="container text-center">
        <h1 class="display-4">Bienvenue sur EduManager</h1>
        <p class="lead">Système de gestion éducative intégré pour les cours et les étudiants</p>
    </div>
</div>

<div class="container my-5">
    <div class="row">
        <div class="col-md-4">
            <div class="card text-center p-4">
                <div class="card-body">
                    <i class="fas fa-book card-icon"></i>
                    <h3 class="card-title">Gestion des Cours</h3>
                    <p class="card-text">Créez, modifiez et gérez tous vos cours facilement dans une interface intuitive.</p>
                    <a href="read" class="btn btn-primary btn-lg">Accéder aux Cours</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center p-4">
                <div class="card-body">
                    <i class="fas fa-user-graduate card-icon"></i>
                    <h3 class="card-title">Gestion des Étudiants</h3>
                    <p class="card-text">Gérez les informations des étudiants et suivez leur progression académique.</p>
                    <a href="students/read" class="btn btn-success btn-lg">Accéder aux Étudiants</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center p-4">
                <div class="card-body">
                    <i class="fas fa-users card-icon" style="color: #9c27b0;"></i>
                    <h3 class="card-title">Gestion des Inscriptions</h3>
                    <p class="card-text">Inscrivez les étudiants aux cours et gérez les inscriptions existantes.</p>
                    <a href="enrollments" class="btn btn-lg" style="background-color: #9c27b0; color: white;">Accéder aux Inscriptions</a>
                </div>
            </div>
        </div>
    </div>
</div>



<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>