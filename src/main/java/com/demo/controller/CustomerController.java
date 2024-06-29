package com.demo.controller;

import com.demo.model.Account;
import com.demo.model.Order;
import com.demo.model.OrderDetail;
import com.demo.model.Product;
import com.demo.repo.AccountRepo;
import com.demo.repo.OrderDetailRepo;
import com.demo.repo.OrderRepo;
import com.demo.service.CartService;
import com.demo.service.CategoryService;
import com.demo.service.ProductService;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class CustomerController {
    @Autowired
    HttpSession session;

    @Autowired
    CategoryService categoryService;

    @Autowired
    ProductService productService;

    @Autowired
    AccountRepo accountRepo;

    @Autowired
    OrderRepo orderRepo;

    @Autowired
    OrderDetailRepo orderDetailRepo;

    @Autowired
    CartService cartService;

    @ModelAttribute("cart")
    CartService getCartService() {
        return cartService;
    }

    @Data
    @AllArgsConstructor
    public static class PriceRange {
        int id;
        int minValue;
        int maxValue;
        String display;
    }

    List<PriceRange> priceRangeList = Arrays.asList(
            new PriceRange(0, 0, Integer.MAX_VALUE, "Tất cả"),
            new PriceRange(1, 0, 10000000, "Dưới 10 triệu"),
            new PriceRange(2, 10000000, 20000000, "Từ 10-20 triệu"),
            new PriceRange(3, 20000000, Integer.MAX_VALUE, "Trên 20 triệu")
    );

    @RequestMapping("/")
    public String index(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "") String categoryId,
            @RequestParam(defaultValue = "0") int priceRangeId,
            @RequestParam(defaultValue = "0") int page,
            Model model
    ) {

        int minPrice = priceRangeList.get(priceRangeId).minValue;
        int maxPrice = priceRangeList.get(priceRangeId).maxValue;

        Page p = this.productService.getAll(
                "%" + keyword + "%", "%" + categoryId + "%",
                minPrice, maxPrice, page
        );

        model.addAttribute("priceRangeList", priceRangeList);
        model.addAttribute("categoryList", categoryService.getAll());
        model.addAttribute("productList", p);
        model.addAttribute("carts", cartService.getItems().size());

        if (!keyword.trim().isEmpty() || !categoryId.trim().isEmpty() || priceRangeId != 0) {
            model.addAttribute("pagination", 1);
        }

        String paginationForSearch = "?keyword=" + keyword + "&categoryId=" + categoryId +
                "&priceRangeId=" + priceRangeId;

        model.addAttribute("paginationForSearch", paginationForSearch);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalProducts", p.getTotalElements());
        model.addAttribute("totalPage", p.getTotalPages());
        model.addAttribute("account", session.getAttribute("account"));
        return "customer/index";
    }

    @GetMapping("/detail/{id}")
    public String viewProduct(@PathVariable int id, Model model) {
        Product product = productService.findById(id);
        model.addAttribute("product", product);
        model.addAttribute("carts", cartService.getItems().size());
        return "customer/detail";
    }

    @RequestMapping("/add-to-cart/{id}")
    public String addToCart(@PathVariable int id) {
        cartService.add(id);
        return "redirect:/cart";
    }

    @RequestMapping("/remove-cart/{id}")
    public String removeCart(@PathVariable int id) {
        cartService.remove(id);
        if (cartService.getTotal() == 0) {
            return "redirect:/";
        }
        return "redirect:/cart";
    }

    @RequestMapping("/update-cart/{id}")
    public String updateCart(@PathVariable int id, int quantity) {
        cartService.update(id, quantity);
        return "redirect:/cart";
    }

    @GetMapping("/cart")
    public String cart(Model model) {
        model.addAttribute("carts", cartService.getItems().size());
        return "customer/cart";
    }

    @GetMapping("/checkout")
    public String confirm() {
        if (session.getAttribute("account") == null) {
            return "redirect:/login";
        }
        return "customer/checkout";
    }

    @RequestMapping("/about")
    public String about(Model model) {
        model.addAttribute("carts", cartService.getItems().size());
        return "customer/about";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, Model model) {
        List<Account> accounts = this.accountRepo.findAll();
        for (Account a : accounts) {
            if (a.getUsername().equals(username) && a.getPassword().equals(password)) {
                Account acc = new Account();
                acc.setUsername(username);
                acc.setPhoto(a.getPhoto());
                session.setAttribute("account", acc);
                session.setAttribute("username", acc.getUsername());
                return "redirect:/";
            }
        }
        model.addAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
        return "login";
    }

    @PostMapping("/purchase")
    public String purchase(@RequestParam String address) {
        System.out.println("address=" + address);
        System.out.println("items=" + cartService.getItems());
        Account acc = (Account) session.getAttribute("account");
        if (acc != null) {
            Order order = new Order();
            order.setAccount(acc);
            order.setAddress(address);
            //TODO: Save order

            this.orderRepo.save(order);

            for (OrderDetail item : cartService.getItems()) {
                item.setOrder(order);
                // TODO: Save order detail

                this.orderDetailRepo.save(item);
            }
            // TODO :clear cart
        }
        cartService.clear();
        return "redirect:/";
    }

    @GetMapping("/purchase-history")
    public String purchaseHistory(Model model) {
        String user = (String) session.getAttribute("username");
        model.addAttribute("oders", this.orderRepo.findAllByAccount(user));
        return "customer/histories";
    }

    @GetMapping("/purchase-details/{id}")
    public String purchaseDetails(Model model, @PathVariable Long id) {
        model.addAttribute("oders", this.orderDetailRepo.getOrderDetailById(id));
        return "customer/oderdetails";
    }

    @GetMapping("/logout")
    public String logout() {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String register(@ModelAttribute("account") Account account) {
        return "register";
    }
}
