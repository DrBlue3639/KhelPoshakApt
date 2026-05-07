
package com.khel.khelposhak.model;

public class UserModel {
    
    private int userId;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String role;
    
    public UserModel() {}
  
    public int getUserId() { return userId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getPhone() { return phone; }
    public String getAddress() { return address; }
    public String getRole() { return role; }
    
    public void setUserId(int userId) { this.userId = userId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setAddress(String address) { this.address = address; }
    public void setRole(String role) { this.role = role; }
    
    public boolean isAdmin() {
        return "ADMIN".equals(role);
    
    }
    
//    @Override
//    public String toString() {
//    return "UserModel{" +
//            "userId=" + userId +
//            ", fullName='" + fullName + '\'' +
//            ", email='" + email + '\'' +
//            ", password='" + password + '\'' +
//            ", phone='" + phone + '\'' +
//            ", address='" + address + '\'' +
//            ", role='" + role + '\'' +
//            '}';
//}
    
}
