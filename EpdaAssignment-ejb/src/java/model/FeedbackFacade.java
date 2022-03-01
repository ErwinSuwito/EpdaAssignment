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
public class FeedbackFacade extends AbstractFacade<Feedback> {

    @PersistenceContext(unitName = "EpdaAssignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
    @Override
    public void remove(Feedback feedback) {
        feedback.setIsDeleted(true);
        this.edit(feedback);
    }
    
    @Override
    public List<Feedback> findAll() {
        List<Feedback> allRecords = super.findAll();
        List<Feedback> allFeedbacks = new ArrayList<>();
        
        for (Feedback feedback : allRecords) {
            if (feedback.getIsDeleted() == false) {
                allFeedbacks.add(feedback);
            }
        }
        
        return allFeedbacks;
    }
    
    public FeedbackFacade() {
        super(Feedback.class);
    }
    
}
