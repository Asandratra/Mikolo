package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class V_stock extends BaseEntity{

    @ManyToOne
    @JoinColumn(name = "id_shop")
    private Shop shop;

    @ManyToOne
    @JoinColumn(name = "id_laptop")
    private Laptop laptop;

    @Column
    private Date date;

    @Column
    private Integer stock_in;

    @Column
    private Integer stock_out;

    @Column
    private Double value;


    public V_stock() {
    }

    public V_stock(Integer id) {
        setId(id);
    }
}