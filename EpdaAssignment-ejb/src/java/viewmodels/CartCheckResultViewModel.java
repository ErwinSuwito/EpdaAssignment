/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package viewmodels;

import java.util.List;
import model.OrderProduct;

/**
 *
 * @author erwin
 */
public class CartCheckResultViewModel {
    private List<OrderProduct> cart;
    private Boolean anyModifications = false;
    
    public CartCheckResultViewModel(List<OrderProduct> cart, Boolean anyModifications) {
        this.cart = cart;
        this.anyModifications = anyModifications;
    }

    public List<OrderProduct> getCart() {
        return cart;
    }

    public void setCart(List<OrderProduct> cart) {
        this.cart = cart;
    }

    public Boolean getAnyModifications() {
        return anyModifications;
    }

    public void setAnyModifications(Boolean anyModifications) {
        this.anyModifications = anyModifications;
    }
    
}
