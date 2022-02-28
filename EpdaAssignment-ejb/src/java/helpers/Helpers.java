/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package helpers;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.*;
import model.Enums.*;
import viewmodels.CartCheckResultViewModel;

/**
 *
 * @author erwin
 */
public class Helpers {

    public static OrderStatus getOrderStatus(String orderStatus) {
        switch (orderStatus) {
            case "Pending":
                return OrderStatus.Pending;

            case "Assigned":
                return OrderStatus.Assigned;

            case "Delivering":
                return OrderStatus.Delivering;

            case "Delivered":
                return Enums.OrderStatus.Delivered;
        }

        return null;
    }

    public static LoginStateRole checkLoginState(HttpSession session) {
        if (session != null) {
            if (session.getAttribute("login") != null) {
                Users user = (Users) session.getAttribute("login");
                return user.getRole();
            }
        }

        return LoginStateRole.LoggedOut;
    }

    public static CartCheckResultViewModel CheckCart(Orders order, ProductFacade productFacade) {
        List<OrderProduct> cart = order.getProductBasket();
        List<OrderProduct> fixedCart = order.getProductBasket();
        Boolean anyChanges = false;

        for (OrderProduct cartItem : cart) {
            Product product = productFacade.find(cartItem.getProduct().getId());
            if (product == null) {
                anyChanges = true;
                continue;
            }
            
            if (product.getQuantity() >= cartItem.getQuantityPurchased()) {
                fixedCart.add(cartItem);
            } else {
                if (product.getQuantity() == 0) {
                    anyChanges = true;
                } else {
                    cartItem.setQuantityPurchased(product.getQuantity());
                }
            }
        }

        return new CartCheckResultViewModel(fixedCart, anyChanges);
    }
}
