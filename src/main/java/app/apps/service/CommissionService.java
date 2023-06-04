package app.apps.service;

import app.apps.dao.HibernateDAO;
import app.apps.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.hibernate.*;
import org.hibernate.criterion.*;
import org.hibernate.query.Query;

import java.util.List;
import java.util.ArrayList;
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

import javax.servlet.ServletOutputStream;


@Service
public class CommissionService {
    @Autowired
    HibernateDAO hibernateDAO;

    @Autowired
    StockService stockService;

    public ArrayList<V_profit_magasin> getAllProfitMensuel(Integer m,Integer y)throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<V_profit_magasin> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(V_profit_magasin.class);
            condition = "EXTRACT(MONTH FROM date)<="+m.toString()+" and EXTRACT(YEAR FROM date)="+y.toString();
            cr.add(Restrictions.sqlRestriction(condition));
            rep = cr.list();
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if(session!=null) session.close();
        }
        return (ArrayList<V_profit_magasin>) rep;
    }

    public V_profit_magasin calcul_commission(V_profit_magasin s)throws Exception{
        V_profit_magasin rep = null;
        try{
            List<Commission> commission = hibernateDAO.getAll1(new Commission());
            Double saven = s.getN();
            Double calcul = 0.0;
            Double resultat = 0.0;
            for(Commission c : commission){
                if(saven>=c.getTotal_min()){
                    calcul = saven-c.getTotal_min();
                    if(c.getTotal_min()!=0.0){
                        calcul = calcul + 1;
                    }
                }
                double diff = c.getTotal_max()-c.getTotal_min();
                if(c.getTotal_min()!=0.0){
                        diff = diff + 1;
                    }
                if(calcul>diff){
                    calcul = c.getTotal_max();
                }
                resultat = resultat + (calcul*(c.getPercentage()/100));
                calcul = 0.0;
            }
            rep = s;
            rep.setCom(resultat);
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        return rep;
    }
    public ArrayList<V_profit_magasin> calcul_all_commission(List<V_profit_magasin> s)throws Exception{
        ArrayList<V_profit_magasin> rep = new ArrayList<V_profit_magasin>();
        try{
            for(V_profit_magasin v : s){
                rep.add(calcul_commission(v));
            }
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        return rep;
    }
    public void setCommission(V_vente v)throws Exception{
        try{
            List<Commission> commission = hibernateDAO.getAll1(new Commission());
            Double saven = v.getVente();
            Double calcul = 0.0;
            Double resultat = 0.0;
            Double done = 0.0;
            for(Commission c : commission){
                calcul = saven; //57,375,000
                if(calcul>c.getTotal_max()){// > 300,000,000 non
                    calcul = c.getTotal_max() - done;
                }
                else if(calcul<c.getTotal_min()){//< 5,000,000 non
                    calcul = 0.0;
                }
                else{
                    calcul = calcul - done;
                }
                resultat = resultat + (calcul*(c.getPercentage()/100));
                done = done + calcul;
                calcul = 0.0;
            }
            v.setCommission(resultat);
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
    }
    public void setAllCommissionVente(List<V_vente> lv)throws Exception{
        for(V_vente v : lv){
            setCommission(v);
        }
    }
    public void setCommission(V_benefice b)throws Exception{
        List<V_vente> lv = stockService.getVente(null,b.getId_month(),b.getYear(),null,null,null);
        setAllCommissionVente(lv);
        Double rep = 0.0;
        for(V_vente v:lv){
            rep = rep + v.getCommission();
        }
        b.setTotal_commission(rep);
    }
    public void setAllCommissionBenefice(List<V_benefice> lb)throws Exception{
        for(V_benefice b : lb){
            setCommission(b);
        }
    }
}

/*
* 57,375,000 = 2,000,000 + 5,000,000 + 50,375,000
* 2,000,000 * 3% = 60,000
* 5,000,000 * 8% = 400,000
* 50,375,000 * 15% = 7,556,250
* TOTAL : 8,016,250
*/