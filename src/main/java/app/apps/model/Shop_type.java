package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Shop_type extends BaseEntity{

    @Column
    private String name;
    
    public Shop_type() {
    }

    public Shop_type(Integer id) {
        setId(id);
    }
}