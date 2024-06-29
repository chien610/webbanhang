package com.demo.service;

import com.demo.model.Category;
import com.demo.model.Order;
import com.demo.repo.CategoryRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

//TODO: Connect to database

@Service
public class CategoryService {
    @Autowired
    private CategoryRepo categoryRepo;

    public List<Category> getAll(){
        return this.categoryRepo.findAll();
    }
}
