package model;

import java.time.LocalDateTime;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Orders;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2022-02-28T19:37:12")
@StaticMetamodel(Receipt.class)
public class Receipt_ { 

    public static volatile SingularAttribute<Receipt, LocalDateTime> generateDate;
    public static volatile SingularAttribute<Receipt, Double> amountPayed;
    public static volatile SingularAttribute<Receipt, Long> id;
    public static volatile SingularAttribute<Receipt, Orders> order;

}