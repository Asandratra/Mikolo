package app.apps.service;

import app.apps.dao.HibernateDAO;
import app.apps.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.ArrayList;

@Service
public class ProfileService {
    @Autowired
    HibernateDAO hibernateDAO;

    public Profile login(Profile user)throws Exception{
        Profile check = null;
        List<Profile> ver = null;
        try{
            ver = hibernateDAO.findWhere(user,0,1,"id",true,true,false);
            if(ver.size()<=0){
                check = new Profile();
                check.setPassword(user.getPassword());
                check.setEmail(user.getUsername());
                ver = hibernateDAO.findWhere(check,0,1,"id",true,true,false);
            }
            if(ver.size()<=0){
                return null;
            }
            check = ver.get(0);
        }
        catch(Exception ex){
            throw ex;
        }
        return check;
    }
}
