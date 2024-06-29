package com.demo.service;

import com.demo.model.Category;
import com.demo.model.Product;
import com.demo.repo.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductService {
    private final ProductRepo productRepo;

    ProductService(ProductRepo productRepo) {
        this.productRepo = productRepo;
    }

    public Page<Product> getAll(
            String keyword,
            String categoryId,
            Integer minValue,
            Integer maxValue,
            int page
    ) {
        Pageable pageable = PageRequest.of(page, 6);
        return this.productRepo.findByProductsCustomer(keyword, categoryId, minValue, maxValue, pageable);
    }


    public Product findById(int id) {
        for (Product p : this.productRepo.findAll()) {
            if (p.getId() == id) return p;
        }
        return null;
    }
}
