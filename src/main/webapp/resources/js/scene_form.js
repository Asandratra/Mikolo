function effacer(component) {
     ($($($(component).parent()).parent()).parent()).remove();
}

function ajouter(liste_perso) {
     var optionactors="";
               for(let i=0;i<liste_perso.length;i++){
                    optionactors+='<option value="'+liste_perso[i].id+'">'+liste_perso[i].name+'</option>';
               }
     var html = '<div class="row custom-shadow" >'+
'     <div class="col-md-12" id="dialogue_personnage">'+
'          <label for="">Personnage</label>'+
'          <div class="form-group row">'+
'               <select name="dialogue_personnage" class="form-control col-md-2" >'+optionactors+
'               </select>'+
'               <div class="col-md-7"></div>'+
'               <button class="btn btn-danger col-md-3"  type="button" onClick="effacer(this)">- enlever</button>'+
'          </div>'+
'     </div>'+
'     <div class="col-md-6" id="dialogue_dialogue">'+
'          <div class="form-group">'+
'               <label for="">Dialogue</label>'+
'               <textarea class="form-control" placeholder="..." rows="3"'+
'                    name="dialogue_texte"></textarea>'+
'          </div>'+
'     </div>'+
'     <div class="col-md-6" id="dialogue_action">'+
'          <div class="form-group">'+
'               <label for="">Action</label>'+
'               <textarea class="form-control" placeholder="..." rows="3"'+
'                    name="dialogue_action"></textarea>'+
'          </div>'+
'     </div>'+
'</div> ';
     $("#dialogue").append(html);                  
}
