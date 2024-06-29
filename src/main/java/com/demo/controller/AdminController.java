package com.demo.controller;

import com.demo.model.Account;
import com.demo.model.Category;
import com.demo.model.Product;
import com.demo.repo.AccountRepo;
import com.demo.repo.CategoryRepo;
import com.demo.repo.ProductRepo;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Controller
public class AdminController {
    @Autowired
    private CategoryRepo categoryRepo;

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private AccountRepo accountRepo;

    //  Category
    @GetMapping("/admin/category")
    public String listCategory(Model model) {
        model.addAttribute("categories", categoryRepo.findAll());
        return "admin/category/list";
    }

    @GetMapping("/admin/category/create")
    public String createCategory(Model model, @ModelAttribute("category") Category category) {
        model.addAttribute("category", category);
        return "admin/category/form";
    }

    @PostMapping("/admin/category/store")
    public String saveCategory(
            @ModelAttribute("category") @Valid Category category,
            BindingResult rs
    ) {
        if (!rs.hasErrors()) {
            this.categoryRepo.save(category);
            return "redirect:/admin/category";
        }
        return "admin/category/form";
    }

    @GetMapping("/admin/category/update/{id}")
    public String editCategory(
            @PathVariable String id,
            @ModelAttribute("category") Category category,
            Model model
    ) {
        Category c = this.categoryRepo.findById(id).get();
        model.addAttribute("category", c);
        model.addAttribute("status", "edit");
        return "admin/category/form";
    }

    @PostMapping("/admin/category/update/{id}")
    public String updateCategory(
            @PathVariable String id,
            @ModelAttribute("category") @Valid Category category,
            BindingResult rs,
            Model model
    ) {
        if (!rs.hasErrors()) {
            category.setId(id);
            this.categoryRepo.save(category);
            return "redirect:/admin/category";
        }
        model.addAttribute("status", "edit");
        return "admin/category/form";
    }

    @GetMapping("/admin/category/delete/{id}")
    public String removeCategory(@PathVariable String id, HttpSession session, Model model) {
        Category category = this.categoryRepo.findById(id).get();
        try {
            this.categoryRepo.delete(category);
            String removeSt = " <div class=\"bg-success rounded-3 p-3\">\n" +
                    "        <i class=\"fa-light fa-shield-check fa-lg me-2\" style=\"color: #ffffff\"></i>\n" +
                    "        <span class=\"text-white\">Đã xoá thành công nhóm sản phẩm!</span>\n" +
                    "    </div>";
            session.setAttribute("removeStatus", removeSt);
            return "redirect:/admin/category";
        } catch (Exception e) {
            e.printStackTrace();
            String removeSt = " <div class=\"bg-danger rounded-3 p-3\">\n" +
                    "        <i class=\"fa-light fa-triangle-exclamation fa-lg me-2\" style=\"color: #ffffff\"></i>\n" +
                    "        <span class=\"text-white\">Danh mục sản phẩm hiện đang được sử dụng!</span>\n" +
                    "    </div>";
            session.setAttribute("removeStatus", removeSt);
            return "redirect:/admin/category";
        }
    }

    //  Product
    @GetMapping("/admin/product")
    public String listProduct(@RequestParam(required = false, defaultValue = "0") Integer page, Model model) {
        Page<Product> p = this.paginationProducts(page, 5, Sort.by("id").ascending());
        model.addAttribute("page", page);
        model.addAttribute("products", p);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalProducts", p.getTotalElements());
        model.addAttribute("totalPage", p.getTotalPages());
        return "admin/product/list";
    }

