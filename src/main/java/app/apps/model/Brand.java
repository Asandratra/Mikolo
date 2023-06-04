package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Brand extends BaseEntity{

    @Column
    private String name;

    public Brand() {
    }

    public Brand(Integer id) {
        setId(id);
    }
}