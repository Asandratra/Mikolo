package app.apps.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
     @GetMapping(value = "/test")
     public String test() {
          return "form_planning";
     }

     @GetMapping(value = "/test2")
     public String test2() {
          return "proposing_planning";
     }

     @GetMapping(value = "/chart_filmset")
     public String test3() {
          return "chart_filmset";
     }

}
