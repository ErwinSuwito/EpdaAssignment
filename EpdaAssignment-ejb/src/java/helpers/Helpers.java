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
            if (session.getAttribute("staffLogin") == null
                    && session.getAttribute("customerLogin") == null) {
                return LoginStateRole.LoggedOut;
            }

            if (session.getAttribute("staffLogin") != null) {
                Staff staff = (Staff) session.getAttribute("staffLogin");
                if (staff.getRole().equals(StaffRole.DeliveryStaff)) {
                    return LoginStateRole.DeliveryStaff;
                } else {
                    return LoginStateRole.ManagingStaff;
                }
            }

            if (session.getAttribute("customerLogin") != null) {
                return LoginStateRole.Customer;
            }
        }

        return LoginStateRole.LoggedOut;
    }
}
