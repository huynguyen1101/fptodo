package com.fpt.todoit.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "users")
public class User implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;
    @Column(length = 50, columnDefinition = "nvarchar(50)")
    private String firstName;
    @Column(length = 50, columnDefinition = "nvarchar(50)")
    private String lastName;
    @Column(length = 100, columnDefinition = "nvarchar(100) not null")
    private String email;
    @Column(length = 10, columnDefinition = "nvarchar(10)")
    private String gender;
    @Column(length = 50, columnDefinition = "nvarchar(50) not null")
    private String userName;
    @Column(length = 20, nullable = false)
    private String password;
}
