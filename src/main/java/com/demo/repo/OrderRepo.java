package com.demo.repo;

import com.demo.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OrderRepo extends JpaRepository<Order, Long> {
    @Query("SELECT o FROM Order o WHERE o.account.username LIKE ?1")
    List<Order> findAllByAccount(String username);
}
