package com.artisanplatform.dao;

import com.artisanplatform.model.User;
import java.util.List;

public interface UserDAO {

    boolean insertUser(User user);

    User login(String email, String password);

    User getUserById(int userId);

    User getUserByEmail(String email);

    List<User> getAllUsers();
}