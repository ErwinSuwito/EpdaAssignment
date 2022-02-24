/*
 */
package model;

/**
 *
 * @author Erwin
 */
public class Enums {
    public enum LoginStateRole {
        LoggedOut, Customer, DeliveryStaff, ManagingStaff
    }
    
    public enum StaffRole {
        DeliveryStaff, ManagingStaff
    }
    
    public enum FeedbackStatus {
        Open, Closed
    }
    
    public enum OrderStatus {
        Pending, Assigned, Delivering, Delivered
    }
}
