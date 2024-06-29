package com.demo.model;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Products")
public class Product implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @NotBlank(message = "Vui lòng điền vào tên sản phẩm")
    String name;

    @NotNull(message = "Vui lòng điền vào giá sản phẩm")
    @Min(value = 0, message = "Giá tối thiểu là 0đ")
    Integer price;

    @ManyToOne
    @JoinColumn(name = "Categoryid")
    @NotNull(message = "Vui lòng chọn nhóm sản phẩm")
    Category category;

    String image;
    String createdate;
    Boolean available;
}
