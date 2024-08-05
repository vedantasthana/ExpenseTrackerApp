package com.example.demo.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "users")
@Data
@Getter
public class User{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String email;
    private String password;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Expense> expenses;

    @OneToMany(mappedBy = "admin", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Group> createdGroups;

    @ManyToMany(mappedBy = "users", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Group> groups;

    @OneToMany(mappedBy = "payer", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Split> paySplits;

    @OneToMany(mappedBy = "payee", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Split> receiveSplits;

    @OneToMany(mappedBy = "payer", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Settlements> paidSettlements;

    @OneToMany(mappedBy = "receiver", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Settlements> receivedSettlements;
    
    // Constructors, setters, and getters
    public User(){}

    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Expense> getExpenses() {
        return expenses;
    }

    public void setExpenses(List<Expense> expenses) {
        this.expenses = expenses;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", username=" + username + ", email=" + email + ", password=" + password + "]";
    }
}