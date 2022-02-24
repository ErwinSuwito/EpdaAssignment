<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <title>Register | APStore </title>
    
    <style>
        body {
            background: url('https://source.unsplash.com/random/1920x1080/?background') no-repeat center center fixed;
            background-size: cover;
        }
    </style>
  </head>
  <body>
      <div class="container">
          </div>
          <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
              <div class="card border-0 shadow rounded-3 my-5">
                  <div class="card-body p-4 p-sm-5">
                      <h3 class="card-title text-center">APStore</h3>
                      <h5 class="card-title text-center mb-5">Create an Account</h5>
                      <%
                              String notice = (String)request.getSession(false).getAttribute("notice");
                              String noticeBg = (String)request.getSession(false).getAttribute("noticeBg");
                              if (notice != null) {
                                  out.println("<div class=\"alert alert-" + "noticeBg" + "\" role=\"alert\">" + notice + "</div>");
                              }
                      %>
                      <form action="AddCustomer" method="POST">
                          <div class="form-floating mb-3">
                              <input type="text" class="form-control" name="name" id="name" placeholder="John Doe" required>
                              <label for="name">Full Name</label>
                          </div>
                          <div class="form-floating mb-3">
                              <input type="email" class="form-control" name="email" id="email" placeholder="someone@something.com" required>
                              <label for="email">Email address</label>
                          </div>
                          <div class="form-floating mb-3">
                              <input type="password" class="form-control" name="password1" id="password1" placeholder="Password" required>
                              <label for="password2">Password</label>
                          </div>
                          <div class="form-floating mb-3">
                              <input type="password" class="form-control" name="password2" id="password2" placeholder="Password" required>
                              <label for="password2">Password</label>
                          </div>
                          <div class="form-floating mb-3">
                              <input type="text" class="form-control" name="phoneNumber" id="phoneNumber" placeholder="012-12342234" required>
                              <label for="phone">Phone Number</label>
                          </div>
                          <div class="vstack gap-2 mx-auto">
                              <button class="btn btn-primary text-uppercase fw-bold" value="Register" type="submit">Create Account</button>
                          </div>
                      </form>
                  </div>
              </div>
          </div>
      </div>

      <%
          // Invalidate sessions to remove notice
          request.getSession(false).invalidate();
      %>
      
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  </body>
</html>