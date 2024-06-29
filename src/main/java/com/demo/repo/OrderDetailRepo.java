package com.demo.repo;

import com.demo.model.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OrderDetailRepo extends JpaRepository<OrderDetail, Long> {
    @Query("SELECT od FROM OrderDetail od WHERE od.order.id = ?1")
    List<OrderDetail> getOrderDetailById(Long id);
}
