package com.example.demo_authorization.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/secure")
public class SecureController {

    @GetMapping("/seller")
    public String sellerEndpoint(@AuthenticationPrincipal Jwt jwt) {
        return "Hello, " + jwt.getClaim("preferred_username") + "! You have access as a SELLER.";
    }

    @GetMapping("/customer")
    public String customerEndpoint(@AuthenticationPrincipal Jwt jwt) {
        return "Hello, " + jwt.getClaim("preferred_username") + "! You have access as a CUSTOMER.";
    }
}
