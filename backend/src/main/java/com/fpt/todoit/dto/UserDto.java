package com.fpt.todoit.dto;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Setter
@Getter
public class UserDto {
    @Id
    @NotNull
    private Long userId;
    private String firstName;
    private String lastName;
    @NotNull
    private String email;
    private String gender;
    @NotNull
    private String userName;
    @NotNull
    private String password;
}
