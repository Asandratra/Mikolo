<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*,app.apps.model.*,app.apps.service.Utility" %>
<%
    ArrayList<Shop> shops = (ArrayList) request.getAttribute("shops");
%>
<div class="container-fluid">
    <div class="card shadow-lg o-hidden border-0 my-5">
        <div class="card-body p-0">
            <div class="p-5">
                <div class="text-center">
                    <h4 class="text-dark mb-4">New profile</h4>
                </div>
                <p id="error" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                <form id="form" class="user">
                    <div class="mb-3">Username<br/><input class="username form-control form-control-user" type="text" id="InputText" placeholder="Username" name="username" required></div>
                        <div class="mb-3">Email<br/><input class="email form-control form-control-user" type="email" id="InputEmail" aria-describedby="emailHelp" placeholder="Email Address" name="email" required></div>
                        <div class="row mb-3">
                            <div class="col-sm-6 mb-3 mb-sm-0">Password<br/><input class="password form-control form-control-user" type="password" id="PasswordInput" placeholder="Password" name="password" required></div>
                            <div class="col-sm-6">Confirm password<br/><input class="confirm-password form-control form-control-user" type="password" id="RepeatPasswordInput" placeholder="Repeat Password" name="password_repeat" required></div>
                        </div>
                        <div class="mb-3">
                            Shop<br/>
                            <select class="shop form-control form-control-user" name="shop">
                                <%
                                for(Shop b : shops){
                                %><option value=<%= b.getId() %>><%= b.getLocalisation() %></option><%
                                }
                                %>
                            </select>
                        </div>
                    <div class="row" style="margin: 0px -12px;">
                        <div class="col">
                        </div>
                        <div class="col">
                            <div class="text-end d-xl-flex justify-content-xl-end" style="width: 180px;margin: 0px 30%;"><button class="btn btn-primary d-block btn-user w-100" type="submit" style="width: 825.6px;">Add</button></div>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Image En Base 64 -->
<!-- <script type="text/javascript">
    const input = document.getElementById("selectimage");
    const hidden = document.getElementById("upload");
    const convertBase64 = (file) => {
        return new Promise((resolve,reject) => {
            const fileReader = new FileReader();
            fileReader.readAsDataURL(file);

            fileReader.onload = () => {
                resolve(fileReader.result);
            };

            fileReader.onerror = (error) => {
                reject(error);
            };
        });
    };
    const uploadImage = async (event) => {
        const file = event.target.files[0];
        const base64 = await convertBase64(file);
        hidden.value = base64;
        console.log(hidden.value);
    };
    input.addEventListener("change", (e) => {
        uploadImage(e);
    });
</script> -->

<script type="text/javascript">
    const urlredirect = '<%= request.getContextPath()+"/table/profile/1" %>';
    const url = '<%= request.getContextPath()+"/save/profile" %>';
    const formulaire = document.getElementById('form');

    formulaire.addEventListener('submit', function (event) {
        event.preventDefault(); // Empêche le formulaire d'être soumis
        document.getElementById("error").innerHTML = "";
        const name = Array.from(document.getElementsByClassName("username")).map(option => option.value);
        const email = Array.from(document.getElementsByClassName("email")).map(option => option.value);
        const password = Array.from(document.getElementsByClassName("password")).map(option => option.value);
        const confirmpassword = Array.from(document.getElementsByClassName("confirm-password")).map(option => option.value);
        const shop = Array.from(document.getElementsByClassName("shop")).map(option => option.value);

    if(password[0]!=confirmpassword[0]){
        document.getElementById("error").innerHTML = "Password is not confirmed, please check";
    }

        //alert("Submit pressed");
    else{
        const data = {
                "username": name[0],
                "email": email[0],
                "password": password[0],
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
    }
    });
</script>