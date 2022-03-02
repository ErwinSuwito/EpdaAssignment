/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import helpers.SortOrdersById;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import model.Enums.OrderStatus;

/**
 *
 * @author erwin
 */
@Stateless
public class OrdersFacade extends AbstractFacade<Orders> {

    @PersistenceContext(unitName = "EpdaAssignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
    @Override
    public void remove(Orders order) {
        order.setStatus(OrderStatus.Deleted);
        this.edit(order);
    }
    
    @Override
    public List<Orders> findAll() {
        List<Orders> allOrders = super.findAll();
        ArrayList<Orders> filteredOrders = new ArrayList<>();
        
        for (Orders order : allOrders) {
            if (order.getStatus() != OrderStatus.Deleted) {
                filteredOrders.add(order);
            }
        }
        
        return filteredOrders;
    }

    public OrdersFacade() {
        super(Orders.class);
    }

    public List<Orders> getPendingOrders() {
        return em.createNamedQuery("Orders.GetPendingOrders")
                .getResultList();
    }

    public List<Orders> getAssignedOrders() {
        return em.createNamedQuery("Orders.GetAssignedOrders")
                .getResultList();
    }

    public List<Orders> getDeliveringOrders() {
        return em.createNamedQuery("Orders.GetDeliveringOrders")
                .getResultList();
    }

    public List<Orders> getDeliveredOrders() {
        return em.createNamedQuery("Orders.GetDeliveredOrders")
                .getResultList();
    }

    public List<Orders> getRecentOrders(Users customer) {
        return em.createNamedQuery("Orders.GetRecentOrders")
                .setParameter("customer", customer)
                .getResultList();
    }

    public List<Orders> getCustomerOrders(Users customer) {
        return em.createNamedQuery("Orders.GetCustomerOrders")
                .setParameter("customer", customer)
                .getResultList();
    }
    
    public List<Orders> getCustomerOrdersFilteredByStatus(Users customer, OrderStatus status) {
        return em.createNamedQuery("Orders.GetCustomerOrdersFilteredByStatus")
                .setParameter("customer", customer)
                .setParameter("status", status)
                .getResultList();
    }

    public List<Orders> getAssignedDeliveries(Users staff) {
        List<Orders> allAssignedDeliveries = em.createNamedQuery("Orders.GetAssignedDeliveries")
                .setParameter("deliveryStaff", staff)
                .getResultList();
        List<Orders> filteredDeliveries = new ArrayList<>();
        for (Orders order : allAssignedDeliveries) {
            if (order.getStatus() != OrderStatus.Deleted) {
                filteredDeliveries.add(order);
            }
        }
        
        return filteredDeliveries;
    }
    
    public List<Orders> getAssignedDeliveriesFilteredByStatus(Users staff, OrderStatus status) {
        return em.createNamedQuery("Orders.GetAssignedDeliveriesFilteredByStatus")
                .setParameter("deliveryStaff", staff)
                .setParameter("status", status)
                .getResultList();
    }

    public void assignDeliveryStaff(Orders order, Users user) {
        order.setDeliveryStaff(user);
        order.setAssignedTime(LocalDateTime.now());
        order.setStatus(Enums.OrderStatus.Assigned);
        this.edit(order);
    }
    
    public void startDelivery(Orders order) {
        order.setStatus(Enums.OrderStatus.Delivering);
        this.edit(order);
    }

    public void completeOrder(Orders order) {
        order.setStatus(Enums.OrderStatus.Delivered);
        order.setDeliveredTime(LocalDateTime.now());
        this.edit(order);
    }
}
