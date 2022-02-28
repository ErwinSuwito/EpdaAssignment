/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package viewmodels;

import java.util.ArrayList;
import java.util.List;
import model.OrderProduct;

/**
 *
 * @author erwin
 */
public class CartCheckResultViewModel {
    private ArrayList<OrderProduct> cart;
    private Boolean anyModifications = false;
    
    public CartCheckResultViewModel(ArrayList<OrderProduct> cart, Boolean anyModifications) {
        this.cart = cart;
        this.anyModifications = anyModifications;
    }

    public ArrayList<OrderProduct> getCart() {
        return cart;
    }

    public void setCart(ArrayList<OrderProduct> cart) {
        this.cart = cart;
    }

    public Boolean getAnyModifications() {
        return anyModifications;
    }

    public void setAnyModifications(Boolean anyModifications) {
        this.anyModifications = anyModifications;
    }
    
}
