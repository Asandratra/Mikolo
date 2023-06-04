package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class V_vente_magasin extends BaseEntity{

    @ManyToOne
    @JoinColumn(name = "id_shop")
    private Shop shop;

    @ManyToOne
    @JoinColumn(name = "id_laptop")
    private Laptop laptop;

    @Column
    private Date date;

    @Column
    private Integer n;

    public V_vente_magasin() {
    }

    public V_vente_magasin(Integer id) {
        setId(id);
    }
}