/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.time.LocalDateTime;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

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
    
    public List<Orders> getAssignedDeliveries(Users customer) {
        return em.createNamedQuery("Orders.GetAssignedDeliveries")
                .setParameter("deliveryStaff", customer)
                .getResultList();
    }

    public List<Orders> getRecentlyAssignedDeliveries(Users customer) {
        return em.createNamedQuery("Orders.GetRecentlyAssignedDeliveries")
                .setParameter("deliveryStaff", customer)
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
