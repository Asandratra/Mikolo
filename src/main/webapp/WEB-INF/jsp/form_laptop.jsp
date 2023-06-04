<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    ArrayList<Brand> brands = (ArrayList) request.getAttribute("brands");
    ArrayList<Ram_option> ram_options = (ArrayList) request.getAttribute("ram_options");
    ArrayList<Storage_option> storage_options = (ArrayList) request.getAttribute("storage_options");
    ArrayList<Processor> processors = (ArrayList) request.getAttribute("processors");
%>
<div class="container-fluid">
    <div class="card shadow-lg o-hidden border-0 my-5">
        <div class="card-body p-0">
            <div class="p-5">
                <div class="text-center">
                    <h4 class="text-dark mb-4">New Laptop model</h4>
                </div>
                <p id="error" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                <form id="form" class="user">
                    <div class="mb-3">
                        Name<br/>
                        <input class="laptopname form-control form-control-user" type="text" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Laptop name" name="name" required>
                    </div>
                    <div class="mb-3">
                        Brand<br/>
                        <select class="brand form-control form-control-user" name="brand">
                            <%
                            for(Brand b : brands){
                            %><option value=<%= b.getId() %>><%= b.getName() %></option><%
                            }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        Reference<br/>
                        <input class="ref form-control form-control-user" type="text" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Laptop name" name="name" required>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-6 mb-3 mb-sm-0">
                            RAM<br/>
                            <select class="ram form-control form-control-user" name="ram">
                                <%
                                for(Ram_option b : ram_options){
                                %><option value=<%= b.getId() %>><%= b.getName() %></option><%
                                }
                                %>
                            </select>
                        </div>
                        
                        <div class="col-sm-6">
                            SSD<br/>
                            <select class="ssd form-control form-control-user" name="ram">
                                <%
                                for(Storage_option b : storage_options){
                                %><option value=<%= b.getId() %>><%= b.getName() %></option><%
                                }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        Processor<br/>
                        <select class="processor form-control form-control-user" name="brand">
                            <%
                            for(Processor b : processors){
                            %><option value=<%= b.getId() %>><%= b.getName() %></option><%
                            }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        Screen_size<br/>
                        <input class="screen_size form-control form-control-user" type="number" min="0" id="exampleInputEmail" aria-describedby="emailHelp" name="name" required>
                    </div>
                    <div class="mb-3">
                        Price<br/>
                        <input class="price form-control form-control-user" type="number" min="0" id="exampleInputEmail" aria-describedby="emailHelp" name="name" required>
                    </div>
                    <div class="row" style="margin: 0px -12px;">
                        <div class="col">
                        </div>
                        <div class="col">
                            <div class="text-end d-xl-flex justify-content-xl-end" style="width: 180px;margin: 0px 30%;"><button class="btn btn-primary d-block btn-user w-100" type="submit" style="width: 825.6px;">Add</button></div>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Image En Base 64 -->
<!-- <script type="text/javascript">
    const input = document.getElementById("selectimage");
    const hidden = document.getElementById("upload");
    const convertBase64 = (file) => {
        return new Promise((resolve,reject) => {
            const fileReader = new FileReader();
            fileReader.readAsDataURL(file);

            fileReader.onload = () => {
                resolve(fileReader.result);
            };

            fileReader.onerror = (error) => {
                reject(error);
            };
        });
    };
    const uploadImage = async (event) => {
        const file = event.target.files[0];
        const base64 = await convertBase64(file);
        hidden.value = base64;
        console.log(hidden.value);
    };
    input.addEventListener("change", (e) => {
        uploadImage(e);
    });
</script> -->

<script type="text/javascript">
 const urlredirect = '<%= request.getContextPath()+"/table/laptop/1" %>';
 const url = '<%= request.getContextPath()+"/save/laptop" %>';
 const formulaire = document.getElementById('form');

 formulaire.addEventListener('submit', function (event) {
      event.preventDefault(); // Empêche le formulaire d'être soumis
      const name = Array.from(document.getElementsByClassName("laptopname")).map(option => option.value);
      const brand = Array.from(document.getElementsByClassName("brand")).map(option => option.value);
      const ref = Array.from(document.getElementsByClassName("ref")).map(option => option.value);
      const ram = Array.from(document.getElementsByClassName("ram")).map(option => option.value);
      const ssd = Array.from(document.getElementsByClassName("ssd")).map(option => option.value);
      const processor = Array.from(document.getElementsByClassName("processor")).map(option => option.value);
      const screen = Array.from(document.getElementsByClassName("screen_size")).map(option => option.value);
      const price = Array.from(document.getElementsByClassName("price")).map(option => option.value);
      console.log(name);
      console.log(brand);
      console.log(ref);
      console.log(ram);
      console.log(ssd);
      console.log(processor);
      console.log(screen);
      console.log(price);

      //alert("Submit pressed");
      const data = {
          "brand":{"id":parseInt(brand[0])},
          "reference":ref[0],
          "ram":{"id":parseInt(ram[0])},
          "storage":{"id":parseInt(ssd[0])},
          "processor":{"id":parseInt(processor[0])},
          "screen_size":screen[0],
          "name":name[0],
          "price":price[0]
      }
      $.ajax({
           url: url,
           type: 'POST',
           data: JSON.stringify(data),
           dataType: 'json',
           contentType: 'application/json',
           success: function (response) {
                //console.log(response);
                window.location.href = urlredirect;
           },
           error: function (xhr, status, error) {
                console.log(xhr);
                if (xhr.status == 200 || xhr.status == "200") {
                     window.location.href = urlredirect;
                }
                else {
                     console.log(xhr.responseText);
                     document.getElementById("error").innerHTML = xhr.responseText;
                }
           }
      });
 });
</script>