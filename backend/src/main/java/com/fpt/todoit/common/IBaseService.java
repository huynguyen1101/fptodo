package com.fpt.todoit.common;

import org.springframework.data.domain.Example;

import java.util.List;

public interface IBaseService<S> {

    List<S> findAll();

    boolean exists(Example<S> model);

    void flush();

    void delete(S model);
}
