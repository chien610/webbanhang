package com.demo.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.UniqueElements;

import java.io.Serializable;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Categories")
public class Category implements Serializable {
    @Id
    @NotBlank(message = "Vui lòng nhập vào mã")
    String id;

    @NotBlank(message = "Vui lòng nhập vào tên")
    String name;
}
