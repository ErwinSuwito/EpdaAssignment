/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
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
    
    @Override
    public void remove(Users user) {
        user.setIsDeleted(true);
        this.edit(user);
    }
    
    @Override
    public List<Users> findAll() {
        List<Users> allRecords = super.findAll();
        List<Users> allUsers = new ArrayList<>();
        
        for (Users user : allRecords) {
            if (user.getIsDeleted() == false) {
                allUsers.add(user);
            }
        }
        
        return allUsers;
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
