package com.artisanplatform.dao;

import com.artisanplatform.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {

    boolean insertOrderItem(OrderItem orderItem);

    List<OrderItem> getItemsByOrderId(int orderId);
}
