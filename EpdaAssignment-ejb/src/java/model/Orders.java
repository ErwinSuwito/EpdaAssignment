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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import model.Enums.OrderStatus;

/**
 *
 * @author erwin
 */
@Entity
@NamedQueries({
    @NamedQuery(name = "Orders.GetPendingOrders",
            query = "SELECT o FROM Orders o WHERE o.status = model.Enums.OrderStatus.Pending"),
    @NamedQuery(name = "Orders.GetAssignedOrders",
            query = "SELECT o FROM Orders o WHERE o.status = model.Enums.OrderStatus.Assigned"),
    @NamedQuery(name = "Orders.GetDeliveringOrders",
            query = "SELECT o FROM Orders o WHERE o.status = model.Enums.OrderStatus.Delivering"),
    @NamedQuery(name = "Orders.GetDeliveredOrders",
            query = "SELECT o FROM Orders o WHERE o.status = model.Enums.OrderStatus.Delivered"),
    @NamedQuery(name = "Orders.GetCustomerOrders",
            query = "SELECT o FROM Orders o WHERE o.customer = :customer"),
    @NamedQuery(name = "Orders.GetCustomerOrdersFilteredByStatus",
            query = "SELECT o FROM Orders o WHERE o.customer = :customer AND o.status = :status"),
    @NamedQuery(name = "Orders.GetAssignedDeliveries",
            query = "SELECT o FROM Orders o WHERE o.deliveryStaff = :deliveryStaff"),
    @NamedQuery(name = "Orders.GetAssignedDeliveriesFilteredByStatus",
            query = "SELECT o FROM Orders o WHERE o.deliveryStaff = :deliveryStaff AND o.status = :status"),
})
public class Orders implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long id;
    @OneToOne
    private Users customer;
    @OneToOne
    private Users deliveryStaff;
    @OneToMany(cascade = CascadeType.PERSIST)
    private ArrayList<OrderProduct> basket;
    private String address;
    private OrderStatus status;
    private LocalDateTime submittedTime;
    private LocalDateTime deliveredTime;
    private LocalDateTime assignedTime;
    private double totalAmount;

    public Orders(Long id, Users customer, Users deliveryStaff, ArrayList<OrderProduct> basket, String address, OrderStatus status, LocalDateTime submittedTime, LocalDateTime deliveredTime, double totalAmount) {
        this.id = id;
        this.customer = customer;
        this.deliveryStaff = deliveryStaff;
        this.basket = basket;
        this.address = address;
        this.status = status;
        this.submittedTime = submittedTime;
        this.deliveredTime = deliveredTime;
        this.totalAmount = totalAmount;
    }

    public Orders(Users customer, ArrayList<OrderProduct> basket, String address, OrderStatus status, LocalDateTime submittedTime, double totalAmount) {
        this.customer = customer;
        this.basket = basket;
        this.address = address;
        this.status = status;
        this.submittedTime = submittedTime;
        this.totalAmount = totalAmount;
    }

    public Orders() {
    }
    
    public LocalDateTime getAssignedTime() {
        return assignedTime;
    }

    public void setAssignedTime(LocalDateTime assignedTime) {
        this.assignedTime = assignedTime;
    }

    public LocalDateTime getSubmittedTime() {
        return submittedTime;
    }

    public void setSubmittedTime(LocalDateTime submittedTime) {
        this.submittedTime = submittedTime;
    }

    public Users getCustomer() {
        return customer;
    }

    public void setCustomer(Users customer) {
        this.customer = customer;
    }

    public Users getDeliveryStaff() {
        return deliveryStaff;
    }

    public void setDeliveryStaff(Users deliveryStaff) {
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
