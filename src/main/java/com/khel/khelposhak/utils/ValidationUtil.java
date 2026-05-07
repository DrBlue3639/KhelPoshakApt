package com.khel.khelposhak.utils;

import java.util.regex.Pattern;

/**
 *
 * @author akashadhikari
 */

public class ValidationUtil {

    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }

    public static boolean isValidEmail(String email) {
        String regex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(regex, email);
    }

    public static boolean isValidPassword(String password) {
        String regex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{6,}$";
        return password != null && password.matches(regex);
    }

    public static boolean doPasswordsMatch(String p1, String p2) {
        return p1 != null && p1.equals(p2);
    }
}