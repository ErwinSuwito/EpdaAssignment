/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.persistence.CascadeType;
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
public class Orders implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @OneToOne
    private Customer customer;
    @OneToOne
    private Staff deliveryStaff;
    @OneToMany(cascade = CascadeType.REMOVE)
    private ArrayList<OrderProduct> basket;
    private String address;
    private OrderStatus status;
    private LocalDateTime deliveredTime;
    private double totalAmount;

    public Orders(Long id, Customer customer, Staff deliveryStaff, ArrayList<OrderProduct> basket, String address, OrderStatus status, LocalDateTime deliveredTime, double totalAmount) {
        this.id = id;
        this.customer = customer;
        this.deliveryStaff = deliveryStaff;
        this.basket = basket;
        this.address = address;
        this.status = status;
        this.deliveredTime = deliveredTime;
        this.totalAmount = totalAmount;
    }

    public Orders(Customer customer, Staff deliveryStaff, ArrayList<OrderProduct> basket, String address, OrderStatus status, double totalAmount) {
        this.customer = customer;
        this.deliveryStaff = deliveryStaff;
        this.basket = basket;
        this.address = address;
        this.status = status;
        this.totalAmount = totalAmount;
    }

    public Orders() {
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Staff getDeliveryStaff() {
        return deliveryStaff;
    }

    public void setDeliveryStaff(Staff deliveryStaff) {
        this.deliveryStaff = deliveryStaff;
    }

    public ArrayList<OrderProduct> getProductBasket() {
        return basket;
    }

    public void setProductBasket(ArrayList<OrderProduct> productBasket) {
        this.basket = productBasket;
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
        if (!(object instanceof Orders)) {
            return false;
        }
        Orders other = (Orders) object;
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
