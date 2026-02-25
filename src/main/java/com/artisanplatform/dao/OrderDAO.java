package com.artisanplatform.dao;

import com.artisanplatform.model.Order;
import java.util.List;

public interface OrderDAO {

    int insertOrder(Order order); // return generated orderId

    Order getOrderById(int orderId);

    List<Order> getOrdersByUser(int userId);

    List<Order> getAllOrders();

    boolean updateOrderStatus(int orderId, String status);
}