/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import model.Enums.LoginStateRole;

/**
 *
 * @author erwin
 */
@Entity
@NamedQueries({
    @NamedQuery(name = "Users.FindByEmail",
            query = "SELECT u FROM Users u WHERE u.email = :email AND u.isDeleted = false"),
    @NamedQuery(name = "Users.FindCustomers",
            query = "SELECT u FROM Users u WHERE u.role = model.Enums.LoginStateRole.Customer AND u.isDeleted = false"),
    @NamedQuery(name = "Users.FindStaffs",
            query = "SELECT u FROM Users u WHERE u.role != model.Enums.LoginStateRole.Customer AND u.isDeleted = false"),
    @NamedQuery(name = "Users.FindDeliveryStaffs",
            query = "SELECT u FROM Users u WHERE u.role = model.Enums.LoginStateRole.DeliveryStaff AND u.isDeleted = false")
})
public class Users implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String email;
    private String password;
    private String name;
    private Boolean isMale;
    private String phoneNumber;
    private String icNumber;
    private LoginStateRole role;
    private Boolean isDeleted;

    public Users(Long id, String email, String password, String name, Boolean isMale, String phoneNumber, String icNumber, LoginStateRole role, Boolean isDeleted) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.name = name;
        this.isMale = isMale;
        this.phoneNumber = phoneNumber;
        this.icNumber = icNumber;
        this.role = role;
        this.isDeleted = isDeleted;
    }

    public Users(String email, String password, String name, Boolean isMale, String phoneNumber, String icNumber, LoginStateRole role) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.isMale = isMale;
        this.phoneNumber = phoneNumber;
        this.icNumber = icNumber;
        this.role = role;
        this.isDeleted = false;
    }

    public Users(String email, String password, String name, String phoneNumber) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.role = LoginStateRole.Customer;
        this.isDeleted = false;
    }

    public Users() {
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getIsMale() {
        return isMale;
    }

    public void setIsMale(Boolean isMale) {
        this.isMale = isMale;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getIcNumber() {
        return icNumber;
    }

    public void setIcNumber(String icNumber) {
        this.icNumber = icNumber;
    }

    public LoginStateRole getRole() {
        return role;
    }

    public void setRole(LoginStateRole role) {
        this.role = role;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Users)) {
            return false;
        }
        Users other = (Users) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Users[ id=" + id + " ]";
    }
    
}
