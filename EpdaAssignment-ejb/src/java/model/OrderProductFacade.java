/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author erwin
 */
@Stateless
public class OrderProductFacade extends AbstractFacade<OrderProduct> {

    @PersistenceContext(unitName = "EpdaAssignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrderProductFacade() {
        super(OrderProduct.class);
    }
    
    public List<OrderProduct> findByOrder(Orders order) {
        return em.createNamedQuery("OrderProduct.GetOrderProductByOrder")
                    .setParameter("order", order)
                    .getResultList();
    }
}
