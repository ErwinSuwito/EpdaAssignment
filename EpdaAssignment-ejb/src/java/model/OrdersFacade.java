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
    
    public void assignDeliveryStaff(Orders order, Users user) {
        order.setDeliveryStaff(user);
        order.setStatus(Enums.OrderStatus.Assigned);
        this.edit(order);
    }
    
    public void completeOrder(Orders order) {
        order.setStatus(Enums.OrderStatus.Delivered);
        order.setDeliveredTime(LocalDateTime.now());
        this.edit(order);
    }
}
