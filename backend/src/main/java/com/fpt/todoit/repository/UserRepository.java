package com.fpt.todoit.repository;

import com.fpt.todoit.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    User findByUserNameContaining(String name);

    User findByEmailContaining(String email);

    @Transactional
    void deleteByUserId(Long userId);

    boolean existsByUserId(Long userId);
}
