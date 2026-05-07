package com.khel.khelposhak.utils;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author akashadhikari
 */
public class PasswordUtil {

    public static String getHashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    public static boolean checkPassword(String password, String hash) {
        return BCrypt.checkpw(password, hash);
    
}
}