<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    ArrayList<Shop> shops = (ArrayList) request.getAttribute("shops");
    Shop filter = new Shop();
    if(session.getAttribute("shopfilter")!=null) filter = (Shop) session.getAttribute("shopfilter");
    Integer current_page = (Integer) request.getAttribute("current_page");
    Integer count = (Integer) request.getAttribute("count");
    Integer npage = (Integer) request.getAttribute("npage");
%>
<div class="container-fluid">
    <h3 class="text-dark mb-4">Shops</h3>
    <div class="card shadow">
        <div class="card-header py-3">
            <p class="text-primary m-0 fw-bold"><a href='<%= request.getContextPath()+"/form/shop" %>'><button class="btn btn-primary d-block btn-user w-100"> + New shop</button></a></p>
        </div>
        <div class="card-body">
            <% if(shops!=null && shops.size()>0) { %>
            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                <table class="table my-0" id="dataTable">
                    <thead>
                        <tr>
                            <th>Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <form id="filter">
                        <tr>
                            <td>
                                <div><input class="shopname" value="<%= filter.getLocalisation() %>" type="text" name="name" style="color: rgb(133, 135, 150);height: 28px;"></div>
                            </td>
                            <td>
                                <div><input type="submit" value="Filter"></div>
                            </td>
                        </tr>
                        </form>
                        <%
                        for(Shop r : shops){
                        %>
                        <tr>
                            <td><%= r.getLocalisation() %></td>
                            <td><a href='<%= request.getContextPath()+"/table/sell/"+r.getId() %>'><button class="btn btn-primary d-block btn-user w-100">Sells</button></a></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-md-6 align-self-center">
                    <p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing <%= shops.size() %> of <%= count %></p>
                </div>
                <div class="col-md-6">
                    <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                        <ul class="pagination">
                            <li class="page-item <% if(current_page==1) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/shop/"+(current_page-1) %>' aria-label="Previous"> « </a></li>
                            <%
                            for(int i = 1 ; i<=npage;i++){
                            %>
                                <li class='page-item <% if(i==current_page) out.print("active"); %>'><a class="page-link" href='<%= request.getContextPath()+"/table/shop/"+i %>'><%= i %></a></li>
                            <%
                            }
                            %>

                            <li class="page-item <% if(current_page==npage) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/shop/"+(current_page+1) %>' aria-label="Next"> » </a></li>
                        </ul>
                    </nav>
                </div>
            </div>
            <% }
            else { %>
                <p>No Results</p>
            <% } %>

        </div>
    </div>
</div>
<script type="text/javascript">
    const urlredirect = '<%= request.getContextPath()+"/table/shop/1" %>';
    const url = '<%= request.getContextPath()+"/search/shop" %>';
    const formulaire = document.getElementById('filter');

    formulaire.addEventListener('submit', function (event) {
      event.preventDefault(); // Empêche le formulaire d'être soumis
      const name = Array.from(document.getElementsByClassName("shopname")).map(option => option.value);
      console.log(name);

      //alert("Submit pressed");
      const data = {
           "localisation": name[0],
           "shop_type": {"id": 1}
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