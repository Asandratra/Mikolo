package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Storage_option extends BaseEntity{

    @Column
    private String name;

    @Column
    private Integer capacity;

    public Storage_option() {
    }

    public Storage_option(Integer id) {
        setId(id);
    }
}