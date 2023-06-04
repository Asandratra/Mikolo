package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Shop extends BaseEntity{

    @Column
    private String localisation;

    @ManyToOne
    @JoinColumn(name = "id_shop_type")
    private Shop_type shop_type;
    
    public Shop() {
    }

    public Shop(Integer id) {
        setId(id);
    }
}