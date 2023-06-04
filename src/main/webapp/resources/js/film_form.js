
          function effacer(component) {
               ($($($(component).parent()).parent()).parent()).remove();
          }

          function ajouter(liste_actor, liste_gender) {
               console.log('appender');
               var optionactors="";
               for(let i=0;i<liste_actor.length;i++){
                    optionactors+='<option value="'+liste_actor[i].id+'">'+liste_actor[i].name+'</option>';
               }
               var optiongender="";
               for(let i=0;i<liste_gender.length;i++){
                    optiongender+='<option value="'+liste_gender[i].id+'">'+liste_gender[i].name+'</option>';
               }
               var html = '<div class="row custom-shadow">'+
'               <div class="col-md-4">'+
'                    <div class="form-group">'+
'                         <label for="">Nom</label>'+
'                         <input type="text" class="form-control"'+
'                              placeholder="place" name="personnage_nom">'+
'                    </div>'+
'               </div>'+
'               <div class="col-md-4">'+
'                    <div class="form-group">'+
'                         <label for="">Genre</label>'+
'                         <select class="form-control" name="personnage_genre">'+
'                              '+optiongender+
'                         </select>'+
'                    </div>'+
'               </div>'+
'               <div class="col-md-2"></div>'+
'               <div class="col-md-2">'+
'                    <div class="form-group">'+
'                         <br/>'+
'                         <button class="btn btn-danger" type="button"'+
'                              onClick="effacer(this)">- enlever</button>'+
'                    </div>'+
'               </div>'+
'               <div class="col-md-6" id="dialogue_action">'+
'                    <div class="form-group">'+
'                         <label for="">Acteur</label>'+
'                         <select class="form-control" name="personnage_acteur">'+ optionactors+
'                         </select>'+
'                    </div>'+
'               </div>'+
'               <div class="col-md-12" id="dialogue_dialogue">'+
'                    <div class="form-group">'+
'                         <label for="">description</label>'+
'                         <textarea class="form-control" placeholder="..."'+
'                              rows="3" name="personnage_description"></textarea>'+
'                    </div>'+
'               </div>'+
'               <br/>'+
'          </div>';
               $("#personnage").append(html);                  
          }
