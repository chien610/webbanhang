package com.demo.repo;

import com.demo.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductRepo extends JpaRepository<Product, Integer> {
    @Query("SELECT p FROM Product p WHERE p.name LIKE ?1 OR p.category.name LIKE ?1")
    Page<Product> findByNameAndCategory(String kw, Pageable pageable);

    @Query("SELECT p FROM Product p WHERE p.name LIKE :kw " +
            "AND p.category.id LIKE :id AND p.price BETWEEN :min AND :max AND p.available = TRUE")
    Page<Product> findByProductsCustomer(
            @Param("kw") String kw,
            @Param("id") String id,
            @Param("min") Integer minValue,
            @Param("max") Integer maxValue,
            Pageable pageable
    );
}
