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
import model.Enums.OrderStatus;

/**
 *
 * @author erwin
 */
@Stateless
public class ProductFacade extends AbstractFacade<Product> {

    @PersistenceContext(unitName = "EpdaAssignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
    @Override
    public void remove(Product product) {
        product.setIsDeleted(true);
        this.edit(product);
    }
    
    @Override
    public List<Product> findAll() {
        List<Product> allRecords = super.findAll();
        List<Product> allProducts = new ArrayList<>();
        
        for (Product product : allRecords) {
            if (product.getIsDeleted() == false) {
                allProducts.add(product);
            }
        }
        
        return allProducts;
    }

    public ProductFacade() {
        super(Product.class);
    }
    
    public List<Product> getAvailableProducts() {
        return em.createNamedQuery("Product.GetAvailableProducts")
                .getResultList();
    }
}
