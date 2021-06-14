package com.fpt.todoit.common;

import org.springframework.http.HttpStatus;

public abstract class Response<M> {

    public HttpStatus status;
    public String message;
    public M response;

    public HttpStatus getStatus() {
        return status;
    }

    public void setStatus(HttpStatus status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public M getResponse() {
        return response;
    }

    public void setResponse(M response) {
        this.response = response;
    }
}
