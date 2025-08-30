package com.rcfsoft.myspringbootapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.sql.DataSource;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

@RestController
public class HelloController {

    @Autowired
    private DataSource dataSource;

    @GetMapping("/")
    public Map<String, Object> home() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Hello from Spring Boot!");
        response.put("timestamp", System.currentTimeMillis());
        response.put("version", "1.0.0");
        return response;
    }

    @GetMapping("/api/status")
    public Map<String, Object> status() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("application", "myspringbootapp");

        // Test database connectivity
        try (Connection conn = dataSource.getConnection()) {
            response.put("database", "Connected");
            response.put("database_url", conn.getMetaData().getURL());
        } catch (Exception e) {
            response.put("database", "Error: " + e.getMessage());
        }

        return response;
    }

    @GetMapping("/api/health")
    public Map<String, String> health() {
        Map<String, String> response = new HashMap<>();
        response.put("status", "UP");
        return response;
    }
}
