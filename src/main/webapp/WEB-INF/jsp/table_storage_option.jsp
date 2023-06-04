<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    ArrayList<Storage_option> storage_options = (ArrayList) request.getAttribute("storage_options");
    Integer current_page = (Integer) request.getAttribute("current_page");
    Integer count = (Integer) request.getAttribute("count");
    Integer npage = (Integer) request.getAttribute("npage");
%>
<div class="container-fluid">
    <h3 class="text-dark mb-4">SSD Options</h3>
    <div class="card shadow">
        <div class="card-header py-3">
            <p class="text-primary m-0 fw-bold"><a href='<%= request.getContextPath()+"/form/storage_option" %>'><button class="btn btn-primary d-block btn-user w-100"> + New ram option</button></a></p>
        </div>
        <div class="card-body">
            <% if(storage_options!=null && storage_options.size()>0) { %>
            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                <table class="table my-0" id="dataTable">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Capacity</th>
                        </tr>
                    </thead>
                    <tbody><!-- 
                        <form action='<%= request.getContextPath()+"/storage_option_search" %>' method="get" hidden>
                        <tr>
                            <td>
                                <div><input type="text" name="name" style="color: rgb(133, 135, 150);height: 28px;"></div>
                            </td>
                            <td>
                                <div><input type="number" min="0" name="capacity" style="color: rgb(133, 135, 150);height: 28px;"></div>
                            </td>
                            <td>
                                <div><input type="submit" value="Filter"></div>
                            </td>
                        </tr>
                        </form> -->
                        <%
                        for(Storage_option r : storage_options){
                        %>
                        <tr>
                            <td><%= r.getName() %></td>
                            <td><%= r.getCapacity() %></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-md-6 align-self-center">
                    <p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing <%= storage_options.size() %> of <%= count %></p>
                </div>
                <div class="col-md-6">
                    <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                        <ul class="pagination">
                            <li class="page-item <% if(current_page==1) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/storage_option/"+(current_page-1) %>' aria-label="Previous"> « </a></li>
                            <%
                            for(int i = 1 ; i<=npage;i++){
                            %>
                                <li class='page-item <% if(i==current_page) out.print("active"); %>'><a class="page-link" href='<%= request.getContextPath()+"/table/storage_option/"+i %>'><%= i %></a></li>
                            <%
                            }
                            %>

                            <li class="page-item <% if(current_page==npage) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/storage_option/"+(current_page+1) %>' aria-label="Next"> » </a></li>
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