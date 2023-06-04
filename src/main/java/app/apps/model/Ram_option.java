package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Ram_option extends BaseEntity{

    @Column
    private String name;

    @Column
    private Integer capacity;

    public Ram_option() {
    }

    public Ram_option(Integer id) {
        setId(id);
    }
}