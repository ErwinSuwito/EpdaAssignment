/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package helpers;

import java.util.Comparator;
import model.Orders;

/**
 *
 * @author erwin
 * javatpoint.com/java-list-sort-method
 */
public class SortOrdersById implements Comparator<Orders> {

    @Override
    public int compare(Orders o1, Orders o2) {
        return o1.id.intValue() - o2.id.intValue();
    }
    
}
