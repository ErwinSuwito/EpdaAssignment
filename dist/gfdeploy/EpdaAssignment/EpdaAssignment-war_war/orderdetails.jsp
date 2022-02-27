<%@page import="java.util.List"%>
<%@page import="model.Enums"%>
<%@page import="model.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
    Context context = new InitialContext();
    OrdersFacade ordersFacade = (OrdersFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/OrdersFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link href="site.css" rel="stylesheet">

        <title>Order Details | APStore </title>
    </head>
    <%
        // Gets the current session to check if user is logged in
        Enums.LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == Enums.LoginStateRole.LoggedOut) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (request.getParameter("id") == null) {
            response.sendRedirect("notfound.jsp");
            return;
        }

        Long id = Long.parseLong(request.getParameter("id"));
        Users user = (Users) request.getSession(false).getAttribute("login");
        Orders order = ordersFacade.find(id);
        if (order == null) {
            response.sendRedirect("notfound.jsp");
            return;
        }
    %>
    <body>
        <%@include file="/WEB-INF/jspf/empty_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Order Details</h2>
            <!--<h6></h6>-->
            <div class="row mt-4">
                <%
                    String notice = (String) request.getSession(false).getAttribute("notice");
                    String noticeBg = (String) request.getSession(false).getAttribute("noticeBg");
                    if (notice != null) {
                        out.println("<div class=\"alert alert-" + noticeBg + "\" role=\"alert\">" + notice + "</div>");
                    }
                %>
            </div>
            <div class="row">
                <div class="accordion">
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#statusPanel">
                                <i class="bi bi-box-seam"></i><span class="ms-2">Status</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse show" id="statusPanel">
                            <div class="accordion-body ms-4">
                                <div class="row">
                                    <div class="col-1 d-flex align-items-center ms-1">
                                        <h1><i class="bi bi-hourglass"></i></h1>
                                    </div>
                                    <div class="col">
                                        <h3>
                                            Pending
                                        </h3>
                                        <p>
                                            Lorem ipsum
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#itemsPanel">
                                <i class="bi bi-bag-heart"></i><span class="ms-2">Shopping Bag</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse" id="itemsPanel">
                            <div class="accordion-body ms-4">
                                <table class="table">
                                    <thead>
                                        <th>Product Name</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                    </thead>
                                    <tbody>
                                        <!-- TO-DO: Print each product list here -->
                                    </tbody>
                                </table>
                                Total: RM <!-- TO-DO: Print total price here -->
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#infoPanel">
                                <i class="bi bi-info-circle"></i><span class="ms-2">Order Info</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse" id="infoPanel">
                            <div class="accordion-body ms-4">
                                <div class="row">
                                    <span class="col-3 col-sm-2">Order ID</span>
                                    <span class="col-9 col-sm-10"></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Submitted On</span>
                                    <span class="col-9 col-sm-10"></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Delivery Address</span>
                                    <span class="col-9 col-sm-10"></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Total Amount</span>
                                    <span class="col-9 col-sm-10"></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Delivery By</span>
                                    <span class="col-9 col-sm-10"></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Assigned Delivery On</span>
                                    <span class="col-9 col-sm-10"></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Delivered Time</span>
                                    <span class="col-9 col-sm-10"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%
            // Removes notice and noticeBg from session
            session.removeAttribute("noticeBg");
            session.removeAttribute("notice");
        %>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
