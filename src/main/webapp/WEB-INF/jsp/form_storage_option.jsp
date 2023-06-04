<div class="container-fluid">
    <div class="card shadow-lg o-hidden border-0 my-5">
        <div class="card-body p-0">
            <div class="p-5">
                <div class="text-center">
                    <h4 class="text-dark mb-4">New SSD Option</h4>
                </div>
                <p id="error" style="text-align: center;color: rgb(255,0,0);background: rgb(255,216,216);"></p>
                <form id="form" class="user">
                    <div class="row mb-3">
                        <div class="col-sm-6 mb-3 mb-sm-0">Name<br/><input class="storage_optionname form-control form-control-user" type="text" min="0" id="freq" placeholder="Name" name="name" required></div>
                        <div class="col-sm-6">Capacity<br/><input class="capacity form-control form-control-user" type="number" id="exampleFirstName-2" min="0" placeholder="Capacity" name="capacity" required></div>
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
 const urlredirect = '<%= request.getContextPath()+"/table/storage_option/1" %>';
 const url = '<%= request.getContextPath()+"/save/storage_option" %>';
 const formulaire = document.getElementById('form');

 formulaire.addEventListener('submit', function (event) {
      event.preventDefault(); // Empêche le formulaire d'être soumis
      const name = Array.from(document.getElementsByClassName("storage_optionname")).map(option => option.value);
      const cap = Array.from(document.getElementsByClassName("capacity")).map(option => option.value);
      console.log(name);
      console.log(cap);

      //alert("Submit pressed");
      const data = {
           "name": name[0],
           "capacity":cap[0]
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