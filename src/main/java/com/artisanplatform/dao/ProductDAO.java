package com.artisanplatform.dao;

import com.artisanplatform.model.Product;
import java.util.List;

public interface ProductDAO {

    boolean insertProduct(Product product);

    boolean updateProduct(Product product);

    boolean deleteProduct(int productId);

    Product getProductById(int productId);

    List<Product> getAllProducts();

    List<Product> getProductsByCategory(int categoryId);

    boolean updateStock(int productId, int newStock);
}
