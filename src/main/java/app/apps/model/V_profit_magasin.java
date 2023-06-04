package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class V_profit_magasin extends BaseEntity{

    @ManyToOne
    @JoinColumn(name = "id_shop")
    private Shop shop;

    @Column
    private Date date;

    @Column
    private Double n;

    @Transient
    private Double com;

    public V_profit_magasin() {
    }

    public V_profit_magasin(Integer id) {
        setId(id);
    }
}