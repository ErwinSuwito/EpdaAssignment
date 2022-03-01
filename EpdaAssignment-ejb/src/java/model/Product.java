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

/**
 *
 * @author erwin
 */
@Entity
@NamedQueries({
    @NamedQuery(name = "Product.GetAvailableProducts",
            query = "SELECT p FROM Product p WHERE p.quantity > 0 AND p.isDeleted = false"),
})
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String productName;
    private String description;
    private int quantity;
    private double price;
    private String productImage;
    private Boolean isDeleted;

    public Product(Long id, String productName, String description, int quantity, double price, String productImage, Boolean isDeleted) {
        this.id = id;
        this.productName = productName;
        this.description = description;
        this.quantity = quantity;
        this.price = price;
        this.productImage = productImage;
        this.isDeleted = isDeleted;
    }

    public Product(String productName, String description, int quantity, double price, String productImage) {
        this.productName = productName;
        this.description = description;
        this.quantity = quantity;
        this.price = price;
        this.productImage = productImage;
        this.isDeleted = false;
    }

    public Product() {
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public void incrementQuantity(int q) {
        this.quantity += q;
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
        if (!(object instanceof Product)) {
            return false;
        }
        Product other = (Product) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Product[ id=" + id + " ]";
    }
    
}
