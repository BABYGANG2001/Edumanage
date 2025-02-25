package com.example.edumanager.model;


public class User {
    private int id;
    private String username;
    private String password;
    private String role;


    public User() {
    }


    public User(String username, String password, String role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    //Vérifie si le mot de passe fourni correspond au mot de passe de l'utilisateur

    public boolean checkPassword(String rawPassword) {
        return this.password.equals(rawPassword);
    }

    public boolean hasRole(String roleToCheck) {
        return this.role.equals(roleToCheck);
    }
}