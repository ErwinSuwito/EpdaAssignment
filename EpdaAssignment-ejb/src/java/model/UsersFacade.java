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
public class UsersFacade extends AbstractFacade<Users> {

    @PersistenceContext(unitName = "EpdaAssignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsersFacade() {
        super(Users.class);
    }
    
    public Users findByEmail(String email) {
        try {
            Object user = em.createNamedQuery("Users.FindByEmail")
                .setParameter("email", email)
                .getSingleResult();
            return (Users)user;
        } catch (Exception ex) {
            return null;
        }
    }
    
    public List<Users> findAllCustomers() {
        return em.createNamedQuery("Users.FindCustomers")
                .getResultList();
    }
    
    public List<Users> findAllStaffs() {
        return em.createNamedQuery("Users.FindStaffs")
                .getResultList();
    }
    
    public List<Users> findDeliveryStaffs() {
        return em.createNamedQuery("Users.FindDeliveryStaffs")
                .getResultList();
    }
}
