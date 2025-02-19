package com.example.edumanager.model;

public class Course {
    private int id;
    private String nomCours;
    private String description;

    public Course() {}

    public Course(String nomCours, String description) {
        this.nomCours = nomCours;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNomCours() {
        return nomCours;
    }

    public void setNomCours(String nomCours) {
        this.nomCours = nomCours;
    }
}