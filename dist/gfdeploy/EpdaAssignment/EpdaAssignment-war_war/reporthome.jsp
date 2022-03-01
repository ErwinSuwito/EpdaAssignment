<%@page import="model.Enums"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link href="site.css" rel="stylesheet">
        <title>Reports | APStore </title>
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
        <div class="container mt-5">
            <h2>Reports</h2>
            <p>Select the type of report to view</p>
            <div class="col-5 mt-4">
                <div class="col mb-3">
                    <a href="addproduct.jsp">
                        <div class="card border-primary">
                            <div class="card-body">
                                <i class="bi bi-arrow-right text-success"></i><span class="ms-3">Monthly Purchases and Revenue</span>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col mb-3">
                    <a href="addproduct.jsp">
                        <div class="card border-primary">
                            <div class="card-body">
                                <i class="bi bi-arrow-right text-success"></i><span class="ms-3">Monthly Delivery Times</span>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col mb-3">
                    <a href="addproduct.jsp">
                        <div class="card border-primary">
                            <div class="card-body">
                                <i class="bi bi-arrow-right text-success"></i><span class="ms-3">Monthly Delivery Workload</span>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col mb-3">
                    <a href="addproduct.jsp">
                        <div class="card border-primary">
                            <div class="card-body">
                                <i class="bi bi-arrow-right text-success"></i><span class="ms-3">Monthly New Products</span>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col mb-3">
                    <a href="addproduct.jsp">
                        <div class="card border-primary">
                            <div class="card-body">
                                <i class="bi bi-arrow-right text-success"></i><span class="ms-3">Monthly New Customers</span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/dataTables.bootstrap5.min.js"></script>
    </body>
</html>
