<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility,java.text.*" %>
<%

    DecimalFormat df = new DecimalFormat("#,###.##");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    Profile current_user = null;
    if(session.getAttribute("user")!=null) current_user = (Profile) session.getAttribute("user");
    Laptop laptop = (Laptop) request.getAttribute("laptop");
    ArrayList<Shop> shops = (ArrayList) request.getAttribute("shops");
    ArrayList<V_transaction> transactions = (ArrayList) request.getAttribute("transactions");
    ArrayList<Stock_change> stock_changes = (ArrayList) request.getAttribute("stock_changes");
    V_stock local_stock = (V_stock) request.getAttribute("local_stock");
    V_stock central_stock = (V_stock) request.getAttribute("central_stock");
    V_transaction perte_stock = (V_transaction) request.getAttribute("perte_stock");
%>
<div class="container-fluid">
    <h3 class="text-dark mb-4">Details Laptop</h3>
    <div class="row mb-3">
        <div class="col-lg-4">
            <div class="card mb-3">
                <div class="card-body text-center shadow">
                    <p>Name : <strong><%= laptop.getName() %></strong></p>
                    <p>Reference : <strong><%= laptop.getReference() %></strong></p>
                    <p>In stock : <strong><%= local_stock.getStock_in()-local_stock.getStock_out() %></strong></p>
                    <%
                    if(perte_stock!=null&& perte_stock.getN_laptop()>0){
                        %><p style="color: red;">Lost : <%= perte_stock.getN_laptop() %></p><%
                    }
                    %>
                    <p></p>
                    <p>U.P : <strong><%= df.format(laptop.getPrice()) %></strong></p>
                    <p>Value : <strong><%= df.format((local_stock.getStock_in()-local_stock.getStock_out())*(laptop.getPrice())) %></strong></p>
                </div>
            </div>
            <div class="card shadow mb-4">

                <div class="row" <% if(current_user.getShop().getShop_type().getId()<2) out.print("hidden"); %> >
                    <div class="col">
                        <div class="card shadow mb-3">
                            <div class="card-header py-3">
                                <p class="text-primary m-0 fw-bold">New Arrival</p>
                            </div>
                            <p id="error1" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                            <div class="card-body">
                                <form id="form_achat">
                                    <div class="row">
                                        <input type="hidden" class="id_shop" value="<%= current_user.getShop().getId() %>">
                                        <input type="hidden" class="id_laptop" value="<%= laptop.getId() %>">
                                        <div class="col">
                                            <div class="mb-3"><label class="form-label" for="date"><strong>Date</strong></label><input class="date form-control" type="date" id="date" value="<%= new Date().toString() %>" name="date" required></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="mb-3"><label class="form-label" for="number"><strong>Quantity</strong></label><input class="quantity form-control" type="number" min="0" id="quantity" value="0" name="quantity" required></div>
                                        <div class="mb-3"><label class="form-label" for="number"><strong>Unit Price</strong></label><input class="price form-control" type="number" min="0" id="quantity" value="<%= laptop.getPrice() %>" name="quantity" required></div>
                                    </div>
                                    <div class="mb-3"><input class="btn btn-primary btn-sm" type="submit" value="Save Arrival"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row" <% if(current_user.getShop().getShop_type().getId()>=2) out.print("hidden"); %> >
                    <div class="col">
                        <div class="card shadow mb-3">
                            <div class="card-header py-3">
                                <p class="text-primary m-0 fw-bold">Selling</p>
                            </div>
                            <p id="error3" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                            <div class="card-body">
                                <form id="form_sell">
                                    <div class="row">
                                        <input type="hidden" class="sell_id_shop" value="<%= current_user.getShop().getId() %>">
                                        <input type="hidden" class="sell_id_laptop" value="<%= laptop.getId() %>">
                                        <div class="col">
                                            <div class="mb-3"><label class="form-label" for="date"><strong>Date</strong></label><input class="sell_date form-control" type="date" id="date" value="<%= new Date().toString() %>" name="date" required></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="mb-3"><label class="form-label" for="number"><strong>Quantity</strong></label><input class="sell_quantity form-control" type="number" min="0" max="<%= local_stock.getStock_in()-local_stock.getStock_out() %>" id="quantity" value="0" name="quantity" required></div>
                                        <div class="mb-3"><label class="form-label" for="number"><strong>Unit Price</strong></label><input class="sell_price form-control" type="number" min="0" id="quantity" value="<%= laptop.getPrice() %>" name="quantity" readonly></div>
                                    </div>
                                    <div class="mb-3"><input class="btn btn-primary btn-sm" type="submit" value="Sell"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="card shadow mb-3">
                            <div class="card-header py-3">
                                <p class="text-primary m-0 fw-bold">Transfer request</p>
                            </div>
                            <p id="error2" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                            <div class="card-body">
                                <form id="form_transaction">
                                    <div class="row">
                                        <input type="hidden" class="id_from" value="<%= current_user.getShop().getId() %>">
                                        <input type="hidden" class="id_laptop" value="<%= laptop.getId() %>">
                                        <div class="col">
                                            <div class="mb-3"><label class="form-label" for="number"><strong>Quantity</strong></label><input class="n_laptop form-control" type="number" min="0" max="<%= local_stock.getStock_in()-local_stock.getStock_out() %>" id="quantity" value="0" name="quantity" required></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <div class="mb-3"><label class="form-label" for="date"><strong>Date</strong></label><input class="transfer_date form-control" type="date" id="date" value="<%= new Date().toString() %>" name="date" required></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <%
                                            if(current_user.getShop().getShop_type().getId()>=2) {
                                            %>
                                            <div class="mb-3"><label class="form-label" for="email"><strong>Shop</strong></label>
                                                <select class="id_to form-control" name="shop" >
                                                    <%
                                                    for(Shop b : shops){
                                                        if( b.getId()!=1) {
                                                            %><option value=<%= b.getId() %>><%= b.getLocalisation() %></option><%
                                                        }
                                                    }
                                                    %>
                                                </select>
                                            </div>
                                            <% }
                                            else { 
                                            %>
                                                <input type="hidden" class="id_to" value=1>
                                            <% } %>
                                        </div>
                                    </div>
                                    <div class="mb-3"><input class="btn btn-primary btn-sm" type="submit" value="Send"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card col-lg-8">
            <div class="row">
            <div class="col">
            <%
            if(transactions!=null && transactions.size()>0) {
            %>
            <div class="card-header py-3">
                <p class="text-primary m-0 fw-bold">Transactions</p>
            </div>
            <div class="card-body table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                <table class="table my-0" id="dataTable">
                    <thead>
                        <tr>
                            <th>From</th>
                            <th>Date</th>
                            <th>Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for(V_transaction b : transactions){
                        %>
                        <tr>
                            <td><%= b.getShop_from().getLocalisation() %></td>
                            <td><%= b.getDate() %></td>
                            <td><%= b.getN_laptop() %></td>
                            <td><a href='<%= request.getContextPath()+"/form/reception/"+b.getId() %>'><button class="btn btn-primary d-block btn-user w-100">Receive</button></a></td>
                            <td><a href='<%= request.getContextPath()+"/confirm/transaction/"+laptop.getId()+"/"+b.getId() %>'><button class="btn btn-primary d-block btn-user w-100">End</button></a></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <%
            }
            %>
            <%
            if(stock_changes!=null && stock_changes.size()>0) {
            %>
            <div class="card-header py-3">
                <p class="text-primary m-0 fw-bold">Stock History</p>
            </div>
            <div class="card-body table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                <table class="table my-0" id="dataTable">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>IN</th>
                            <th>OUT</th>
                            <th>Value</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for(Stock_change b : stock_changes){
                        %>
                        <tr>
                            <td><%= sdf.format(b.getDate()) %></td>
                            <td><%= b.getStock_in() %></td>
                            <td><%= b.getStock_out() %></td>
                            <td><%= df.format(b.getValue()) %></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <%
            }
            %>
            </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    const urlredirect = '<%= request.getContextPath()+"/details/laptop/"+laptop.getId() %>';

    const url1 = '<%= request.getContextPath()+"/save/stock" %>';
    const formulaire1 = document.getElementById('form_achat');

    const url2 = '<%= request.getContextPath()+"/save/transaction" %>';
    const formulaire2 = document.getElementById('form_transaction');

    const url3 = '<%= request.getContextPath()+"/save/stock" %>';
    const formulaire3 = document.getElementById('form_sell');

    formulaire1.addEventListener('submit', function (event) {
        event.preventDefault(); // Empêche le formulaire d'être soumis
        document.getElementById("error1").innerHTML = "";
        const id_shop = Array.from(document.getElementsByClassName("id_from")).map(option => option.value);
        const id_laptop = Array.from(document.getElementsByClassName("id_laptop")).map(option => option.value);
        const date = Array.from(document.getElementsByClassName("date")).map(option => option.value);
        const quantity = Array.from(document.getElementsByClassName("quantity")).map(option => option.value);
        const price = Array.from(document.getElementsByClassName("price")).map(option => option.value);


        //alert("Submit pressed");
        const data = {
                "shop":{"id":id_shop[0]},
                "laptop": {"id":id_laptop[0]},
                "date": date[0],
                "stock_in": quantity[0],
                "stock_out": 0,
                "value": price[0]
        }
        $.ajax({
            url: url1,
            type: 'POST',
            data: JSON.stringify(data),
            dataType: 'json',
            contentType: 'application/json',
            success: function (response) {
                    //console.log(response);
                    window.location.href = urlredirect1;
            },
            error: function (xhr, status, error) {
                    console.log(xhr);
                    if (xhr.status == 200 || xhr.status == "200") {
                        alert("Stock saved");
                        window.location.href = urlredirect;
                    }
                    else {
                        console.log(xhr.responseText);
                        document.getElementById("error1").innerHTML = xhr.responseText;
                    }
            }
        });
    });

    formulaire2.addEventListener('submit', function (event) {
        event.preventDefault(); // Empêche le formulaire d'être soumis
        document.getElementById("error2").innerHTML = "";
        const id_from = Array.from(document.getElementsByClassName("id_from")).map(option => option.value);
        const id_to = Array.from(document.getElementsByClassName("id_to")).map(option => option.value);
        const id_laptop = Array.from(document.getElementsByClassName("id_laptop")).map(option => option.value);
        const n_laptop = Array.from(document.getElementsByClassName("n_laptop")).map(option => option.value);
        const date = Array.from(document.getElementsByClassName("transfer_date")).map(option => option.value);


        //alert("Submit pressed");
        const data = {
                "shop_from":{"id":id_from[0]},
                "shop_to":{"id":id_to[0]},
                "laptop":{"id":id_laptop[0]},
                "date": date[0],
                "n_laptop": n_laptop[0],
                "confirmed": 0
        }
        $.ajax({
            url: url2,
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
                        alert("Transaction sent");
                        window.location.href = urlredirect;
                    }
                    else {
                        console.log(xhr.responseText);
                        document.getElementById("error2").innerHTML = xhr.responseText;
                    }
            }
        });
    });
    
    formulaire3.addEventListener('submit', function (event) {
        event.preventDefault(); // Empêche le formulaire d'être soumis
        document.getElementById("error3").innerHTML = "";
        const sid_shop = Array.from(document.getElementsByClassName("sell_id_shop")).map(option => option.value);
        const sid_laptop = Array.from(document.getElementsByClassName("sell_id_laptop")).map(option => option.value);
        const sdate = Array.from(document.getElementsByClassName("sell_date")).map(option => option.value);
        const squantity = Array.from(document.getElementsByClassName("sell_quantity")).map(option => option.value);
        const sprice = Array.from(document.getElementsByClassName("sell_price")).map(option => option.value);
        console.log(sid_shop);
        console.log(sid_laptop);
        console.log(sdate);
        console.log(squantity);
        console.log(sprice);


        //alert("Submit pressed");
        const data = {
                "shop":{"id":sid_shop[0]},
                "laptop": {"id":sid_laptop[0]},
                "date": sdate[0],
                "stock_in": 0,
                "stock_out": squantity[0],
                "value": sprice[0]
        }
        $.ajax({
            url: url3,
            type: 'POST',
            data: JSON.stringify(data),
            dataType: 'json',
            contentType: 'application/json',
            success: function (response) {
                    //console.log(response);
                    window.location.href = urlredirect1;
            },
            error: function (xhr, status, error) {
                    console.log(xhr);
                    if (xhr.status == 200 || xhr.status == "200") {
                        alert("Sell saved");
                        window.location.href = urlredirect;
                    }
                    else {
                        console.log(xhr.responseText);
                        document.getElementById("error3").innerHTML = xhr.responseText;
                    }
            }
        });
    });

</script>