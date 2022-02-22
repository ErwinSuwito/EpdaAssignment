/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package helpers;

import model.Enums;
import model.Enums.OrderStatus;

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
            
            case "Cancelled":
                return OrderStatus.Cancelled;
        }
        
        return null;
    }
}
