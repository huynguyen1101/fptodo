package com.fpt.todoit.service.impl;

import com.fpt.todoit.entity.User;
import com.fpt.todoit.repository.UserRepository;
import com.fpt.todoit.service.UserService;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public Optional<User> getUserById(Long userId) {
        return userRepository.findById(userId);
    }

    @Override
    public User findUserByName(String name) {
        return userRepository.findByUserNameContaining(name);
    }

    @Override
    public User findUserByEmail(String email) {
        return userRepository.findByEmailContaining(email);
    }

    @Override
    public void delete(User user) {
        userRepository.delete(user);
    }

    @Override
    public void deleteById(Long userId) {
        userRepository.deleteByUserId(userId);
    }

    @Override
    public boolean isExist(Long userId) {
        return userRepository.existsByUserId(userId);
    }

    @Override
    public void flush() {
        userRepository.flush();
    }

    @Override
    public boolean exists(Example<User> model) {
        return userRepository.exists(model);
    }
}
