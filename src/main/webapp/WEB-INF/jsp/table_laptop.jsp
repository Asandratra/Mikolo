<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    ArrayList<Laptop> laptops = (ArrayList) request.getAttribute("laptops");
    ArrayList<Brand> brands = (ArrayList) request.getAttribute("brands");
    ArrayList<Ram_option> ram_options = (ArrayList) request.getAttribute("ram_options");
    ArrayList<Storage_option> storage_options = (ArrayList) request.getAttribute("storage_options");
    ArrayList<Processor> processors = (ArrayList) request.getAttribute("processors");
    Integer current_page = (Integer) request.getAttribute("current_page");
    Integer count = (Integer) request.getAttribute("count");
    Integer npage = (Integer) request.getAttribute("npage");
    Laptop filter = new Laptop();
    if(session.getAttribute("laptopfilter")!=null) filter = (Laptop) session.getAttribute("laptopfilter");
%>
<div class="container-fluid">
    <h3 class="text-dark mb-4">Laptops</h3>
    <div class="card shadow">
        <div class="card-header py-3">
            <p class="text-primary m-0 fw-bold"><a href='<%= request.getContextPath()+"/form/laptop" %>'><button class="btn btn-primary d-block btn-user w-100"> + New laptop</button></a></p>
        </div>
        <div class="card-body">
            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                <table class="table my-0" id="dataTable">
                    <thead>
                        <tr>
                            <th>Reference</th>
                            <th>Brand</th> 
                            <th>Name</th>
                            <th>RAM</th>
                            <th>SSD</th>
                            <th>Processor</th>
                            <th>Screen size</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <form id="filter">
                        <tr>
                            <td><div><input class="ref" type="text" name="reference" value="<%= filter.getReference() %>" style="color: rgb(133, 135, 150);height: 28px;"></div></td>
                            <td><div><select class="brand" style="height: 28px;color: rgb(133, 135, 150);" name="brand">
                                <optgroup>
                                    <option value=null>Any</option>
                                    <%
                                    for(Brand b : brands){
                                    %><option value=<%= b.getId() %>><%= b.getName() %></option><%
                                    }
                                    %>
                                </optgroup>
                            </select></div></td> 
                            <td><div><input type="text" class="laptopname" name="name" value="<%= filter.getName() %>" style="color: rgb(133, 135, 150);height: 28px;"></div></td>
                            <td><div><select class="ram" style="height: 28px;color: rgb(133, 135, 150);" name="ram_option">
                                <optgroup>
                                    <option value=null>Any</option>
                                    <%
                                    for(Ram_option b : ram_options){
                                    %><option value=<%= b.getId() %>><%= b.getName() %></option><%
                                    }
                                    %>
                                </optgroup>
                            </select></div></td>
                            <td><div><select class="ssd" style="height: 28px;color: rgb(133, 135, 150);" name="storage_option">
                                <optgroup>
                                    <option value=null>Any</option>
                                    <%
                                    for(Storage_option b : storage_options){
                                    %><option value=<%= b.getId() %>><%= b.getName() %></option><%
                                    }
                                    %>
                                </optgroup>
                            </select></div></td>
                            <td><div><select class="processor" style="height: 28px;color: rgb(133, 135, 150);" name="processor">
                                <optgroup>
                                    <option value=null>Any</option>
                                    <%
                                    for(Processor b : processors){
                                    %><option value=<%= b.getId() %>><%= b.getName() %></option><%
                                    }
                                    %>
                                </optgroup>
                            </select></div></td>
                            <td><div><input class="screen_size" type="number" min="0" value="<%= filter.getScreen_size() %>" name="screen_size" style="color: rgb(133, 135, 150);height: 28px;width: 50px;"></div></td>
                            <td><div><input class="price" type="number" min="0" value="<%= filter.getPrice() %>" name="price" style="color: rgb(133, 135, 150);height: 28px;width: 150px;"></div></td>
                            <td>
                                <div><input type="submit" value="Filter"></div>
                            </td>
                        </tr>
                        </form>
                        <%
                        for(Laptop r : laptops){
                        %>
                        <tr>
                            <td><%= r.getReference() %></td>
                            <td><%= r.getBrand().getName() %></td>
                            <td><%= r.getName() %></td>
                            <td><%= r.getRam().getName() %></td>
                            <td><%= r.getStorage().getName() %></td>
                            <td><%= r.getProcessor().getName() %></td>
                            <td><%= r.getScreen_size() %>''</td>
                            <td><%= r.getPrice() %></td>
                            <td><a href='<%= request.getContextPath()+"/details/laptop/"+r.getId() %>'><button class="btn btn-primary d-block btn-user w-100">More</button></a></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-md-6 align-self-center">
                    <p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing <%= laptops.size() %> of <%= count %></p>
                </div>
                <div class="col-md-6">
                    <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                        <ul class="pagination">
                            <li class="page-item <% if(current_page==1) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/laptop/"+(current_page-1) %>' aria-label="Previous"> « </a></li>
                            <%
                            for(int i = 1 ; i<=npage;i++){
                            %>
                                <li class='page-item <% if(i==current_page) out.print("active"); %>'><a class="page-link" href='<%= request.getContextPath()+"/table/laptop/"+i %>'><%= i %></a></li>
                            <%
                            }
                            %>

                            <li class="page-item <% if(current_page==npage) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/laptop/"+(current_page+1) %>' aria-label="Next"> » </a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    const urlredirect = '<%= request.getContextPath()+"/table/laptop/1" %>';
    const url = '<%= request.getContextPath()+"/search/laptop" %>';
    const formulaire = document.getElementById('filter');
   
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
             "brand":{"id":brand[0]},
             "reference":ref[0],
             "ram":{"id":ram[0]},
             "storage":{"id":ssd[0]},
             "processor":{"id":processor[0]},
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