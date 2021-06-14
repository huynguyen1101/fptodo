package com.fpt.todoit.service;

import com.fpt.todoit.common.IBaseService;
import com.fpt.todoit.entity.User;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

public interface UserService extends IBaseService<User> {

    User save(User user);

    Optional<User> getUserById(Long userId);

    User findUserByName(String name);

    User findUserByEmail(String email);

    void deleteById(Long userId);

    boolean isExist(Long userId);
}
