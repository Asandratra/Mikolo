<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    Profile profile = (Profile) request.getAttribute("profile");
    ArrayList<Shop> shops = (ArrayList) request.getAttribute("shops");
%>
<div class="container-fluid">
    <h3 class="text-dark mb-4">Profile</h3>
    <div class="row mb-3">
        <div class="col-lg-4">
            <div class="card mb-3">
                <div class="card-body text-center shadow">
                    <p>Username : <strong><%= profile.getUsername() %></strong></p>
                    <p>Email : <strong><%= profile.getEmail() %></strong> </p>
                    <p>Shop : <strong><%= profile.getShop().getLocalisation() %></strong></p>
                </div>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="row">
                <div class="col">
                    <div class="card shadow mb-3">
                        <div class="card-header py-3">
                            <p class="text-primary m-0 fw-bold">Profile settings</p>
                        </div>
                        <p id="error" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                        <div class="card-body">
                            <form id="form">
                                <div class="row">
                                    <input type="hidden" class="id" value="<%= profile.getId() %>">
                                    <input type="hidden" class="password" value="<%= profile.getPassword() %>">
                                    <div class="col">
                                        <div class="mb-3"><label class="form-label" for="username"><strong>Username</strong></label><input class="username form-control" type="text" id="username" value="<%= profile.getUsername() %>" name="username" readonly></div>
                                    </div>
                                    <div class="col">
                                        <div class="mb-3"><label class="form-label" for="email"><strong>Email Address</strong></label><input class="email form-control" type="email" id="email" value="<%= profile.getEmail() %>" name="email" readonly></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="mb-3"><label class="form-label" for="email"><strong>Shop</strong></label>
                                            <select class="shop form-control" name="shop">
                                                <%
                                                for(Shop b : shops){
                                                %><option value=<%= b.getId() %>><%= b.getLocalisation() %></option><%
                                                }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3"><input class="btn btn-primary btn-sm" type="submit" value="Change Settings"></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    const urlredirect = '<%= request.getContextPath()+"/details/profile/"+profile.getId() %>';
    const url = '<%= request.getContextPath()+"/update/profile" %>';
    const formulaire = document.getElementById('form');

    formulaire.addEventListener('submit', function (event) {
        event.preventDefault(); // Empêche le formulaire d'être soumis
        document.getElementById("error").innerHTML = "";
        const id = Array.from(document.getElementsByClassName("id")).map(option => option.value);
        const username = Array.from(document.getElementsByClassName("username")).map(option => option.value);
        const email = Array.from(document.getElementsByClassName("email")).map(option => option.value);
        const password = Array.from(document.getElementsByClassName("password")).map(option => option.value);
        const shop = Array.from(document.getElementsByClassName("shop")).map(option => option.value);


        //alert("Submit pressed");
        const data = {
                "id": parseInt(id[0]),
                "username":username[0],
                "email":email[0],
                "password":password[0],
                "shop": {"id":parseInt(shop[0])}
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