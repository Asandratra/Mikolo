package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Reception extends BaseEntity{

    @ManyToOne
    @JoinColumn(name = "id_transaction")
    private Transaction_request transaction;

    @Column
    private Integer quantity;

    @Column
    private Date date;


    public Reception() {
    }

    public Reception(Integer id) {
        setId(id);
    }
}