package com.demo.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Accounts")
public class Account implements Serializable {
    @Id
    @NotBlank(message = "Vui lòng điền vào tên đăng nhập")
    String username;

    @NotBlank(message = "Vui lòng điền vào mật khẩu")
    String password;

    @NotBlank(message = "Vui lòng điền vào họ và tên")
    String fullname;

    @NotBlank(message = "Vui lòng điền vào email")
    String email;
    String photo;

    Boolean activated;
    Boolean admin;
}
