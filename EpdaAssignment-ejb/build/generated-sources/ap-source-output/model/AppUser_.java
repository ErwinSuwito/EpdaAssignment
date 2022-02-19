package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Enums.Role;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2022-02-19T19:38:39")
@StaticMetamodel(AppUser.class)
public class AppUser_ { 

    public static volatile SingularAttribute<AppUser, String> password;
    public static volatile SingularAttribute<AppUser, Role> role;
    public static volatile SingularAttribute<AppUser, Long> id;
    public static volatile SingularAttribute<AppUser, String> userName;
    public static volatile SingularAttribute<AppUser, String> email;

}