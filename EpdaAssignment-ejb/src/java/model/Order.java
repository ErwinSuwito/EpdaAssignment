/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import model.Enums.OrderStatus;

/**
 *
 * @author erwin
 */
@Entity
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @OneToOne
    private User customer;
    @OneToOne
    private User deliveryStaff;
    @OneToMany
    private ArrayList<Product> productBasket;
    private String address;
    private OrderStatus status;
    private LocalDateTime deliveryTime;
    private LocalDateTime actualDeliveryTime;
    private LocalDateTime deliveredTime;
    private double totalAmount;

    public Order(Long id, User customer, User deliveryStaff, ArrayList<Product> productBasket, String address, OrderStatus status, LocalDateTime deliveryTime, LocalDateTime actualDeliveryTime, LocalDateTime deliveredTime, double totalAmount) {
        this.id = id;
        this.customer = customer;
        this.deliveryStaff = deliveryStaff;
        this.productBasket = productBasket;
        this.address = address;
        this.status = status;
        this.deliveryTime = deliveryTime;
        this.actualDeliveryTime = actualDeliveryTime;
        this.deliveredTime = deliveredTime;
        this.totalAmount = totalAmount;
    }

    public Order(User customer, ArrayList<Product> productBasket, String address, OrderStatus status, LocalDateTime deliveryTime, double totalAmount) {
        this.customer = customer;
        this.productBasket = productBasket;
        this.address = address;
        this.status = status;
        this.deliveryTime = deliveryTime;
        this.totalAmount = totalAmount;
    }

    public Order() {
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public User getDeliveryStaff() {
        return deliveryStaff;
    }

    public void setDeliveryStaff(User deliveryStaff) {
        this.deliveryStaff = deliveryStaff;
    }

    public ArrayList<Product> getProductBasket() {
        return productBasket;
    }

    public void setProductBasket(ArrayList<Product> productBasket) {
        this.productBasket = productBasket;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public LocalDateTime getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(LocalDateTime deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public LocalDateTime getActualDeliveryTime() {
        return actualDeliveryTime;
    }

    public void setActualDeliveryTime(LocalDateTime actualDeliveryTime) {
        this.actualDeliveryTime = actualDeliveryTime;
    }

    public LocalDateTime getDeliveredTime() {
        return deliveredTime;
    }

    public void setDeliveredTime(LocalDateTime deliveredTime) {
        this.deliveredTime = deliveredTime;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
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
        if (!(object instanceof Order)) {
            return false;
        }
        Order other = (Order) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Order[ id=" + id + " ]";
    }
    
}
