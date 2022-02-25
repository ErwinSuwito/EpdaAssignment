/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package helpers;

import javax.servlet.http.HttpSession;
import model.*;
import model.Enums.*;

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
                Users user = (Users)session.getAttribute("login");
                return user.getRole();
            }
        }

        return LoginStateRole.LoggedOut;
    }
}
