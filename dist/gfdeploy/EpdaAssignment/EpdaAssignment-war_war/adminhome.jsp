<%@page import="model.Enums"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link href="site.css" rel="stylesheet">

        <title>Admin Home | APStore </title>
    </head>
    <%
        // Gets the current session to check if user is logged in
        Enums.LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state != Enums.LoginStateRole.ManagingStaff) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
    %>
    <body>
        <%@include file="/WEB-INF/jspf/managing_navbar.jspf" %>
        <div class="container mt-5 mb-5">
            <h2>Welcome!</h2>
            <div class="mt-4">
                <h5>Overview</h5>
                <div class="row row-cols-1 row-cols-md-5 g-4">
                    <div class="col">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <h5>Available Products</h5>
                                <h1 class="card-title text-end">72</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-danger text-white">
                            <div class="card-body">
                                <h5>Unavailable Products</h5>
                                <h1 class="card-title text-end">72</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <h5>Pending Orders</h5>
                                <h1 class="card-title text-end">72</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <h5>Orders Today</h5>
                                <h1 class="card-title text-end">72</h1>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-secondary text-white">
                            <div class="card-body">
                                <h5>Today's Sale</h5>
                                <h1 class="card-title text-end">MYR 1024</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-4">
                <h5>Quick Actions</h5>
                <div class="row row-cols-1 row-cols-md-5 g-4">
                    <div class="col">
                        <a href="addproduct.jsp">
                            <div class="card border-primary">
                                <div class="card-body">
                                    <i class="bi bi-arrow-right text-success"></i><span class="ms-3">Add New Product</span>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col">
                        <div class="card border-primary">
                            <div class="card-body">
                                <i class="bi bi-arrow-right text-success"></i><span class="ms-3">Add New Staff</span>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card border-primary">
                            <div class="card-body">
                                <i class="bi bi-arrow-right text-success"></i><span class="ms-3">View Orders</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
