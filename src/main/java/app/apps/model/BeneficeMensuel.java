package app.apps.model;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class BeneficeMensuel{

    private String month;
    private Double v;
    
    public BeneficeMensuel() {
    }
}