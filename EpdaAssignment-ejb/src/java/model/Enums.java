/*
 */
package model;

/**
 *
 * @author Erwin
 */
public class Enums {
    public enum StaffRole {
        DeliveryStaff, ManagingStaff
    }
    
    public enum FeedbackStatus {
        Open, Closed
    }
    
    public enum OrderStatus {
        Pending, Assigned, Delivering, Delivered, Cancelled
    }
}
