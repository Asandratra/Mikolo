<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    Profile current_user = null;
    if(session.getAttribute("user")!=null) current_user = (Profile) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title><%= session.getAttribute("title") %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/fonts/fontawesome5-overrides.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        #diagram-container {
            width: 100%;
        }
    </style>
</head>

<body id="page-top">
    <% if(current_user!=null) { %>
    <div id="wrapper">
        <nav class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0">
            <div class="container-fluid d-flex flex-column p-0"><a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="#">
                    <div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-seedling"></i></div>
                    <div class="sidebar-brand-text mx-3"><span>Mikolo</span></div>
                </a>
                <hr class="sidebar-divider my-0">
                <ul class="navbar-nav text-light" id="accordionSidebar">
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/laptop/1" %>'><i class="fas fa-table"></i><span>Laptops</span></a></li>
                    <% if(current_user.getShop().getShop_type().getId()>=2) {
                    %>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/profile/1" %>'><i class="fas fa-user"></i><span>Profiles</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/shop/1" %>'><i class="fas fa-table"></i><span>Shops</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/sell/0" %>'><i class="fas fa-table"></i><span>Global Sells</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/brand/1" %>'><i class="fas fa-table"></i><span>Brands</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/processor/1" %>'><i class="fas fa-table"></i><span>Processors</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/ram_option/1" %>'><i class="fas fa-table"></i><span>Ram Options</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/storage_option/1" %>'><i class="fas fa-table"></i><span>SSD Options</span></a></li>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/commission/1" %>'><i class="fas fa-table"></i><span>Commissions</span></a></li>
                    <%
                    }
                    else{
                    %>
                    <li class="nav-item"><a class="nav-link active" href='<%= request.getContextPath()+"/table/sell/"+current_user.getShop().getId() %>'><i class="fas fa-table"></i><span>Sells</span></a></li><%
                    }
                    %>
                    <li class="nav-item"><a class="nav-link" href='<%= request.getContextPath()+"/" %>'><i class="fas fa-sign-out"></i><span>Disconnect</span></a></li>
                </ul>
            </div>
        </nav>
        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content">
                <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top">
                    <div class="container-fluid">
                        <ul class="navbar-nav flex-nowrap ms-auto">
                            <li class="nav-item dropdown no-arrow">
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href='<%= request.getContextPath()+"/details" %>'>
                                    <% if(current_user.getShop().getShop_type().getId()>=2) {
                                        %><div><strong style="color:blue; background-color: lightblue;">  Admin  </strong></div><%
                                    }
                                    %>
                                    <span class="d-none d-lg-inline me-2 text-gray-600 small"> <%= current_user.getUsername() %>, <%= current_user.getEmail() %></span>
                                </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- CONTENT -->
                <jsp:include page ='<%= session.getAttribute("content")+".jsp" %>' />


            </div>
            <% }
            else { %>
            <div class="container">
                <div class="card shadow-lg o-hidden border-0 my-5" style="margin: 48px 100px;">
                    <div class="card-body p-0">
                        <div class="p-5">
                            <div class="text-center">
                                <h4 class="text-dark mb-4">Sign in</h4>
                                <p id="error" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);">User unidentified!</p>
                            </div>
                            <div class="text-center"><a class="small" href='<%= request.getContextPath()+"/" %>'>Sign in</a></div>
                        </div>
                    </div>
                </div>
            </div>
            <% }
            %>
            <footer class="bg-white sticky-footer">
                <div class="container my-auto">
                    <div class="text-center my-auto copyright"><span>ETU001602 Rakotondramaka Asandratra Mitia Ny Aina, Mai 2023</span></div>
                </div>
            </footer>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
    <script src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bs-init.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/theme.js"></script>
    
    <script src="${pageContext.request.contextPath}/resources/assets/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/type_article.js"></script>
    <!-- apps -->
    <!-- apps -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/app-style-switcher.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/custom.min.js"></script>
    <!--This page JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/assets/extra-libs/c3/d3.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/extra-libs/c3/c3.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/libs/chartist/dist/chartist.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/pages/dashboards/dashboard1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/extra-libs/prism/prism.js"></script>

    <script src="${pageContext.request.contextPath}/resources/assets/extra-libs/select2/select2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/select2.js"></script>
</body>

</html>