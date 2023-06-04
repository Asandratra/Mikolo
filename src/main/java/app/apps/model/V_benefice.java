package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class V_benefice extends BaseEntity{

    @Column
    private Integer id_month;

    @Column
    private String month;

    @Column
    private Integer year;

    @Column
    private Double total_vente;

    @Column
    private Double total_achat;

    @Column
    private Double total_benefice_brute;

    @Column
    private Double total_perte;

    @Transient
    private Double total_commission;
    
    public V_benefice() {
    }
    public V_benefice(Integer id) {
        setId(id);
    }
}