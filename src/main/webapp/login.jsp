<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduManager - Connexion</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 450px;
            margin: 100px auto;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .card-header {
            background: linear-gradient(to right, #007bff, #6610f2);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 20px;
        }
        .btn-login {
            background: linear-gradient(to right, #007bff, #6610f2);
            color: white;
            font-weight: bold;
            border: none;
            padding: 10px;
        }
        .logo-icon {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="container login-container">
    <div class="card">
        <div class="card-header text-center">
            <i class="fas fa-graduation-cap logo-icon"></i>
            <h3>EduManager</h3>
            <p class="mb-0">Système de Gestion Éducative</p>
        </div>
        <div class="card-body p-4">
            <h4 class="text-center mb-4">Connexion</h4>

            <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="error-message text-center">
                <%= request.getAttribute("errorMessage") %>
            </div>
            <% } %>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="username"><i class="fas fa-user mr-2"></i>Nom d'utilisateur</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock mr-2"></i>Mot de passe</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="form-group form-check">
                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                    <label class="form-check-label" for="rememberMe">Se souvenir de moi</label>
                </div>
                <button type="submit" class="btn btn-login btn-block">Se connecter</button>
            </form>
        </div>
        <div class="card-footer text-center text-muted">
            © 2025 EduManager - Tous droits réservés
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>