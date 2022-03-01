package model;

import java.time.LocalDateTime;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Orders;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2022-03-01T09:53:17")
@StaticMetamodel(Feedback.class)
public class Feedback_ { 

    public static volatile SingularAttribute<Feedback, Integer> starCount;
    public static volatile SingularAttribute<Feedback, Boolean> isDeleted;
    public static volatile SingularAttribute<Feedback, LocalDateTime> submittedOn;
    public static volatile SingularAttribute<Feedback, String> comment;
    public static volatile SingularAttribute<Feedback, Long> id;
    public static volatile SingularAttribute<Feedback, Orders> order;

}