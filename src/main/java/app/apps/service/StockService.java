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
import java.text.SimpleDateFormat;
 
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
public class StockService {
    @Autowired
    HibernateDAO hibernateDAO;

    @Autowired
    CommissionService commissionService;

    private final String[] mois = {"January","February","March","April","May","June","July","August","September","October","November","December"};

    public V_transaction getPerte(Laptop l)throws Exception{
        V_transaction rep = null;
        V_transaction perte = null;
        List<V_transaction> ver = null;
        try{
            perte = new V_transaction();
            perte.setLaptop(l);
            perte.setConfirmed(1);
            int p_size = hibernateDAO.getAll1(perte).size();
            ver = hibernateDAO.findWhere(perte,0,p_size,"id",true,true,false);
            int nombre = 0;
            for(V_transaction v: ver){
                nombre = nombre + v.getN_laptop();
            }
            rep = new V_transaction();
            rep.setLaptop(l);
            rep.setN_laptop(nombre);
        }
        catch(Exception ex){
            throw ex;
        }
        return rep;
    }
    public ArrayList<Stock_change> getVenteByStock(Integer idshop)throws Exception{
        Stock_change filter = new Stock_change();
        String[] higher = {"stock_out","value"};
        filter.setStock_out(1);
        filter.setValue(1.0);
        if(idshop>0) {
            Shop s = hibernateDAO.getById(new Shop(),idshop);
            filter.setShop(s);
        }
        int max = hibernateDAO.getAll1(new Stock_change()).size();
        return (ArrayList<Stock_change>) hibernateDAO.findWhere(filter, 0, max, "date", true, true, true, null, higher);
    }
    public ArrayList<Stock_change> getVenteByStock(Integer idshop,String ref,Double price_min,Double price_max)throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<Stock_change> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(Stock_change.class);
            condition = "stock_out>0 and value>0 and id_laptop in (SELECT id from laptop WHERE reference like '%"+ref+"%') and value>="+price_min.toString()+" and value<="+price_max.toString();
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
        return (ArrayList<Stock_change>) rep;
    }
    public ArrayList<Stock_change> getVenteByStock(Integer idshop,Integer month,Integer year,String ref,Double price_min,Double price_max)throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<Stock_change> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(Stock_change.class);
            condition = "stock_out>0 and value>0 and id_laptop in (SELECT id from laptop WHERE reference like '%"+ref+"%') and value>="+price_min.toString()+" and value<="+price_max.toString();
            if(month!=null){
                condition = condition+" and EXTRACT(MONTH FROM date)="+month.toString();
            }
            if(year!=null){
                condition = condition+" and EXTRACT(YEAR FROM date)="+year.toString();
            }
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
        return (ArrayList<Stock_change>) rep;
    }

    public List<Stock_change> getAchatMensuel(Integer month, Integer year) throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<Stock_change> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(Stock_change.class);
            condition = "stock_in>0 and value>0 and EXTRACT(MONTH FROM date)<="+month.toString()+" and EXTRACT(YEAR FROM date)="+year.toString();
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
        return rep;
    }

    public List<Stock_change> getVenteMensuel(Integer month, Integer year)throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<Stock_change> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(Stock_change.class);
            condition = "stock_out>0 and value>0 and EXTRACT(MONTH FROM date)="+month.toString()+" and EXTRACT(YEAR FROM date)="+year.toString();
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
        return rep;
    }

    public List<Stock_change> getVenteMensuel(Integer idshop,Integer month,Integer year)throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<Stock_change> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(Stock_change.class);
            condition = "stock_out>0 and value>0 and EXTRACT(MONTH FROM date)="+month.toString()+" and id_shop="+idshop.toString()+" and EXTRACT(YEAR FROM date)="+year.toString();
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
        return rep;
    }

    public List<V_transaction> getPerteMensuel(Integer month,Integer year)throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<V_transaction> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(V_transaction.class);
            condition = "n_laptop>0 and confirmed=1 and EXTRACT(MONTH FROM date)<="+month.toString()+" and EXTRACT(YEAR FROM date)="+year.toString();
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
        return rep;
    }
 
    public Double getBenefice(List<Stock_change> ventes, List<Stock_change> achats, List<V_transaction> pertes, List<V_profit_magasin> comms){
        Double rep = 0.0;
        for(Stock_change v : ventes){
            rep = rep + (v.getStock_out()*v.getValue());
        }
        for(Stock_change a : achats){
            rep = rep - (a.getStock_in()*a.getValue());
        }
        for(V_transaction v : pertes){
            rep = rep - (v.getN_laptop()*v.getLaptop().getPrice());
        }
        for(V_profit_magasin v : comms){
            rep = rep - v.getCom();
        }
        return rep;
    }

    public ArrayList<BeneficeMensuel> getAllBenefice(Integer year)throws Exception{
        BeneficeMensuel bm = null;
        Double ben;
        List ventes;
        List achats;
        List pertes;
        List comms;
        ArrayList<BeneficeMensuel> rep = new ArrayList();
        for(int index = 1;index <=12;index++){
            ventes = getVenteMensuel(0,index,year);
            achats = getAchatMensuel(index,year);
            pertes = getPerteMensuel(index,year);
            comms = commissionService.calcul_all_commission(commissionService.getAllProfitMensuel(index,year));
            ben = getBenefice(ventes,achats,pertes,comms);
            bm = new BeneficeMensuel();
            bm.setMonth(this.mois[index-1]);
            bm.setV(ben);
            rep.add(bm);
        }
        return rep;
    }

    // USE THIS
    public ArrayList<V_vente> getVente(Integer idshop,Integer month,Integer year,String ref,Double price_min,Double price_max)throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<V_vente> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(V_vente.class);
            condition = "nombre>0";
            if(idshop!=null && idshop>0){
                condition = condition+" and id_shop="+idshop.toString();
            }
            if(month!=null){
                condition = condition+" and EXTRACT(MONTH FROM date)="+month.toString();
            }
            if(year!=null){
                condition = condition+" and EXTRACT(YEAR FROM date)="+year.toString();
            }
            if(ref!=null){
                condition = condition+" and id_laptop in (SELECT id from laptop WHERE reference like '%"+ref+"%')";
            }
            if(price_min!=null){
                condition = condition+" and vente>="+price_min.toString();
            }
            if(price_max!=null){
                condition = condition+" and vente<="+price_max.toString();
            }
            cr.add(Restrictions.sqlRestriction(condition));
            rep = cr.list();
            commissionService.setAllCommissionVente(rep);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if(session!=null) session.close();
        }
        return (ArrayList<V_vente>) rep;
    }

    // USE THIS
    public ArrayList<V_benefice> getBenefice(Integer year)throws Exception{
        SessionFactory sessionFactory = null;
        Session session = null;
        Criteria cr = null;
        String condition = null;
        List<V_benefice> rep = null;
        try{
            sessionFactory = hibernateDAO.getSessionFactory();
            session = sessionFactory.openSession();
            cr = session.createCriteria(V_benefice.class);
            condition = "1=1";
            if(year!=null){
                condition = condition+" and year="+year.toString();
            }
            cr.add(Restrictions.sqlRestriction(condition));
            rep = cr.list();
            commissionService.setAllCommissionBenefice(rep);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if(session!=null) session.close();
        }
        return (ArrayList<V_benefice>) rep;
    }

    public Double[] getDataVenteForGraph(ArrayList<V_benefice> ben){
        Double[] rep = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
        for(V_benefice b:ben){
            rep[b.getId_month()-1] = b.getTotal_vente();
        }
        return rep;
    }

    private void insertCell(PdfPTable table, String text, int align, int colspan, Font font){
        //create a new cell with the specified Text and Font
        PdfPCell cell = new PdfPCell(new Phrase(text.trim(), font));
        //set the cell alignment
        cell.setHorizontalAlignment(align);
        //set the cell column span in case you want to merge two or more cells
        cell.setColspan(colspan);
        //in case there is no text and you wan to create an empty row
        if(text.trim().equalsIgnoreCase("")){
            cell.setMinimumHeight(10f);
        }
        //add the call to the table
        table.addCell(cell);    
    }

    public void generateSellPDF(Integer ids,Integer year,List<V_vente> ventes, ServletOutputStream out) throws Exception {
        Document doc = new Document();
        PdfWriter docWriter = null;
        
        DecimalFormat df = new DecimalFormat("#,###.##");
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

        Double vente_mois = 0.0;
        Double achat_mois = 0.0;
        Double benefice_brute_mois = 0.0;
        Double perte_mois = 0.0;
        Double benefice_mois = 0.0;
        Double commission_mois = 0.0;
        Double benefice_end_mois = 0.0;

        Double total_vente_mois = 0.0;
        Double total_achat_mois = 0.0;
        Double total_benefice_brute_mois = 0.0;
        Double total_perte_mois = 0.0;
        Double total_benefice_mois = 0.0;
        Double total_commission_mois = 0.0;
        Double total_benefice_end_mois = 0.0;
        
        try {
            
        //special font sizes
        Font bfBold12 = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD, new BaseColor(0, 0, 0)); 
        Font bfBold12_red = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD, new BaseColor(255, 0, 0)); 
        Font bf12 = new Font(FontFamily.TIMES_ROMAN, 12); 
        
        //file path
        docWriter = PdfWriter.getInstance(doc , out);
            
        //document header attributes
        doc.addAuthor("Mikolo");
        doc.addCreationDate();
        doc.addProducer();
        doc.addCreator("Asandratra");
        doc.addTitle("Stats");
        doc.setPageSize(PageSize.A4.rotate());
        
        //open document
        doc.open();
        
        //create a paragraph
        Shop shop = null;
        if(ids>0){
            shop = hibernateDAO.getById(new Shop(),ids);
        }
        String parag;
        if(shop==null){
            parag = "CENTRAL SHOP : global";
        }
        else{
            parag = shop.getLocalisation()+" :";
        }
        parag = parag+" report for "+year.toString();

        Paragraph paragraph = new Paragraph(parag);
            
            
        //specify column widths
        float[] columnWidths = {2.5f, 3f, 1.5f, 3f, 3f, 3f, 3f, 3f, 3f, 3f, 3f};
        //create PDF table with the given widths
        PdfPTable table = new PdfPTable(columnWidths);
        // set table width a percentage of the page width
        table.setWidthPercentage(100f);
        
        //insert column headings
        insertCell(table, "SHOP", Element.ALIGN_LEFT, 1, bfBold12);
        insertCell(table, "DATE", Element.ALIGN_LEFT, 1, bfBold12);
        insertCell(table, "REF", Element.ALIGN_LEFT, 1, bfBold12);
        insertCell(table, "NOMBRE", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "VENTES", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "ACHATS", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "BEN.BRUTE", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "PERTES", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "BENEFICE", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "COMM.", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "FINALE", Element.ALIGN_RIGHT, 1, bfBold12);
        table.setHeaderRows(1);
        
        //insert an empty row
        for(int i=0;i<mois.length;i++){
            vente_mois = 0.0;
            achat_mois = 0.0;
            benefice_brute_mois = 0.0;
            perte_mois = 0.0;
            benefice_mois = 0.0;
            commission_mois = 0.0;
            benefice_end_mois = 0.0;

            insertCell(table, "", Element.ALIGN_LEFT, 11, bfBold12);

            //create section heading by cell merging
            insertCell(table, "---"+mois[i]+"---", Element.ALIGN_CENTER, 11, bfBold12);
                
            //just some random data to fill 
            for(V_vente sc : ventes){
                if(sc.getDate().getMonth()==i){
                    insertCell(table, sc.getShop().getLocalisation(), Element.ALIGN_LEFT, 1, bf12);
                    insertCell(table, sdf.format(sc.getDate()), Element.ALIGN_LEFT, 1, bf12);
                    insertCell(table, sc.getLaptop().getReference(), Element.ALIGN_LEFT, 1, bf12);
                    insertCell(table, sc.getNombre().toString(), Element.ALIGN_RIGHT, 1, bf12);
                    insertCell(table, df.format(sc.getVente()), Element.ALIGN_RIGHT, 1, bf12);
                    insertCell(table, df.format(sc.getAchat()), Element.ALIGN_RIGHT, 1, bf12);
                    insertCell(table, df.format(sc.getBenefice_brute()), Element.ALIGN_RIGHT, 1, bf12);
                    insertCell(table, df.format(-1*sc.getPerte()), Element.ALIGN_RIGHT, 1, bfBold12_red);
                    insertCell(table, df.format(sc.getBenefice_brute()-sc.getPerte()), Element.ALIGN_RIGHT, 1, bf12);
                    insertCell(table, df.format(sc.getCommission()), Element.ALIGN_RIGHT, 1, bf12);
                    insertCell(table, df.format(sc.getBenefice_brute()-sc.getPerte()-sc.getCommission()), Element.ALIGN_RIGHT, 1, bf12);

                    vente_mois = vente_mois + sc.getVente();
                    achat_mois = achat_mois + sc.getAchat();
                    benefice_brute_mois = benefice_brute_mois + sc.getBenefice_brute();
                    perte_mois = perte_mois - sc.getPerte();
                    benefice_mois = benefice_mois + (sc.getBenefice_brute()-sc.getPerte());
                    commission_mois = commission_mois + sc.getCommission();
                    benefice_end_mois = benefice_end_mois + (sc.getBenefice_brute()-sc.getPerte()-sc.getCommission());
                }
            }
            //merge the cells to create a footer for that section
            insertCell(table, "Total mensuel", Element.ALIGN_RIGHT, 4, bfBold12);
            insertCell(table, df.format(vente_mois), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(achat_mois), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(benefice_brute_mois), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(perte_mois), Element.ALIGN_RIGHT, 1, bfBold12_red);
            insertCell(table, df.format(benefice_mois), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(commission_mois), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(benefice_end_mois), Element.ALIGN_RIGHT, 1, bf12);

            total_vente_mois = total_vente_mois + vente_mois;
            total_achat_mois = total_achat_mois + achat_mois;
            total_benefice_brute_mois = total_benefice_brute_mois + benefice_brute_mois;
            total_perte_mois = total_perte_mois + perte_mois;
            total_benefice_mois = total_benefice_mois + benefice_mois;
            total_commission_mois = total_commission_mois + commission_mois;
            total_benefice_end_mois = total_benefice_end_mois + benefice_end_mois;
        }
        insertCell(table, "", Element.ALIGN_LEFT, 11, bfBold12);

        insertCell(table, "TOTAL", Element.ALIGN_RIGHT, 4, bfBold12);
        insertCell(table, df.format(total_vente_mois), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_achat_mois), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_benefice_brute_mois), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_perte_mois), Element.ALIGN_RIGHT, 1, bfBold12_red);
        insertCell(table, df.format(total_benefice_mois), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_commission_mois), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_benefice_end_mois), Element.ALIGN_RIGHT, 1, bf12);

        //add the PDF table to the paragraph 
        paragraph.add(table);
        // add the paragraph to the document
        doc.add(paragraph);
        
        }
        catch (DocumentException dex){
            dex.printStackTrace();
            throw dex;
        }
        catch (Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if (doc != null){
                //close the document
                doc.close();
            }
            if (docWriter != null){
                //close the writer
                docWriter.close();
            }
        }
    }

    public void generateBeneficePDF(Integer year, List<V_benefice> ben, ServletOutputStream out) throws Exception {
        Document doc = new Document();
        PdfWriter docWriter = null;
        
        DecimalFormat df = new DecimalFormat("#,###.##");
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

        Double total_vente_annee = 0.0;
        Double total_achat_annee = 0.0;
        Double total_benefice_brute_annee = 0.0;
        Double total_perte_annee = 0.0;
        Double total_benefice_annee = 0.0;
        Double total_commission_annee = 0.0;
        Double total_benefice_end_annee = 0.0;
        
        try {
            
        //special font sizes
        Font bfBold12 = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD, new BaseColor(0, 0, 0)); 
        Font bfBold12_red = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD, new BaseColor(255, 0, 0)); 
        Font bf12 = new Font(FontFamily.TIMES_ROMAN, 12); 
        
        //file path
        docWriter = PdfWriter.getInstance(doc , out);
            
        //document header attributes
        doc.addAuthor("Mikolo");
        doc.addCreationDate();
        doc.addProducer();
        doc.addCreator("Asandratra");
        doc.addTitle("Stats");
        doc.setPageSize(PageSize.A4.rotate());
        
        //open document
        doc.open();
        
        //create a paragraph
        String parag = "Profits";
        parag = parag+" report for "+year.toString();

        Paragraph paragraph = new Paragraph(parag);
            
            
        //specify column widths
        float[] columnWidths = {2.5f, 1.5f, 3f, 3f, 3f, 3f, 3f, 3f, 3f};
        //create PDF table with the given widths
        PdfPTable table = new PdfPTable(columnWidths);
        // set table width a percentage of the page width
        table.setWidthPercentage(100f);
        
        //insert column headings
        insertCell(table, "MOIS", Element.ALIGN_LEFT, 1, bfBold12);
        insertCell(table, "ANNEE", Element.ALIGN_LEFT, 1, bfBold12);
        insertCell(table, "VENTES", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "ACHATS", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "BEN.BRUTE", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "PERTES", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "BENEFICE", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "COMM.", Element.ALIGN_RIGHT, 1, bfBold12);
        insertCell(table, "FINALE", Element.ALIGN_RIGHT, 1, bfBold12);
        table.setHeaderRows(1);
        
        insertCell(table, "", Element.ALIGN_LEFT, 9, bfBold12);
        
        for(V_benefice b : ben){
            insertCell(table, b.getMonth(), Element.ALIGN_LEFT, 1, bf12);
            insertCell(table, b.getYear().toString(), Element.ALIGN_LEFT, 1, bf12);
            insertCell(table, df.format(b.getTotal_vente()), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(b.getTotal_achat()), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(b.getTotal_benefice_brute()), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(-1*b.getTotal_perte()), Element.ALIGN_RIGHT, 1, bfBold12_red);
            insertCell(table, df.format(b.getTotal_benefice_brute()-b.getTotal_perte()), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(b.getTotal_commission()), Element.ALIGN_RIGHT, 1, bf12);
            insertCell(table, df.format(b.getTotal_benefice_brute()-b.getTotal_perte()-b.getTotal_commission()), Element.ALIGN_RIGHT, 1, bf12);

            total_vente_annee = total_vente_annee + b.getTotal_vente();
            total_achat_annee = total_achat_annee + b.getTotal_achat();
            total_benefice_brute_annee = total_benefice_brute_annee + b.getTotal_benefice_brute();
            total_perte_annee = total_perte_annee - b.getTotal_perte();
            total_benefice_annee = total_benefice_annee + (b.getTotal_benefice_brute()-b.getTotal_perte());
            total_commission_annee = total_commission_annee + b.getTotal_commission();
            total_benefice_end_annee = total_benefice_end_annee + (b.getTotal_benefice_brute()-b.getTotal_perte()-b.getTotal_commission());
        }

        insertCell(table, "", Element.ALIGN_LEFT, 9, bfBold12);

        insertCell(table, "TOTAL", Element.ALIGN_RIGHT, 2, bfBold12);
        insertCell(table, df.format(total_vente_annee), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_achat_annee), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_benefice_brute_annee), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_perte_annee), Element.ALIGN_RIGHT, 1, bfBold12_red);
        insertCell(table, df.format(total_benefice_annee), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_commission_annee), Element.ALIGN_RIGHT, 1, bf12);
        insertCell(table, df.format(total_benefice_end_annee), Element.ALIGN_RIGHT, 1, bf12);

        //add the PDF table to the paragraph 
        paragraph.add(table);
        // add the paragraph to the document
        doc.add(paragraph);
        
        }
        catch (DocumentException dex){
            dex.printStackTrace();
            throw dex;
        }
        catch (Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if (doc != null){
                //close the document
                doc.close();
            }
            if (docWriter != null){
                //close the writer
                docWriter.close();
            }
        }
    }
}
