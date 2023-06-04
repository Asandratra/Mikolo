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

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import java.io.IOException;

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

import java.io.FileOutputStream;
import java.text.DecimalFormat;
 
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
public class MyController {

    @Autowired
    HibernateDAO hibernateDAO;
    
    @Autowired
    SampleService sampleService;

    @Autowired
    StockService stockService;

    @Autowired
    CommissionService commissionService;
    
    @GetMapping(value = "/")
    public String to_login(HttpServletRequest request, HttpSession session) {
        try {
            if(session.getAttribute("user")!=null) session.removeAttribute("user");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "login";
    }

    @GetMapping(value = "/register")
    public String to_register(HttpServletRequest request, HttpSession session) {
        try {
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "register";
    }

    @GetMapping(value = "/main")
    public String to_main(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Main");
            session.setAttribute("content","content");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }

    @GetMapping(value = "/table")
    public String to_table(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Table");
            session.setAttribute("content","table");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/table/brand/{page}")
    public String to_table_brand(@PathVariable Integer page,HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Brands");
            session.setAttribute("content","table_brand");
            request.setAttribute("current_page",page);
            int countAll = hibernateDAO.getAll1(new Brand()).size();
            int count = hibernateDAO.findWhere(new Brand(),0,countAll,"id",true,true,true).size();
            int npage = (int) Math.ceil(((double) count)/10.0);
            request.setAttribute("count",count);
            request.setAttribute("brands",hibernateDAO.findWhere(new Brand(),10*(page-1),10,"id",true,true,true));
            request.setAttribute("npage",npage);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/table/processor/{page}")
    public String to_table_processor(@PathVariable Integer page,HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Processors");
            session.setAttribute("content","table_processor");
            request.setAttribute("current_page",page);
            int countAll = hibernateDAO.getAll1(new Processor()).size();
            int count = hibernateDAO.findWhere(new Processor(),0,countAll,"id",true,true,true).size();
            int npage = (int) Math.ceil(((double) count)/10.0);
            request.setAttribute("count",count);
            request.setAttribute("processors",hibernateDAO.findWhere(new Processor(),10*(page-1),10,"id",true,true,true));
            request.setAttribute("npage",npage);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/table/ram_option/{page}")
    public String to_table_ram_option(@PathVariable Integer page,HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Ram options");
            session.setAttribute("content","table_ram_option");
            request.setAttribute("current_page",page);
            int countAll = hibernateDAO.getAll1(new Ram_option()).size();
            int count = hibernateDAO.findWhere(new Ram_option(),0,countAll,"id",true,true,true).size();
            int npage = (int) Math.ceil(((double) count)/10.0);
            request.setAttribute("count",count);
            request.setAttribute("ram_options",hibernateDAO.findWhere(new Ram_option(),10*(page-1),10,"id",true,true,true));
            request.setAttribute("npage",npage);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/table/storage_option/{page}")
    public String to_table_storage_option(@PathVariable Integer page,HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","SSD options");
            session.setAttribute("content","table_storage_option");
            request.setAttribute("current_page",page);
            int countAll = hibernateDAO.getAll1(new Storage_option()).size();
            int count = hibernateDAO.findWhere(new Storage_option(),0,countAll,"id",true,true,true).size();
            int npage = (int) Math.ceil(((double) count)/10.0);
            request.setAttribute("count",count);
            request.setAttribute("storage_options",hibernateDAO.findWhere(new Storage_option(),10*(page-1),10,"id",true,true,true));
            request.setAttribute("npage",npage);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/table/shop/{page}")
    public String to_table_shop(@PathVariable Integer page,HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Shops");
            session.setAttribute("content","table_shop");
            request.setAttribute("current_page",page);
            Shop_type st = new Shop_type(1);
            Shop pdv = new Shop();
            pdv.setShop_type(st);
            if(session.getAttribute("shopfilter")!=null) pdv = (Shop) session.getAttribute("shopfilter");
            int countAll = hibernateDAO.getAll1(pdv).size();
            int count = hibernateDAO.findWhere(pdv,0,countAll,"id",true,true,true).size();
            int npage = (int) Math.ceil(((double) count)/10.0);
            request.setAttribute("count",count);
            request.setAttribute("shops",hibernateDAO.findWhere(pdv,10*(page-1),10,"id",true,true,true));
            request.setAttribute("npage",npage);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/table/laptop/{page}")
    public String to_table_laptop(@PathVariable Integer page,HttpServletRequest request, HttpSession session) {
        try {
            Laptop filter = new Laptop();
            if(session.getAttribute("laptopfilter")!=null) filter = (Laptop) session.getAttribute("laptopfilter");
            session.setAttribute("title","Laptops");
            session.setAttribute("content","table_laptop");
            request.setAttribute("current_page",page);
            String[] lower = {"price"};
            String[] higher = {"ram","storage","screen_size"};
            int countAll = hibernateDAO.getAll1(filter).size();
            int count = hibernateDAO.findWhere(filter,0,countAll,"id",true,true,true,lower,higher).size();
            int npage = (int) Math.ceil(((double) count)/10.0);
            request.setAttribute("count",count);
            request.setAttribute("laptops",hibernateDAO.findWhere(filter,10*(page-1),10,"id",true,true,true,lower,higher));
            request.setAttribute("brands",hibernateDAO.getAll1(new Brand()));
            request.setAttribute("ram_options",hibernateDAO.getAll1(new Ram_option()));
            request.setAttribute("storage_options",hibernateDAO.getAll1(new Storage_option()));
            request.setAttribute("processors",hibernateDAO.getAll1(new Processor()));
            request.setAttribute("npage",npage);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/table/profile/{page}")
    public String to_table_profile(@PathVariable Integer page,HttpServletRequest request, HttpSession session) {
        try {
            Profile filter = new Profile();
            if(session.getAttribute("profilefilter")!=null) filter = (Profile) session.getAttribute("profilefilter");
            session.setAttribute("title","Profiles");
            session.setAttribute("content","table_profile");
            request.setAttribute("current_page",page);
            int countAll = hibernateDAO.getAll1(filter).size();
            int count = hibernateDAO.findWhere(filter,0,countAll,"id",true,true,true).size();
            int npage = (int) Math.ceil(((double) count)/10.0);
            request.setAttribute("count",count);
            request.setAttribute("profiles",hibernateDAO.findWhere(filter,10*(page-1),10,"id",true,true,true));
            request.setAttribute("shops",hibernateDAO.getAll1(new Shop()));
            request.setAttribute("npage",npage);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/table/sell/{ids}")
    public String to_table_sell(@PathVariable Integer ids,HttpServletRequest request, HttpSession session) {
        try {
            Shop s = null;
            if(ids>0){
                s = hibernateDAO.getById(new Shop(),ids);
            } 
            session.setAttribute("title","Sells");
            session.setAttribute("content","table_vente");
            request.setAttribute("ventes",new ArrayList<V_vente>());
            request.setAttribute("benefices",new ArrayList<V_benefice>());
            request.setAttribute("val",stockService.getDataVenteForGraph(new ArrayList<V_benefice>()));
            request.setAttribute("shop",ids);
            request.setAttribute("shop_entity",s);
            request.setAttribute("message","Please, select the year");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @PostMapping(value = "/search/sell/{ids}")
    public String to_table_sell(@PathVariable Integer ids,@RequestParam(name="year") Integer year,@RequestParam(name="ref") String ref,@RequestParam(name="prix_min") Double prix_min,@RequestParam(name="prix_max") Double prix_max,HttpServletRequest request, HttpSession session) {
        try {
            if(year==0) year=null;
            if(prix_max!=0){
                session.setAttribute("filtreprixmin",prix_min);
                session.setAttribute("filtreprixmax",prix_max);
            }
            if(prix_min==0 && prix_max==0){
                prix_max = null;
            }
            Shop s = null;
            if(ids>0){
                s = hibernateDAO.getById(new Shop(),ids);
            } 
            List<V_vente> ventes = stockService.getVente(ids,null,year,ref,prix_min,prix_max);
            List<V_benefice> benefice = new ArrayList<V_benefice>();
            if(ids<=0){
                benefice = stockService.getBenefice(year);
            }
            session.setAttribute("title","Sells");
            session.setAttribute("content","table_vente");
            request.setAttribute("ventes",ventes);
            request.setAttribute("benefices",benefice);
            request.setAttribute("val",stockService.getDataVenteForGraph((ArrayList<V_benefice>) benefice));
            request.setAttribute("shop",ids);
            request.setAttribute("shop_entity",s);
            session.setAttribute("year",year);
            request.setAttribute("message",null);
            session.setAttribute("filtreref",ref);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }

    @GetMapping(value = "/table/commission/{page}")
    public String to_table_commission(@PathVariable Integer page,HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Commissions");
            session.setAttribute("content","table_commission");
            request.setAttribute("current_page",page);
            int countAll = hibernateDAO.getAll1(new Commission()).size();
            int count = hibernateDAO.findWhere(new Commission(),0,countAll,"id",true,true,true).size();
            int npage = (int) Math.ceil(((double) count)/10.0);
            request.setAttribute("count",count);
            request.setAttribute("commissions",hibernateDAO.findWhere(new Commission(),10*(page-1),10,"id",true,true,true));
            request.setAttribute("npage",npage);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @PostMapping(value = "/update/commission/{ids}")
    public String update_commission(@PathVariable Integer ids,@RequestParam(name="min") Double min,@RequestParam(name="max") Double max,@RequestParam(name="com") Double com,HttpServletRequest request, HttpSession session) {
        try {
            Commission c = hibernateDAO.getById(new Commission(),ids);
            c.setTotal_min(min);
            c.setTotal_max(max);
            c.setPercentage(com);
            hibernateDAO.update(c);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return to_table_commission(1,request,session);
    }
    @GetMapping(value = "/delete/commission/{ids}")
    public String delete_commission(@PathVariable Integer ids,HttpServletRequest request, HttpSession session) {
        try {
            Commission c = hibernateDAO.getById(new Commission(),ids);
            hibernateDAO.delete(c);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return to_table_commission(1,request,session);
    }
    
    @GetMapping(value = "/stats")
    public String to_stats(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Stats");
            session.setAttribute("content","stats");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/planning")
    public String to_planning(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Planning");
            session.setAttribute("content","calendar");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form")
    public String to_form(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding");
            session.setAttribute("content","form");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/brand")
    public String to_form_brand(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding Brand");
            session.setAttribute("content","form_brand");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/processor")
    public String to_form_processor(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding Processor");
            session.setAttribute("content","form_processor");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/ram_option")
    public String to_form_ram_option(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding Ram Option");
            session.setAttribute("content","form_ram_option");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/storage_option")
    public String to_form_storage_option(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding SSD Option");
            session.setAttribute("content","form_storage_option");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/shop")
    public String to_form_shop(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding Shop");
            session.setAttribute("content","form_shop");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/laptop")
    public String to_form_laptop(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding Laptop Model");
            session.setAttribute("content","form_laptop");
            request.setAttribute("brands",hibernateDAO.getAll1(new Brand()));
            request.setAttribute("ram_options",hibernateDAO.getAll1(new Ram_option()));
            request.setAttribute("storage_options",hibernateDAO.getAll1(new Storage_option()));
            request.setAttribute("processors",hibernateDAO.getAll1(new Processor()));
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/profile")
    public String to_form_profile(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding Profile");
            session.setAttribute("content","form_profile");
            request.setAttribute("shops",hibernateDAO.getAll1(new Shop()));
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/reception/{idt}")
    public String to_form_profile(@PathVariable Integer idt,HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Reception");
            session.setAttribute("content","form_reception");
            request.setAttribute("transaction",hibernateDAO.getById(new V_transaction(),idt));
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/form/commission")
    public String to_form_commission(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Adding Commission");
            session.setAttribute("content","form_commission");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/details")
    public String to_details(HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Details");
            session.setAttribute("content","profile");
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/details/profile/{id}")
    public String to_details_profile(@PathVariable Integer id,HttpServletRequest request, HttpSession session) {
        try {
            session.setAttribute("title","Details Profile");
            session.setAttribute("content","profile_profile");
            request.setAttribute("profile",hibernateDAO.getById(new Profile(),id));
            request.setAttribute("shops",hibernateDAO.getAll1(new Shop()));
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }
    
    @GetMapping(value = "/details/laptop/{id}")
    public String to_details_laptop(@PathVariable Integer id,HttpServletRequest request, HttpSession session) {
        try {
            Laptop l = hibernateDAO.getById(new Laptop(),id);
            Profile current_user = (Profile) session.getAttribute("user");
            Shop s = current_user.getShop();
            Stock_change sc = new Stock_change();
            sc.setShop(s);
            sc.setLaptop(l);
            Shop central = hibernateDAO.getById(new Shop(),1);
            V_stock scentral = new V_stock();
            scentral.setShop(central);
            scentral.setLaptop(l);
            if(hibernateDAO.findWhere(scentral,0,1,"date",true,true,false).size()>0) scentral = hibernateDAO.findWhere(scentral,0,1,"date",true,true,false).get(0);
            else{
                scentral.setStock_in(0);
                scentral.setStock_out(0);
                scentral.setValue(0.0);
            }

            V_stock slocal = new V_stock();
            slocal.setShop(s);
            slocal.setLaptop(l);
            if(hibernateDAO.findWhere(slocal,0,1,"date",true,true,false).size()>0) slocal = hibernateDAO.findWhere(slocal,0,1,"date",true,true,false).get(0);
            else{
                slocal.setStock_in(0);
                slocal.setStock_out(0);
                slocal.setValue(0.0);
            }

            int isc=hibernateDAO.getAll1(sc).size();
            request.setAttribute("stock_changes",hibernateDAO.findWhere(sc,0,isc,"date",true,true,false));
            request.setAttribute("local_stock",slocal);
            request.setAttribute("central_stock",scentral);
            request.setAttribute("perte_stock",stockService.getPerte(l));
            session.setAttribute("title","Details Laptop");
            session.setAttribute("content","profile_laptop");
            request.setAttribute("laptop",l);
            request.setAttribute("shops",hibernateDAO.getAll1(new Shop()));
            V_transaction vt = new V_transaction();
            vt.setConfirmed(0);
            vt.setShop_to(current_user.getShop());
            vt.setLaptop(l);
            int maxsize = hibernateDAO.getAll1(vt).size();
            request.setAttribute("transactions",hibernateDAO.findWhere(vt, 0, maxsize, "date", false, true, false));
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "bodyless";
    }

    @GetMapping(value="/confirm/transaction/{id}/{idt}")
    public String to_details_laptop(@PathVariable Integer id,@PathVariable Integer idt,HttpServletRequest request, HttpSession session) {
        try {
            Transaction_request tr = hibernateDAO.getById(new Transaction_request(),idt);
            tr.setConfirmed(1);
            hibernateDAO.update(tr);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return to_details_laptop(id,request,session);
    }

    @GetMapping("/pdf/sell/{ids}")
    public void PDFVente(@PathVariable(name = "ids") Integer id_shop, @RequestParam(name = "year") Integer year, ServletOutputStream out, HttpServletResponse response) throws IOException {
        Document document = null;
        PdfWriter writer = null;
        try {
            List<V_vente> ventes = stockService.getVente(id_shop,null,year,"",null,null);
            stockService.generateSellPDF(id_shop,year,ventes, out);
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            out.println(e.getMessage());
        } finally {
            if (document != null) {
                document.close();
            }
        }
    }
    

    @GetMapping("/pdf/benefice")
    public void PDFBenefice(@RequestParam(name = "year") Integer year, ServletOutputStream out, HttpServletResponse response) throws IOException {
        Document document = null;
        PdfWriter writer = null;
        try { 
            stockService.generateBeneficePDF(year, stockService.getBenefice(year), out);
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            out.println(e.getMessage());
        } finally {
            if (document != null) {
                document.close();
            }
        }
    }
}
