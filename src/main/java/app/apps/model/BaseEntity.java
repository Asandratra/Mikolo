package app.apps.model;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@MappedSuperclass
public class BaseEntity {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Integer id;

    public BaseEntity(){}

    public BaseEntity(Integer id) {
        setId(id);
    }
}