/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.time.LocalDateTime;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

/**
 *
 * @author erwin
 */
@Entity
public class Receipt implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @OneToOne
    private Order order;
    private double amountPayed;
    private LocalDateTime generateDate;

    public Receipt(Long id, Order order, double amountPayed, LocalDateTime generateDate) {
        this.id = id;
        this.order = order;
        this.amountPayed = amountPayed;
        this.generateDate = generateDate;
    }

    public Receipt() {
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public double getAmountPayed() {
        return amountPayed;
    }

    public void setAmountPayed(double amountPayed) {
        this.amountPayed = amountPayed;
    }

    public LocalDateTime getGenerateDate() {
        return generateDate;
    }

    public void setGenerateDate(LocalDateTime generateDate) {
        this.generateDate = generateDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Receipt)) {
            return false;
        }
        Receipt other = (Receipt) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Receipt[ id=" + id + " ]";
    }
    
}
