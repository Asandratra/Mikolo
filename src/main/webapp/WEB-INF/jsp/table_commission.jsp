<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    ArrayList<Commission> commissions = (ArrayList) request.getAttribute("commissions");
    Integer current_page = (Integer) request.getAttribute("current_page");
    Integer count = (Integer) request.getAttribute("count");
    Integer npage = (Integer) request.getAttribute("npage");
%>
<div class="container-fluid">
    <h3 class="text-dark mb-4">Commissions</h3>
    <div class="card shadow">
        <div class="card-header py-3">
            <p class="text-primary m-0 fw-bold"><a href='<%= request.getContextPath()+"/form/commission" %>'><button class="btn btn-primary d-block btn-user w-100"> + New Commission</button></a></p>
        </div>
        <div class="card-body">
            <% if(commissions!=null && commissions.size()>0) { %>
            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                <table class="table my-0" id="dataTable">
                    <thead>
                        <tr>
                            <th>Total min</th>
                            <th>Total max</th>
                            <th>Commission</th>
                        </tr>
                    </thead>
                    <tbody><!-- 
                        <form action='<%= request.getContextPath()+"/commission_search" %>' method="get" hidden>
                        <tr>
                            <td>
                                <div><input type="text" name="name" style="color: rgb(133, 135, 150);height: 28px;"></div>
                            </td>
                            <td>
                                <div><input type="submit" value="Filter"></div>
                            </td>
                        </tr>
                        </form> -->
                        <%
                        for(Commission b : commissions){
                        %>
                        <tr>
                            <form action='<%= request.getContextPath()+"/update/commission/"+b.getId() %>' method="post">
                                <input type="hidden" name="id" value=<%= b.getId() %> >
                                <td><input type="number" min="0" name="min" value=<%= b.getTotal_min() %>></td>
                                <td><input type="number" min="0" name="max" value=<%= b.getTotal_max() %>></td>
                                <td><input type="number" min="0" max="100" name="com" value=<%= b.getPercentage() %>>%</td>
                                <td><input type="submit" value="Change" class="btn btn-primary d-block btn-user w-100"></td>
                            </form>
                            <td><a href='<%= request.getContextPath()+"/delete/commission/"+b.getId() %>'><button class="btn btn-primary d-block btn-user w-100">Delete</button></a></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-md-6 align-self-center">
                    <p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing <%= commissions.size() %> of <%= count %></p>
                </div>
                <div class="col-md-6">
                    <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                        <ul class="pagination">
                            <li class="page-item <% if(current_page==1) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/commission/"+(current_page-1) %>' aria-label="Previous"> « </a></li>
                            <%
                            for(int i = 1 ; i<=npage;i++){
                            %>
                                <li class='page-item <% if(i==current_page) out.print("active"); %>'><a class="page-link" href='<%= request.getContextPath()+"/table/commission/"+i %>'><%= i %></a></li>
                            <%
                            }
                            %>

                            <li class="page-item <% if(current_page==npage) out.print("disabled"); %>"><a class="page-link" href='<%= request.getContextPath()+"/table/commission/"+(current_page+1) %>' aria-label="Next"> » </a></li>
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