package model;

import java.time.LocalDateTime;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Enums.OrderStatus;
import model.OrderProduct;
import model.Users;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2022-03-01T19:37:08")
@StaticMetamodel(Orders.class)
public class Orders_ { 

    public static volatile ListAttribute<Orders, OrderProduct> basket;
    public static volatile SingularAttribute<Orders, Double> totalAmount;
    public static volatile SingularAttribute<Orders, String> address;
    public static volatile SingularAttribute<Orders, LocalDateTime> submittedTime;
    public static volatile SingularAttribute<Orders, Users> deliveryStaff;
    public static volatile SingularAttribute<Orders, Long> id;
    public static volatile SingularAttribute<Orders, LocalDateTime> deliveredTime;
    public static volatile SingularAttribute<Orders, Users> customer;
    public static volatile SingularAttribute<Orders, OrderStatus> status;
    public static volatile SingularAttribute<Orders, LocalDateTime> assignedTime;

}