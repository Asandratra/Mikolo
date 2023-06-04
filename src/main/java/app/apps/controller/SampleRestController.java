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

@RestController
public class SampleRestController {/* 
    @Autowired
    FilmService filmService;

    @Autowired
    ActorService actorService;

    @Autowired
    CharaterService charaterService;

    @Autowired
    GenderService genderService;

    @Autowired
    PlanningService planningService;

    @Autowired
    StatusPlanningService statusplanningService;

    @Autowired
    SceneService sceneService;

    @RequestMapping(value="/{idf}/confirmer_planning", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> confirmPlanning(@RequestBody List<Planning> planning)throws Exception{
        try{
            planningService.insertPlanning(planning);
        }
        catch(Exception ex){
            System.out.println("    Error:"+ex.getMessage());
            return new ResponseEntity(ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
        System.out.println("    Success confirmation");
        return new ResponseEntity("Planning confirmed",HttpStatus.OK);
    } */
}
