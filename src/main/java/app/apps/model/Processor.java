package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Processor extends BaseEntity{

    @Column
    private String name;

    @Column
    private Double frequency;

    @Column
    private Integer n_core;

    public Processor() {
    }

    public Processor(Integer id) {
        setId(id);
    }
}