package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Enums.StaffRole;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2022-02-23T12:09:53")
@StaticMetamodel(Staff.class)
public class Staff_ { 

    public static volatile SingularAttribute<Staff, String> icNumber;
    public static volatile SingularAttribute<Staff, String> password;
    public static volatile SingularAttribute<Staff, Boolean> isMale;
    public static volatile SingularAttribute<Staff, StaffRole> role;
    public static volatile SingularAttribute<Staff, String> phoneNumber;
    public static volatile SingularAttribute<Staff, String> name;
    public static volatile SingularAttribute<Staff, String> id;

}