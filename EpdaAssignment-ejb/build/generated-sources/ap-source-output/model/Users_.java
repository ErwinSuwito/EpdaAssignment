package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Enums.LoginStateRole;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2022-02-27T11:37:39")
@StaticMetamodel(Users.class)
public class Users_ { 

    public static volatile SingularAttribute<Users, String> icNumber;
    public static volatile SingularAttribute<Users, String> password;
    public static volatile SingularAttribute<Users, Boolean> isMale;
    public static volatile SingularAttribute<Users, String> phoneNumber;
    public static volatile SingularAttribute<Users, LoginStateRole> role;
    public static volatile SingularAttribute<Users, String> name;
    public static volatile SingularAttribute<Users, Long> id;
    public static volatile SingularAttribute<Users, String> email;

}