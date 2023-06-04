package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Commission extends BaseEntity{

    @Column
    private Double total_min;
    
    @Column
    private Double total_max;

    @Column
    private Double percentage;

    public Commission() {
    }

    public Commission(Integer id) {
        setId(id);
    }
}