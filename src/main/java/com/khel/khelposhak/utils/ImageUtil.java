package com.khel.khelposhak.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ImageUtil {

    public static String uploadImage(HttpServletRequest request, Part filePart, String uploadFolder) {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        try {
            // Get original filename
            String fileName = getFileName(filePart);
            if (fileName == null || fileName.isEmpty()) {
                return null;
            }
            
            // Create unique filename with timestamp
            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = timestamp + "_" + System.currentTimeMillis() + extension;
            
            // Get the absolute path where the app is running
            String appPath = request.getServletContext().getRealPath("");
            String savePath = appPath + File.separator + uploadFolder;
            
            // Create folder if it doesn't exist
            File folder = new File(savePath);
            if (!folder.exists()) {
                folder.mkdirs();
            }
            
            // Save the file
            String filePath = savePath + File.separator + newFileName;
            filePart.write(filePath);
            
            // Return relative path for database
            return uploadFolder + "/" + newFileName;
            
        } catch (Exception e) {
            System.out.println("Image upload error: " + e.getMessage());
            return null;
        }
    }
    
    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }
}