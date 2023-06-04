package app.apps.controller;

import app.apps.model.*;
import app.apps.model.reponse.*;
import app.apps.service.*;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import app.apps.dao.HibernateDAO;

@RestController
public class MyRestController {

    @Autowired
    HibernateDAO hibernateDAO;

    @Autowired
    ProfileService profileService;
    
    @RequestMapping(value="/authentification", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> login(@RequestBody Profile user,HttpSession session)throws Exception{
        Profile check = null;
        try{
            check = profileService.login(user);
            if(check==null){
                throw new Exception("Authentification failed. Please try again");
            }
            else{
                System.out.println(check);
                session.setAttribute("user",check);
            }
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Authentification OK");
        return new ResponseEntity("Authentification OK",HttpStatus.OK);
    }

    @RequestMapping(value="/registration", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> register(@RequestBody Profile user)throws Exception{
        try{
            hibernateDAO.create(user);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Registration OK");
        return new ResponseEntity("Registration OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/brand", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> register(@RequestBody Brand brand)throws Exception{
        try{
            hibernateDAO.create(brand);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/processor", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> register(@RequestBody Processor proc)throws Exception{
        try{
            hibernateDAO.create(proc);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/ram_option", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> register(@RequestBody Ram_option o)throws Exception{
        try{
            hibernateDAO.create(o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/storage_option", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> register(@RequestBody Storage_option o)throws Exception{
        try{
            hibernateDAO.create(o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/shop", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> register(@RequestBody Shop o)throws Exception{
        try{
            hibernateDAO.create(o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/laptop", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> register(@RequestBody Laptop o)throws Exception{
        try{
            hibernateDAO.create(o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/profile", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> save(@RequestBody Profile o)throws Exception{
        try{
            hibernateDAO.create(o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/stock", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> save(@RequestBody Stock_change o)throws Exception{
        try{
            hibernateDAO.create(o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/transaction", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> save(@RequestBody Transaction_request o)throws Exception{
        try{
            Stock_change sc = new Stock_change();
            sc.setShop(o.getShop_from());
            sc.setLaptop(o.getLaptop());
            sc.setDate(o.getDate());
            sc.setStock_in(0);
            sc.setStock_out(o.getN_laptop());
            sc.setValue((Double) 0.0);
            hibernateDAO.create(o);
            hibernateDAO.create(sc);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/reception", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> save(@RequestBody Reception o)throws Exception{
        try{
            Transaction_request tr = hibernateDAO.getById(new Transaction_request(),o.getTransaction().getId());
            Stock_change sc = new Stock_change();
            sc.setShop(tr.getShop_to());
            sc.setLaptop(tr.getLaptop());
            sc.setDate(o.getDate());
            sc.setStock_in(o.getQuantity());
            sc.setStock_out(0);
            sc.setValue((Double) 0.0);
            hibernateDAO.create(o);
            hibernateDAO.create(sc);
            V_transaction vt = hibernateDAO.getById(new V_transaction(),o.getTransaction().getId());
            if(vt.getN_laptop()<=0){
                tr.setConfirmed(1);
                hibernateDAO.update(tr);
            }
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/save/commission", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> save(@RequestBody Commission o)throws Exception{
        try{
            hibernateDAO.create(o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/update/profile", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> update(@RequestBody Profile o)throws Exception{
        try{
            System.out.println(o.getId());
            System.out.println(o.getShop().getLocalisation());
            hibernateDAO.update(o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/search/laptop", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> search(@RequestBody Laptop o,HttpSession session)throws Exception{
        try{
            if(o.getBrand().getId()==null) o.setBrand(null);
            if(o.getRam().getId()==null) o.setRam(null);
            if(o.getStorage().getId()==null) o.setStorage(null);
            if(o.getProcessor().getId()==null) o.setProcessor(null);
            session.setAttribute("laptopfilter",o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/search/profile", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> search(@RequestBody Profile o,HttpSession session)throws Exception{
        try{
            if(o.getShop().getId()==null) o.setShop(null);
            session.setAttribute("profilefilter",o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }

    @RequestMapping(value="/search/shop", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> search(@RequestBody Shop o,HttpSession session)throws Exception{
        try{
            session.setAttribute("shopfilter",o);
        }
        catch(Exception ex){
            System.out.println("---------------------------");
            ex.printStackTrace();
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("Save OK");
        return new ResponseEntity("Save OK",HttpStatus.OK);
    }
}