    private Page<Product> paginationProducts(Integer pageNumber, int pageSize, Sort sort) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize, sort);
        Page page = this.productRepo.findAll(pageable);
        return page;
    }

    @GetMapping("/admin/product/create")
    public String createProduct(@ModelAttribute("product") Product product) {
        return "admin/product/create";
    }

    @PostMapping("/admin/product/store")
    public String saveProduct(
            @ModelAttribute("product") @Valid Product product,
            BindingResult rs,
            @RequestParam MultipartFile attach,
            Model model
    ) {
        String date = product.getCreatedate();
        try {
            if (rs.hasErrors()) {
                model.addAttribute("categoryId", 1);
                return "admin/product/create";
            }

            if (date == null || date.trim().isEmpty()) {
                product.setCreatedate(LocalDate.now().toString());
            }
            final String originalFilename = attach.getOriginalFilename();
            product.setImage("/static/images/" + originalFilename);

            this.productRepo.save(product);
            return "redirect:/admin/product";

        } catch (Exception e) {
            model.addAttribute("categoryId", 1);
            return "admin/product/create";
        }
    }

    @GetMapping("/admin/product/update/{id}")
    public String editProduct(@PathVariable int id, @ModelAttribute("product") Product product, Model model) {
        Product p = this.productRepo.findById(id).get();
        model.addAttribute("product", p);
        return "admin/product/edit";
    }

    @PostMapping("/admin/product/update/{id}")
    public String updateProduct(
            @PathVariable int id,
            @ModelAttribute("product") @Valid Product product,
            BindingResult rs,
            @RequestParam MultipartFile attach
    ) {
        String date = product.getCreatedate();
        product.setId(id);
        if (!rs.hasErrors()) {
            if (date == null || date.trim().isEmpty()) {
                product.setCreatedate(LocalDate.now().toString());
            }
            final String originalFilename = attach.getOriginalFilename();
            product.setImage("/static/images/" + originalFilename);

            this.productRepo.save(product);
            return "redirect:/admin/product";
        }
        return "admin/product/edit";
    }

    @ModelAttribute("categories")
    private List<Category> getCategory() {
        return this.categoryRepo.findAll();
    }

    @GetMapping("/admin/product-search")
    public String searchProducts(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "0") int page,
            HttpSession session,
            Model model
    ) {
        Pageable pageable = PageRequest.of(page, 5);
        Page p = this.productRepo.findByNameAndCategory("%" + keyword + "%", pageable);
        if (keyword == null || keyword.isEmpty()) {
            return "redirect:/admin/product";
        }
        session.setAttribute("kw", keyword);

        model.addAttribute("products", p);
        model.addAttribute("pageSearch", "product-search");
        model.addAttribute("page", page);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalProducts", p.getTotalElements());
        model.addAttribute("totalPage", p.getTotalPages());
        return "admin/product/list";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String removeProduct(@PathVariable Integer id, HttpSession session) {
        this.productRepo.deleteById(id);
        session.setAttribute("removeStatus", "Đã xoá thành công sản phẩm!");
        return "redirect:/admin/product";
    }

    //  Account
    @GetMapping("/admin/account")
    public String listAccount(@RequestParam(required = false, defaultValue = "0") Integer page, Model model) {
        Page<Account> acc = this.paginationAccounts(page, 5, Sort.by("fullname").ascending());

        model.addAttribute("pageNumber", page);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalAccounts", acc.getTotalElements());
        model.addAttribute("totalPage", acc.getTotalPages());
        model.addAttribute("accounts", acc);
        return "admin/account/list";
    }

    private Page<Account> paginationAccounts(int pageNumber, int pageSize, Sort sort) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize, sort);
        Page page = this.accountRepo.findAll(pageable);
        return page;
    }

    @GetMapping("/admin/account/create")
    public String createAccount(@ModelAttribute("account") Account account, Model model) {
        return "admin/account/create";
    }

    @PostMapping("/admin/account/store")
    public String saveAccount(
            @ModelAttribute("account") @Valid Account account,
            BindingResult rs,
            @RequestParam MultipartFile attach
    ) {
        if (!rs.hasErrors()) {
            final String originalFilename = attach.getOriginalFilename();
            account.setPhoto("/static/images/" + originalFilename);
            account.setActivated(true);
            this.accountRepo.save(account);
            return "redirect:/admin/account";
        }
        return "admin/account/create";
    }

    @PostMapping("/admin/account/create-account")
    public String saveAccountForUser(
            @ModelAttribute("account") @Valid Account account,
            BindingResult rs,
            @RequestParam MultipartFile attach
    ) {
        if (!rs.hasErrors()) {
            final String originalFilename = attach.getOriginalFilename();
            account.setPhoto("/static/images/" + originalFilename);
            account.setActivated(true);
            this.accountRepo.save(account);
            this.accountRepo.save(account);
            return "redirect:/login";
        }
        return "register";
    }

    @GetMapping("/admin/account/update/{username}")
    public String editAccount(
            @PathVariable String username,
            @ModelAttribute("account") Account acc,
            Model model
    ) {
        Account account = this.accountRepo.findById(username).get();
        model.addAttribute("account", account);
        return "admin/account/edit";
    }

    @PostMapping("/admin/account/update/{username}")
    public String updateAccount(
            @ModelAttribute("account") @Valid Account account,
            BindingResult rs,
            @PathVariable String username,
            @RequestParam MultipartFile attach
    ) {
        account.setUsername(username);
        if (!rs.hasErrors()) {
            final String originalFilename = attach.getOriginalFilename();
            account.setPhoto("/static/images/" + originalFilename);

            this.accountRepo.save(account);
            return "redirect:/admin/account";
        }
        return "admin/account/edit";
    }

    @GetMapping("/admin/account/delete/{username}")
    public String removeAccount(@PathVariable String username, HttpSession session) {
        Account account = this.accountRepo.findById(username).get();
        session.setAttribute("removeStatus", "Đã xoá thành công người dùng!");
        this.accountRepo.delete(account);
        return "redirect:/admin/account";
    }

    //Xoá trắng form
    @RequestMapping("/admin/account/clean-form")
    public String cleanForm(@ModelAttribute("account") Account account) {
        return "redirect:/admin/account/create";
    }

    @RequestMapping("/admin/product/clean-form")
    public String cleanForm(@ModelAttribute("product") Product product) {
        return "redirect:/admin/product/create";
    }
}
