<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.text.*,java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    Profile current_user = null;
    if(session.getAttribute("user")!=null) current_user = (Profile) session.getAttribute("user");

    DecimalFormat df = new DecimalFormat("#,###.##");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    ArrayList<V_vente> ventes = (ArrayList) request.getAttribute("ventes");
    ArrayList<V_benefice> benefice = (ArrayList) request.getAttribute("benefices");
    Integer shop = (Integer) request.getAttribute("shop");

    String ref = "";
    if(session.getAttribute("filtreref")!=null) ref = session.getAttribute("filtreref").toString();
    Double pmn = 0.0;
    if(session.getAttribute("filtreprixmin")!=null) pmn = (Double) session.getAttribute("filtreprixmin");
    Double pmx = 0.0;
    if(session.getAttribute("filtreprixmax")!=null) pmx = (Double) session.getAttribute("filtreprixmax");
    Integer year = Integer.valueOf(new SimpleDateFormat("yyyy").format(new java.util.Date()));
    if(session.getAttribute("year")!=null) year = (Integer) session.getAttribute("year");

    Shop current_shop = (Shop) request.getAttribute("shop_entity");
    String msg = null;
    if(request.getAttribute("message")!=null) msg = request.getAttribute("message").toString();

    String[] mois = {"January","February","March","April","May","June","July","August","September","October","November","December"};
    Double[] val = (Double[]) request.getAttribute("val");

    Double total_vente_annee = 0.0;
    Double total_achat_annee = 0.0;
    Double total_benefice_brute_annee = 0.0;
    Double total_perte_annee = 0.0;
    Double total_benefice_annee = 0.0;
    Double total_commission_annee = 0.0;
    Double total_benefice_end_annee = 0.0;

    Double vente_mois = 0.0;
    Double achat_mois = 0.0;
    Double benefice_brute_mois = 0.0;
    Double perte_mois = 0.0;
    Double benefice_mois = 0.0;
    Double commission_mois = 0.0;
    Double benefice_end_mois = 0.0;

    Double total_vente_mois = 0.0;
    Double total_achat_mois = 0.0;
    Double total_benefice_brute_mois = 0.0;
    Double total_perte_mois = 0.0;
    Double total_benefice_mois = 0.0;
    Double total_commission_mois = 0.0;
    Double total_benefice_end_mois = 0.0;
