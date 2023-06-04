<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/fonts/fontawesome-all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/fonts/fontawesome5-overrides.min.css">
</head>

<body class="bg-gradient-primary" style="margin: 0% 12.5%;">
    <div class="container">
        <div class="card shadow-lg o-hidden border-0 my-5">
            <div class="card-body p-0">
                <div class="p-5">
                    <div class="text-center">
                        <h4 class="text-dark mb-4">Register</h4>
                        <p id="error" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                    </div>
                    <form id="register" class="user">
                        <div class="mb-3">Username<br/><input class="username form-control form-control-user" type="text" id="InputText" placeholder="Username" name="username"></div>
                        <div class="mb-3">Email<br/><input class="email form-control form-control-user" type="email" id="InputEmail" aria-describedby="emailHelp" placeholder="Email Address" name="email"></div>
                        <div class="row mb-3">
                            <div class="col-sm-6 mb-3 mb-sm-0">Password<br/><input class="password form-control form-control-user" type="password" id="PasswordInput" placeholder="Password" name="password"></div>
                            <div class="col-sm-6">Confirm password<br/><input class="confirm-password form-control form-control-user" type="password" id="RepeatPasswordInput" placeholder="Repeat Password" name="password_repeat"></div>
                        </div>
                        <button class="btn btn-primary d-block btn-user w-100" type="submit">Register Account</button>
                        <hr>
                    </form>
                    <div class="text-center"><a class="small" href='<%= request.getContextPath()+"/" %>'>Sign in</a></div>
                </div>
            </div>
        </div>
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
    <script type="text/javascript">
         const urlredirect = '<%= request.getContextPath()+"/" %>';
         const url = '<%= request.getContextPath()+"/registration" %>';
         const formulaire = document.getElementById('register');

         formulaire.addEventListener('submit', function (event) {
              event.preventDefault(); // Empêche le formulaire d'être soumis
              document.getElementById("error").innerHTML = "";
              const name = Array.from(document.getElementsByClassName("username")).map(option => option.value);
              const email = Array.from(document.getElementsByClassName("email")).map(option => option.value);
              const password = Array.from(document.getElementsByClassName("password")).map(option => option.value);
              const confirmpassword = Array.from(document.getElementsByClassName("confirm-password")).map(option => option.value);

            if(password[0]!=confirmpassword[0]){
                document.getElementById("error").innerHTML = "Password is not confirmed, please check";
            }

              //alert("Submit pressed");
            else{
                const data = {
                        "username": name[0],
                        "email": email[0],
                        "password": password[0]
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
</body>

</html>