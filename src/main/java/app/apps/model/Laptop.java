package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Laptop extends BaseEntity{

    @ManyToOne
    @JoinColumn(name="id_brand")
    private Brand brand;

    @Column
    private String reference;

    @ManyToOne
    @JoinColumn(name="id_ram")
    private Ram_option ram;

    @ManyToOne
    @JoinColumn(name="id_storage")
    private Storage_option storage;

    @ManyToOne
    @JoinColumn(name = "id_processor")
    private Processor processor;

    @Column
    private Integer screen_size;

    @Column
    private String name;

    @Column
    private Double price;

    public Laptop() {
    }

    public Laptop(Integer id) {
        setId(id);
    }
}