%>
<div class="container-fluid">
    <h3 class="text-dark mb-4">Sales <% if(current_shop!=null) out.print(current_shop.getLocalisation()); %></h3>
    <div class="card shadow">
        <div class="card-body">

            <!-- Filtre -->
            <div class="row">
                <div class="col">
                    <form id="form" class="user" action='<%= request.getContextPath()+"/search/sell/"+shop %>' method="post">
                        <div class="mb-3">
                            Year<br/>
                            <input class="form-control form-control-user" type="number" min="0" name="year" value=<%= year %> required>
                        </div>
                        <div class="mb-3">
                            Reference<br/>
                            <input class="form-control form-control-user" type="text" name="ref" value='<%= ref %>'>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                Min. sale price<br/>
                                <input class="form-control form-control-user" type="number" min="0"  name="prix_min" value=<%= pmn %> required>
                            </div>
                            <div class="col-sm-6 mb-3 mb-sm-0">
                                Max. sale price<br/>
                                <input class="form-control form-control-user" type="number" min="0"  name="prix_max" value=<%= pmx %> required>
                            </div>
                        </div>
                        <div class="row" style="margin: 0px -12px;">
                            <div class="col">
                            </div>
                            <div class="col">
                            </div>
                            <div class="col">
                                <div class="text-end d-xl-flex justify-content-xl-end" style="width: 180px;margin: 0px 30%;"><button class="btn btn-primary d-block btn-user w-100" type="submit" style="width: 825.6px;">Filter</button></div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
            <%
            if(msg!=null){
                %>
                <div class="row">
                    <div class="col">
                            <p class="text-primary m-0 fw-bold"><%= msg %></p>
                    </div>
                </div>
                <%
            }
            %>

            <%
            if(shop<=0){
                %>
                <!-- Graphe -->
                <div class="row">
                    <div class="col">
                        <div class="card-header py-3">
                            <p class="text-primary m-0 fw-bold">Sales Evolution</p>
                        </div>
                        <div id="diagram-container">
                            <canvas id="evolution-chart"></canvas>
                        </div>
                    </div>
                </div>
    
                <!-- Benefice -->
                <div class="row">
                    <div class="col">
                        <div class="card-header py-3">
                            <p class="text-primary m-0 fw-bold">Profits
                            <%
                            if(msg==null){
                            %>
                            <form action='<%= request.getContextPath()+"/pdf/benefice/" %>' method="get">
                                <input type="hidden" name="year" value=<%= year %> >
                                <input class="btn btn-primary d-block btn-user w-100" type="submit" value="Generate PDF">
                            </form>
                            <%
                            }
                            %>
                            </p>
                        </div>
                        <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                            <table class="table my-0" id="dataTable">
                                <thead>
                                    <tr>
                                        <th>Month</th>
                                        <th>Year</th>
                                        <th>Sales</th>
                                        <th>Purchases</th>
                                        <th>Gross Profit</th>
                                        <th>Loss</th>
                                        <th>Profit</th>
                                        <th>Commissions</th>
                                        <th>End Profit</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    for(V_benefice b : benefice){
                                    %>
                                    <tr>
                                        <td><%= b.getMonth() %></td>
                                        <td><%= b.getYear() %></td>
                                        <td><%= df.format(b.getTotal_vente()) %></td>
                                        <td><%= df.format(b.getTotal_achat()) %></td>
                                        <td><%= df.format(b.getTotal_benefice_brute()) %></td>
                                        <td style="color: red;"><%= df.format(-1*b.getTotal_perte()) %></td>
                                        <td><%= df.format(b.getTotal_benefice_brute()-b.getTotal_perte()) %></td>
                                        <td style="color: blue;"><%= df.format(b.getTotal_commission()) %></td>
                                        <td><%= df.format(b.getTotal_benefice_brute()-b.getTotal_perte()-b.getTotal_commission()) %></td>
                                    </tr>
                                    <%
                                    total_vente_annee = total_vente_annee + b.getTotal_vente();
                                    total_achat_annee = total_achat_annee + b.getTotal_achat();
                                    total_benefice_brute_annee = total_benefice_brute_annee + b.getTotal_benefice_brute();
                                    total_perte_annee = total_perte_annee - b.getTotal_perte();
                                    total_benefice_annee = total_benefice_annee + (b.getTotal_benefice_brute()-b.getTotal_perte());
                                    total_commission_annee = total_commission_annee + b.getTotal_commission();
                                    total_benefice_end_annee = total_benefice_end_annee + (b.getTotal_benefice_brute()-b.getTotal_perte()-b.getTotal_commission());
                                    }
                                    %>
                                    <tr><strong>
                                        <td></td>
                                        <td></td>
                                        <td><%= df.format(total_vente_annee) %></td>
                                        <td><%= df.format(total_achat_annee) %></td>
                                        <td><%= df.format(total_benefice_brute_annee) %></td>
                                        <td style="color: red;"><%= df.format(total_perte_annee) %></td>
                                        <td><%= df.format(total_benefice_annee) %></td>
                                        <td style="color: blue;"><%= df.format(total_commission_annee) %></td>
                                        <td><%= df.format(total_benefice_end_annee) %></td>
                                    </strong></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <%
            }
            %>

            <!-- Ventes -->
            <div class="row">
                <div class="col">
                    <div class="card-header py-3">
                        <p class="text-primary m-0 fw-bold">Sales
                        <%
                        if(msg==null && current_user.getShop().getShop_type().getId()>=2)
                        {
                        %>
                        <form action='<%= request.getContextPath()+"/pdf/sell/"+shop %>' method="get">
                            <input type="hidden" name="year" value=<%= year %> >
                            <input class="btn btn-primary d-block btn-user w-100" type="submit" value="Generate PDF">
                        </form>
                        <%
                        }
                        %>
                        </p>
                    </div>
                    <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                    <table class="table my-0" id="dataTable">
                        <thead>
                            <tr>
                                <th>Shop</th>
                                <th>Date</th>
                                <th>Laptop</th>
                                <th>Nombre</th>
                                <th>Sales</th>
                                <th>Purchases</th>
                                <th>Gross Profit</th>
                                <th>Loss</th>
                                <th>Profit</th>
                                <th>Commission</th>
                                <th>End Profit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            for(int i=0;i<mois.length;i++){
                                vente_mois = 0.0;
                                achat_mois = 0.0;
                                benefice_brute_mois = 0.0;
                                perte_mois = 0.0;
                                benefice_mois = 0.0;
                                commission_mois = 0.0;
                                benefice_end_mois = 0.0;
                                %>
                                <tr>
                                    <th><%= mois[i] %></th>
                                </tr>
                                <%
                                for(V_vente b : ventes){
                                    if(b.getDate().getMonth()==i){
                                    %>
                                    <tr>
                                        <td><%= b.getShop().getLocalisation() %></td>
                                        <td><%= sdf.format(b.getDate()) %></td>
                                        <td><%= b.getLaptop().getReference() %></td>
                                        <td><%= b.getNombre() %></td>
                                        <td><%= df.format(b.getVente()) %></td>
                                        <td><%= df.format(b.getAchat()) %></td>
                                        <td><%= df.format(b.getBenefice_brute()) %></td>
                                        <td style="color: red;"><%= df.format(-1*b.getPerte()) %></td>
                                        <td><%= df.format(b.getBenefice_brute()-b.getPerte()) %></td>
                                        <td style="color: blue;"><%= df.format(b.getCommission()) %></td>
                                        <td><%= df.format(b.getBenefice_brute()-b.getPerte()-b.getCommission()) %></td>
                                    </tr>
                                    <%
                                    vente_mois = vente_mois + b.getVente();
                                    achat_mois = achat_mois + b.getAchat();
                                    benefice_brute_mois = benefice_brute_mois + b.getBenefice_brute();
                                    perte_mois = perte_mois - b.getPerte();
                                    benefice_mois = benefice_mois + (b.getBenefice_brute()-b.getPerte());
                                    commission_mois = commission_mois + b.getCommission();
                                    benefice_end_mois = benefice_end_mois + (b.getBenefice_brute()-b.getPerte()-b.getCommission());
                                    }
                                }
                                %>
                                <tr><strong>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td><%= df.format(vente_mois) %></td>
                                    <td><%= df.format(achat_mois) %></td>
                                    <td><%= df.format(benefice_brute_mois) %></td>
                                    <td style="color: red;"><%= df.format(perte_mois) %></td>
                                    <td><%= df.format(benefice_mois) %></td>
                                    <td style="color: blue;"><%= df.format(commission_mois) %></td>
                                    <td><%= df.format(benefice_end_mois) %></td>
                                </strong></tr>
                                <%
                                total_vente_mois = total_vente_mois + vente_mois;
                                total_achat_mois = total_achat_mois + achat_mois;
                                total_benefice_brute_mois = total_benefice_brute_mois + benefice_brute_mois;
                                total_perte_mois = total_perte_mois + perte_mois;
                                total_benefice_mois = total_benefice_mois + benefice_mois;
                                total_commission_mois = total_commission_mois + commission_mois;
                                total_benefice_end_mois = total_benefice_end_mois + benefice_end_mois;
                            }
                            %>
                            <tr>
                                <th>Total</th>
                            </tr>
                            <tr><strong>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><%= df.format(total_vente_mois) %></td>
                                <td><%= df.format(total_achat_mois) %></td>
                                <td><%= df.format(total_benefice_brute_mois) %></td>
                                <td style="color: red;"><%= df.format(total_perte_mois) %></td>
                                <td><%= df.format(total_benefice_mois) %></td>
                                <td style="color: blue;"><%= df.format(total_commission_mois) %></td>
                                <td><%= df.format(total_benefice_end_mois) %></td>
                            </strong></tr>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    // Récupérer la référence vers l'élément canvas
    const canvas = document.getElementById('evolution-chart');
    
    // Créer un contexte 2D pour le canvas
    const ctx = canvas.getContext('2d');
    
    // Données du diagramme
    const months = [<%
        for (int i = 0; i < mois.length; i++) {
            out.print("'"+mois[i]+"'");
            if (i < mois.length - 1) {
                out.print(", ");
            }
        }
    %>];
    const val = [<%
        for (int i = 0; i < val.length; i++) {
            out.print(val[i]);
            if (i < val.length - 1) {
                out.print(", ");
            }
        }
    %>];
    const data = {
        labels: months,
        datasets: [{
            label: 'Sales evolution',
            data: val,
            backgroundColor: 'rgba(0, 123, 255, 0.5)',
            borderColor: 'rgba(0, 123, 255, 1)',
            borderWidth: 1
        }]
    };
    
    // Options du diagramme
    const options = {
        responsive: true,
        maintainAspectRatio: false
    };
    
    // Créer le diagramme d'évolution
    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });    
</script>