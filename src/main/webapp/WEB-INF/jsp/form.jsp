                <div class="container-fluid">
                    <div class="card shadow-lg o-hidden border-0 my-5">
                        <div class="card-body p-0">
                            <div class="p-5">
                                <div class="text-center">
                                    <h4 class="text-dark mb-4">Adding something</h4>
                                </div>
                                <p style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                                <form id="form" class="user">
                                    <div class="row mb-3">
                                        <div class="col-sm-6 mb-3 mb-sm-0"><input class="form-control form-control-user" type="text" id="exampleFirstName-1" placeholder="First Name" name="first_name"></div>
                                        <div class="col-sm-6"><input class="form-control form-control-user" type="text" id="exampleFirstName-2" placeholder="Last Name" name="last_name"></div>
                                    </div>
                                    <div class="mb-3"><input class="form-control form-control-user" type="email" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Email Address" name="email"></div>
                                    <div class="row mb-3">
                                        <div class="col-sm-6 mb-3 mb-sm-0"><input class="form-control form-control-user" type="password" id="examplePasswordInput" placeholder="Password" name="password"></div>
                                        <div class="col-sm-6"><input class="form-control form-control-user" type="password" id="exampleRepeatPasswordInput" placeholder="Repeat Password" name="password_repeat"></div>
                                    </div>
                                    <div class="row mb-3">

                                    </div>
                                    <div class="mb-3">
                                        <select class="form-control form-control-user" id="select" aria-describedby="emailHelp" name="select">
                                            <option value="1">1</option>
                                            <option value="1">2</option>
                                            <option value="1">3</option>
                                        </select>
                                    </div>
                                    <div class="row" style="margin: 0px -12px;">
                                        <div class="col">
                                            <div style="width: 180px;margin: 0px 30%;"><a href=""><button class="btn btn-primary d-block btn-user w-100" style="background: var(--bs-red);">Cancel</button></a></div>
                                        </div>
                                        <div class="col">
                                            <div class="text-end d-xl-flex justify-content-xl-end" style="width: 180px;margin: 0px 30%;"><button class="btn btn-primary d-block btn-user w-100" type="submit" style="width: 825.6px;">Add</button></div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Image En Base 64 -->
                <script type="text/javascript">
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
                </script>

                <script type="text/javascript">
                 const urlredirect = '<%= request.getContextPath()+"/nextPageOnSuccess" %>';
                 const url = '<%= request.getContextPath()+"/restFunction" %>';
                 const formulaire = document.getElementById('form');
            
                 formulaire.addEventListener('submit', function (event) {
                      event.preventDefault(); // Empêche le formulaire d'être soumis
                      const name = Array.from(document.getElementsByClassName("username")).map(option => option.value);
                      const password = Array.from(document.getElementsByClassName("password")).map(option => option.value);
                      console.log(name);
                      console.log(password);
            
                      //alert("Submit pressed");
                      const data = {
                           "username": name[0],
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
                 });
                </script>