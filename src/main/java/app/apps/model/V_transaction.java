package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class V_transaction extends BaseEntity{

    @ManyToOne
    @JoinColumn(name = "id_shop_from")
    private Shop shop_from;

    @ManyToOne
    @JoinColumn(name = "id_shop_to")
    private Shop shop_to;

    @ManyToOne
    @JoinColumn(name = "id_laptop")
    private Laptop laptop;

    @Column
    private Date date;

    @Column
    private Integer n_laptop;

    @Column
    private Integer confirmed;


    public V_transaction() {
    }

    public V_transaction(Integer id) {
        setId(id);
    }
}