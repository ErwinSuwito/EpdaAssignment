<%@page import="model.Enums.OrderStatus"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Enums"%>
<%@page import="model.UsersFacade"%>
<%@page import="model.Users"%>
<%@page import="model.OrdersFacade"%>
<%@page import="model.Orders"%>
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

        <title>My Profile | APStore </title>
    </head>
    <%
        // Gets the current session to check if user is logged in
        Enums.LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == Enums.LoginStateRole.LoggedOut) {
            response.sendRedirect("login.jsp");
            return;
        }

        Users user = (Users) request.getSession(false).getAttribute("login");
    %>
    <body>
        <%@include file="/WEB-INF/jspf/customer_navbar.jspf" %>
        <div class="container mt-5 mb-5">
            <h2><% out.print(user.getName()); %></h2>
            <h6><% out.print(user.getRole()); %></h6>
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
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#profilePanel">
                                <i class="bi bi-person-circle"></i><span class="ms-2">Profile</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse show" id="profilePanel">
                            <div class="accordion-body ms-4">
                                <div class="row">
                                    <span class="col-3 col-sm-2">Full Name</span>
                                    <span class="col-9 col-sm-10"><% out.print(user.getName()); %></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Email</span>
                                    <span class="col-9 col-sm-10"><% out.print(user.getEmail()); %></span>
                                </div>
                                <div class="row">
                                    <span class="col-3 col-sm-2">Phone Number</span>
                                    <span class="col-9 col-sm-10"><% out.print(user.getPhoneNumber()); %></span>
                                </div>
                                <div class="d-grid gap-2 d-md-block mt-3 mb-2">
                                    <a href="updatecustomerprofile.jsp">
                                        <button class="btn btn-primary btn-sm">
                                            <i class="bi bi-pencil"></i>
                                            <span class="">Update Profile</span>
                                        </button>
                                    </a>
                                    <a href="changepassword.jsp">
                                        <button class="btn btn-warning btn-sm">
                                            <i class="bi bi-key"></i>
                                            <span class="">Change Password</span>
                                        </button>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pendingOrders">
                                <i class="bi bi-cart"></i><span class="ms-2">Pending Orders</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse" id="pendingOrders">
                            <div class="accordion-body ms-4">
                                <table class="table">
                                    <thead>
                                    <th>Order ID</th>
                                    <th>Ordered Date</th>
                                    <th>Amount</th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Orders> pendingOrders = ordersFacade.getCustomerOrdersFilteredByStatus(user, OrderStatus.Pending);
                                            for (Orders order : pendingOrders) {
                                                out.println("<tr>");
                                                out.println("<td>" + order.getId() + "</td>");
                                                out.println("<td>" + order.getSubmittedTime() + "</td>");
                                                out.println("<td>" + order.getTotalAmount() + "</td>");
                                                out.println("<td><a href=\"vieworderdetails.jsp?id=" + order.getId() + "\"><span class=\"btn btn-sm btn-primary\">View Details</span></a></td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#assignedOrders">
                                <i class="bi bi-cart"></i><span class="ms-2">Assigned Orders</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse" id="assignedOrders">
                            <div class="accordion-body ms-4">
                                <table class="table">
                                    <thead>
                                    <th>Order ID</th>
                                    <th>Ordered Date</th>
                                    <th>Amount</th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Orders> assignedOrders = ordersFacade.getCustomerOrdersFilteredByStatus(user, OrderStatus.Assigned);
                                            for (Orders order : assignedOrders) {
                                                out.println("<tr>");
                                                out.println("<td>" + order.getId() + "</td>");
                                                out.println("<td>" + order.getSubmittedTime() + "</td>");
                                                out.println("<td>" + order.getTotalAmount() + "</td>");
                                                out.println("<td><a href=\"vieworderdetails.jsp?id=" + order.getId() + "\"><span class=\"btn btn-sm btn-primary\">View Details</span></a></td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#deliveringOrders">
                                <i class="bi bi-cart"></i><span class="ms-2">Delivering Orders</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse" id="deliveringOrders">
                            <div class="accordion-body ms-4">
                                <table class="table">
                                    <thead>
                                    <th>Order ID</th>
                                    <th>Ordered Date</th>
                                    <th>Amount</th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Orders> deliveringOrders = ordersFacade.getCustomerOrdersFilteredByStatus(user, OrderStatus.Delivering);
                                            for (Orders order : deliveringOrders) {
                                                out.println("<tr>");
                                                out.println("<td>" + order.getId() + "</td>");
                                                out.println("<td>" + order.getSubmittedTime() + "</td>");
                                                out.println("<td>" + order.getTotalAmount() + "</td>");
                                                out.println("<td><a href=\"vieworderdetails.jsp?id=" + order.getId() + "\"><span class=\"btn btn-sm btn-primary\">View Details</span></a></td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <div class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#completedOrders">
                                <i class="bi bi-cart"></i><span class="ms-2">Completed Orders</span>
                            </button>
                        </div>
                        <div class="accordion-collapse collapse" id="completedOrders">
                            <div class="accordion-body ms-4">
                                <table class="table">
                                    <thead>
                                    <th>Order ID</th>
                                    <th>Ordered Date</th>
                                    <th>Amount</th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Orders> deliveredOrders = ordersFacade.getCustomerOrdersFilteredByStatus(user, OrderStatus.Delivered);
                                            for (Orders order : deliveredOrders) {
                                                out.println("<tr>");
                                                out.println("<td>" + order.getId() + "</td>");
                                                out.println("<td>" + order.getSubmittedTime() + "</td>");
                                                out.println("<td>" + order.getTotalAmount() + "</td>");
                                                out.println("<td><a href=\"vieworderdetails.jsp?id=" + order.getId() + "\"><span class=\"btn btn-sm btn-primary\">View Details</span></a></td>");
                                                out.println("</tr>");
                                            }
                                        %>
                                    </tbody>
                                </table>
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
