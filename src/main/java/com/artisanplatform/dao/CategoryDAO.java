package com.artisanplatform.dao;

import com.artisanplatform.model.Category;
import java.util.List;

public interface CategoryDAO {

    boolean insertCategory(Category category);

    boolean updateCategory(Category category);

    boolean deleteCategory(int categoryId);

    Category getCategoryById(int categoryId);

    List<Category> getAllCategories();
}