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

@Controller
public class SampleController {

    @Autowired
    SampleService sampleService;

    /* 
     * @GetMapping(value = "/film/{id}/planning")
     * public String theplanning(HttpServletRequest request, HttpSession session)
     * throws Exception {
     * Film current = null;
     * try {
     * current = (Film) session.getAttribute("current_film");
     * request.setAttribute("liste_planning",
     * planningService.listToJson(planningService.listPlanning(current.getId())));
     * } catch (Exception ex) {
     * ex.printStackTrace();
     * //throws ex; request.setAttribute("erreur", ex.getMessage());
     * }
     * return "planning";
     * }
     

    // todo
    @GetMapping(value = "/{id}/planifier")
    public String to_planning(HttpServletRequest request, HttpSession session) {
         Film current = null;
        try {
            current = (Film) session.getAttribute("current_film");
            // liste des scenes non planifiées atao dans "liste_scene"
            request.setAttribute("liste_scene", sceneService.getUnplannedScene(current.getId()));
            request.setAttribute("plateau", fsService.getAllFilmSet());
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
        } 
        return "nextForm";
    }

    @PostMapping(value = "/{id}/planifier")
    public String planning(HttpServletRequest request, HttpSession session,
            @RequestParam(required = false, name = "idscene") Integer[] ids,
            @RequestParam(name = "start_date") String date1, @RequestParam(name = "end_date") String date2) {
        Film current = null;
        Timestamp commencement = null;
        try {
            current = (Film) session.getAttribute("current_film");
            if (current != null) {
                commencement = Timestamp.valueOf(date1.replace("T", " ") + ":00");
            }
            // traitement du planning
            List<Planning> lp = planningService.proposerPlanning(ids,
                    Timestamp.valueOf(date1.replace("T", " ") + ":00"),
                    Timestamp.valueOf(date2.replace("T", " ") + ":00"));
            System.out.println(lp);
            List<DatePlanning> ldp = planningService.generateDatePlanning(lp);
            if (lp != null)
                System.out.println(lp.size());
            request.setAttribute("nbr_scene", ids.length);
            request.setAttribute("start_date", date1.replace("T", " "));
            request.setAttribute("liste_planning", lp);
            request.setAttribute("liste_date_planning",ldp);
            return "proposing_planning_2";// "redirect:/film/" + current.getId() + "/planning";
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", ex.getMessage());
            return to_planning(request, session);
        }
    } */
}
