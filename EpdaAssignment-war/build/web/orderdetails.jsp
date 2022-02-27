<%@page import="model.Enums.LoginStateRole"%>
<%@page import="model.Enums.OrderStatus"%>
<%@page import="java.time.LocalDateTime"%>
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
        LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == LoginStateRole.LoggedOut) {
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
        
        if ((state == LoginStateRole.Customer && !order.getCustomer().getId().equals(user.getId())) || 
                (state == LoginStateRole.DeliveryStaff && !order.getDeliveryStaff().getId().equals(user.getId()))) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
    %>
    <body>
        <%@include file="/WEB-INF/jspf/empty_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Order Details</h2>
            <h6><% out.print(order.getId()); %></h6>
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
                                        <h1>
                                            <i class="bi <%
                                                switch (order.getStatus()) {
                                                    case Pending:
                                                        out.print("bi-hourglass");
                                                        break;

                                                    case Assigned:
                                                        out.print("bi-bi-box-seam");
                                                        break;

                                                    case Delivering:
                                                        out.print("bi-bi-truck");
                                                        break;

                                                    case Delivered:
                                                        out.print("bi-bi-check2");
                                                        break;
                                                };
                                               %>"></i>
                                        </h1>
                                    </div>
                                    <div class="col">
                                        <h3>
                                            <% out.print(order.getStatus()); %>
                                        </h3>
                                        <p>
                                            <%
                                                switch (order.getStatus()) {
                                                    case Pending:
                                                        out.print("Order submitted on " + order.getSubmittedTime().toString());
                                                        break;

                                                    case Assigned:
                                                        out.print("Your order is assigned to " + order.getDeliveryStaff().getName() + " on " + order.getAssignedTime().toString());
                                                        break;

                                                    case Delivering:
                                                        out.print("Your order is on the way");
                                                        break;

                                                    case Delivered:
                                                        out.print("Your order is delivered on " + order.getDeliveredTime().toString());
                                                        break;
                                                };
                                            %>
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
                                        <%
                                            for (OrderProduct orderProduct : order.getProductBasket()) {
                                                out.println("<tr>");
                                                out.println("<td>" + orderProduct.getProduct().getProductName() + "</td>");
                                                out.println("<td>" + orderProduct.getQuantityPurchased() + "</td>");
                                                out.println("<td>RM " + orderProduct.getProduct().getPrice() + "</td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
                                Total: RM <% out.print(order.getTotalAmount()); %>
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
                                    <span class="col-9 col-sm-10"><% out.print(order.getId()); %></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Submitted On</span>
                                    <span class="col-9 col-sm-10"><% out.print(order.getSubmittedTime().toString()); %></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Delivery Address</span>
                                    <span class="col-9 col-sm-10"><% out.print(order.getAddress()); %></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Total Amount</span>
                                    <span class="col-9 col-sm-10"><% out.print(order.getTotalAmount()); %></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Delivery By</span>
                                    <span class="col-9 col-sm-10">
                                        <%
                                            if (order.getDeliveryStaff() == null) {
                                                out.print("Not assigned yet");
                                            } else {
                                                out.print(order.getDeliveryStaff().getName());
                                            }
                                        %>
                                    </span>
                                    <span class="col-9 col-sm-10"><% out.print(order.getDeliveryStaff().getName()); %></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Assigned Delivery On</span>
                                    <span class="col-9 col-sm-10">
                                        <%
                                            if (order.getAssignedTime() == LocalDateTime.MIN) {
                                                out.print(" - ");
                                            } else {
                                                out.print(order.getAssignedTime().toString());
                                            }
                                        %>
                                    </span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Delivered Time</span>
                                    <span class="col-9 col-sm-10">
                                        <%
                                            if (order.getDeliveredTime() == LocalDateTime.MIN) {
                                                out.print(" - ");
                                            } else {
                                                out.print(order.getAssignedTime().toString());
                                            }
                                        %>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#actionsPanel">
                                <i class="bi bi-gear"></i><span class="ms-2">Available Actions</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse" id="actionsPanel">
                            <div class="accordion-body ms-4">
                                <%
                                    if (user.getRole() == LoginStateRole.ManagingStaff) {
                                        if (order.getStatus() == OrderStatus.Pending || order.getStatus() == OrderStatus.Assigned) {
                                            out.println("<span class=\"btn btn-warning btn-sm\"><a href=\"assigndelivery.jsp?id=" + order.getId() + "\">Assign Delivery</a></span>");
                                        }
                                    }

                                    if (user.getRole() == LoginStateRole.Customer) {
                                        if (order.getStatus() == OrderStatus.Pending || order.getStatus() == OrderStatus.Assigned) {
                                            out.println("<span class=\"btn btn-danger btn-sm\"><a href=\"cancelorder.jsp?id=" + order.getId() + "\">Cancel Order</a></span>");
                                        }
                                        
                                        if (order.getStatus() == OrderStatus.Delivered) {
                                            out.println("<span class=\"btn btn-danger btn-sm\"><a href=\"submitrateandfeedback.jsp?id=" + order.getId() + "\">Cancel Order</a></span>");
                                        }
                                    }

                                    if (user.getRole() == LoginStateRole.DeliveryStaff) {
                                        out.println("<span class=\"btn btn-danger btn-sm\"><a href=\"updatestatus.jsp?id=" + order.getId() + "\">Update Status</a></span>");
                                    }
                                %>
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
