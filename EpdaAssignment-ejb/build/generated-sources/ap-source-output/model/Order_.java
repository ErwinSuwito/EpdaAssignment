package model;

import java.time.LocalDateTime;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.AppUser;
import model.Enums.OrderStatus;
import model.OrderProduct;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2022-02-19T19:38:39")
@StaticMetamodel(Order.class)
public class Order_ { 

    public static volatile ListAttribute<Order, OrderProduct> basket;
    public static volatile SingularAttribute<Order, Double> totalAmount;
    public static volatile SingularAttribute<Order, String> address;
    public static volatile SingularAttribute<Order, LocalDateTime> deliveryTime;
    public static volatile SingularAttribute<Order, AppUser> deliveryStaff;
    public static volatile SingularAttribute<Order, LocalDateTime> actualDeliveryTime;
    public static volatile SingularAttribute<Order, Long> id;
    public static volatile SingularAttribute<Order, LocalDateTime> deliveredTime;
    public static volatile SingularAttribute<Order, AppUser> customer;
    public static volatile SingularAttribute<Order, OrderStatus> status;

}