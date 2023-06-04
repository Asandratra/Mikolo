$(document).on("change", "#idOption", function(){
          console.log('hello');
          if ( $('#idOption').val()=='2'){
               $('#datefin').css('display','none');
          }else{
               $('#datefin').css('display','block');
          }
    });
