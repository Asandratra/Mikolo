<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    ArrayList<Profile> profiles = (ArrayList) request.getAttribute("profiles");
    ArrayList<Shop> shops = (ArrayList) request.getAttribute("shops");
    Integer current_page = (Integer) request.getAttribute("current_page");
    Integer count = (Integer) request.getAttribute("count");
    Integer npage = (Integer) request.getAttribute("npage");
    Profile filter = new Profile();
    if(session.getAttribute("profilefilter")!=null) filter = (Profile) session.getAttribute("profilefilter");
%>
<div class="container-fluid">
    <h3 class="text-dark mb-4">Profiles</h3>
    <div class="card shadow">
        <div class="card-header py-3">
            <p class="text-primary m-0 fw-bold"><a href='<%= request.getContextPath()+"/form/profile" %>'><button class="btn btn-primary d-block btn-user w-100"> + New profile</button></a></p>
        </div>
        <div class="card-body">
            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                <table class="table my-0" id="dataTable">
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Shop</th>
                        </tr>
                    </thead>
                    <tbody>
                        <form id="filter">
                        <tr>
                            <td>
                                <div><input class="username" value="<%= filter.getUsername() %>" type="text" name="name" style="color: rgb(133, 135, 150);height: 28px;"></div>
                            </td>
                            <td>
                                <div><input class="email" type="text" value="<%= filter.getEmail() %>" name="email" style="color: rgb(133, 135, 150);height: 28px;"></div>
                            </td>
                            <td><div><select class="shop" style="height: 28px;color: rgb(133, 135, 150);" name="shop">
                                <optgroup>
                                    <option value=null>Any</option>
                                    <%
                                    for(Shop b : shops){
                                    %><option value=<%= b.getId() %>><%= b.getLocalisation() %></option><%
                                    }
                                    %>
                                </optgroup>
                            </select></div></td>
                            <td>
                                <div><input type="submit" value="Filter"></div>
                            </td>
                        </tr>
                        </form>
                        <%
                        for(Profile b : profiles){
                        %>
                        <tr>
                            <td><%= b.getUsername() %></td>
                            <td><%= b.getEmail() %></td>
                            <td><%= b.getShop().getLocalisation() %></td>
                            <td><a href='<%= request.getContextPath()+"/details/profile/"+b.getId() %>'><button class="btn btn-primary d-block btn-user w-100">More</button></a></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-md-6 align-self-center">
                    <p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing <%= profiles.size() %> of <%= count %></p>
                </div>
                <div class="col-md-6">
                    <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                        <ul class="pagination">
                            <li class="page-item <% if(current_page==1) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/profile/"+(current_page-1) %>' aria-label="Previous"> « </a></li>
                            <%
                            for(int i = 1 ; i<=npage;i++){
                            %>
                                <li class='page-item <% if(i==current_page) out.print("active"); %>'><a class="page-link" href='<%= request.getContextPath()+"/table/profile/"+i %>'><%= i %></a></li>
                            <%
                            }
                            %>

                            <li class="page-item <% if(current_page==npage) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/profile/"+(current_page+1) %>' aria-label="Next"> » </a></li>
                        </ul>
                    </nav>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    const urlredirect = '<%= request.getContextPath()+"/table/profile/1" %>';
    const url = '<%= request.getContextPath()+"/search/profile" %>';
    const formulaire = document.getElementById('filter');

    formulaire.addEventListener('submit', function (event) {
        event.preventDefault(); // Empêche le formulaire d'être soumis
        const name = Array.from(document.getElementsByClassName("username")).map(option => option.value);
        const email = Array.from(document.getElementsByClassName("email")).map(option => option.value);
        const shop = Array.from(document.getElementsByClassName("shop")).map(option => option.value);

        //alert("Submit pressed");
        const data = {
                "username": name[0],
                "email": email[0],
                "shop": {"id":shop[0]}
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
                    }
            }
        });
    });
</script>