package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Order;
import model.Product;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2022-02-19T19:38:39")
@StaticMetamodel(OrderProduct.class)
public class OrderProduct_ { 

    public static volatile SingularAttribute<OrderProduct, Product> product;
    public static volatile SingularAttribute<OrderProduct, Integer> quantityPurchased;
    public static volatile SingularAttribute<OrderProduct, Long> id;
    public static volatile SingularAttribute<OrderProduct, Order> order;

}