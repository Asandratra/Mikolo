package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Entity
@Getter
@Setter
public class Profile extends BaseEntity{

    @Column
    private String username;

    @Column
    private String email;

    @Column
    private String password;

    @ManyToOne
    @JoinColumn(name = "id_shop")
    private Shop shop;

    public Profile() {
    }

    public Profile(Integer id) {
        setId(id);
    }
}