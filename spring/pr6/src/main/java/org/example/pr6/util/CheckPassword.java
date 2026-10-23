package org.example.pr6.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class CheckPassword {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String rawPassword = "password123";
        String hashFromDB = "$2a$10$Z/TZSixR8bdKiNztK1Sjw.vfyJ83.bBQIsldkGeZopHk8HArgCt2K";
        System.out.println("Совпадает: " + encoder.matches(rawPassword, hashFromDB));
        System.out.println("Твой хеш: " + encoder.encode(rawPassword));
    }
}
