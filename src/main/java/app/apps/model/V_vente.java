package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class V_vente extends BaseEntity{

    @ManyToOne
    @JoinColumn(name="id_shop")
    private Shop shop;

    @Column
    private Date date;

    @ManyToOne
    @JoinColumn(name="id_laptop")
    private Laptop laptop;

    @Column
    private Integer nombre;

    @Column
    private Double vente;

    @Column
    private Double achat;

    @Column
    private Double benefice_brute;

    @Column
    private Double perte;

    @Transient
    private Double commission;
    
    public V_vente() {
    }
    public V_vente(Integer id) {
        setId(id);
    }
}