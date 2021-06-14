package com.fpt.todoit.controller;

import com.fpt.todoit.common.Response;
import com.fpt.todoit.common.SimpleResponse;
import com.fpt.todoit.dto.UserDto;
import com.fpt.todoit.entity.User;
import com.fpt.todoit.service.UserService;
import com.fpt.todoit.util.DTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("api/users")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    UserService userService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ResponseEntity<Response<User>> addUser(@DTO(UserDto.class) User user) {
        User result = userService.save(user);
        if (result != null) {
            SimpleResponse<User> simpleResponse = new SimpleResponse(HttpStatus.OK, "Created", result);
            ResponseEntity response = new ResponseEntity<Response<User>>(simpleResponse, HttpStatus.OK);
            return response;
        } else {
            return new ResponseEntity<Response<User>>(new SimpleResponse<User>(HttpStatus.FORBIDDEN, "Create error"),
                                                      HttpStatus.OK
            );
        }
    }


    @RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Response<Object>> deleteUser(@PathVariable Long id) {
        try {
            userService.deleteById(id);
            SimpleResponse<Object> simpleResponse = new SimpleResponse(HttpStatus.OK, "Deleted");
            return new ResponseEntity<Response<Object>>(simpleResponse, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<Response<Object>>(
                    new SimpleResponse<Object>(HttpStatus.FORBIDDEN, e.getMessage()), HttpStatus.OK);
        }
    }

}
