                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                         
                            <div class="" >
                                <div class="row">                                  
                                    <div class="col-lg-12">
                                        <div class="card-body b-l calender-sidebar">
                                             <h1>Planning</h1>
                                             <a class="btn btn-primary col-md-2" href="#">Button</a>
                                            <div id="calendar"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
<script src="${pageContext.request.contextPath}/resources/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/extra-libs/jvector/jquery-jvectormap-world-mill-en.js"></script>
<script src="${pageContext.request.contextPath}/resources/dist/js/pages/dashboards/dashboard1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/extra-libs/prism/prism.js"></script>

<script src="${pageContext.request.contextPath}/resources/assets/extra-libs/select2/select2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/dist/js/select2.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/libs/moment/min/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/libs/fullcalendar/dist/fullcalendar.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/dist/js/pages/calendar/cal-init.js"></script>       

    <script type="text/javascript">
        $.CalendarApp.init(<%= film.getId() %>,<%= request.getAttribute("liste_planning") %>, <%= request.getAttribute("liste_holiday") %>);
    </script>
