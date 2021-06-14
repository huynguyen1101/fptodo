package com.fpt.todoit.common;

import com.fpt.todoit.entity.User;
import org.springframework.http.HttpStatus;

public class SimpleResponse<M> extends Response<M>{
    public SimpleResponse(){}

    public SimpleResponse(HttpStatus status, String message, M data){
        this.status = status;
        this.message = message;
        this.response = data;
    }

    public SimpleResponse(HttpStatus status, M data){
        this.status = status;
        this.response = data;
    }

    public SimpleResponse(HttpStatus status, String message){
        this.status = status;
        this.message = message;
    }
}
