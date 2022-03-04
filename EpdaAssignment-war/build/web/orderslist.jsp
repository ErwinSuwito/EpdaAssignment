<%@page import="model.Enums"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="model.Orders"%>
<%@page import="model.OrdersFacade"%>
<%
    Context context = new InitialContext();
    OrdersFacade ordersFacade = (OrdersFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/OrdersFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.4/css/dataTables.bootstrap5.min.css">
        <link href="site.css" rel="stylesheet">
        <title>Manage Orders | APStore </title>
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
            <h2>Manage Orders</h2>
            <div class="col-12 mt-4">
                <%
                    String notice = (String) request.getSession(false).getAttribute("notice");
                    String noticeBg = (String) request.getSession(false).getAttribute("noticeBg");
                    if (notice != null) {
                        out.println("<div class=\"alert alert-" + noticeBg + "\" role=\"alert\">" + notice + "</div>");
                    }
                %>
                <ul class="nav nav-tabs" id="ordersTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a href="#pending" class="nav-link active" data-bs-toggle="tab">Home</a>

                    </li>
                    <li class="nav-item" role="presentation">
                        <a href="#assigned" class="nav-link" data-bs-toggle="tab">Assigned</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a href="#delivering" class="nav-link" data-bs-toggle="tab">Delivering</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a href="#delivered" class="nav-link" data-bs-toggle="tab">Delivered</a>
                    </li>
                </ul>
                <div class="tab-content mt-4" id="ordersTabContent">
                    <div class="tab-pane fade show active" id="pending">
                        <table id="pendingTable" class="table table-stripped" style="width:100%">
                            <thead>
                                <th>Order Id</th>
                                <th>Customer Name</th>
                                <th>Address</th>
                                <th>Amount</th>
                                <th></th>
                            </thead>
                            <tbody>
                                <%
                                    List<Orders> pendingOrders = ordersFacade.getPendingOrders();
                                    
                                    for (Orders order : pendingOrders) {
                                        out.println("<tr>");
                                        out.println("<td>" + order.getId() + "</td>");
                                        out.println("<td>" + order.getCustomer().getName()+ "</td>");
                                        out.println("<td>" + order.getAddress() + "</td>");
                                        out.println("<td>RM " + order.getTotalAmount()+ "</td>");
                                        out.println("<td>");
                                        out.println("<a href=\"orderdetails.jsp?id=" + order.getId() + "\"> <span class=\"btn btn-secondary btn-sm\">View Details</span></a>");
                                        out.println("<a href=\"assigndelivery.jsp?id=" + order.getId() + "\"> <span class=\"btn btn-primary btn-sm\">Assign Delivery Staff</span></a>");
                                        out.println("</td>");
                                        out.println("</tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="assigned" role="tabpanel" aria-labelledby="assigned-tab">
                        <table id="assignedTable" class="table table-stripped" style="width:100%">
                            <thead>
                                <th>Order Id</th>
                                <th>Customer Name</th>
                                <th>Address</th>
                                <th>Amount</th>
                                <th>Assigned To</th>
                                <th></th>
                            </thead>
                            <tbody>
                                <%
                                    List<Orders> assignedOrders = ordersFacade.getAssignedOrders();

                                    for (Orders order : assignedOrders) {
                                        out.println("<tr>");
                                        out.println("<td>" + order.getId() + "</td>");
                                        out.println("<td>" + order.getCustomer().getName() + "</td>");
                                        out.println("<td>" + order.getAddress() + "</td>");
                                        out.println("<td>RM " + order.getTotalAmount() + "</td>");
                                        out.println("<td>" + order.getDeliveryStaff().getName() + "</td>");
                                        out.println("<td>");
                                        out.println("<a href=\"orderdetails.jsp?id=" + order.getId() + "\"> <span class=\"btn btn-secondary btn-sm\">View Details</span></a>");
                                        out.println("<a href=\"assigndelivery.jsp?id=" + order.getId() + "\"> <span class=\"btn btn-primary btn-sm\">Assign Delivery Staff</span></a>");
                                        out.println("</td>");
                                        out.println("</tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="delivering">
                        <table id="deliveringTable" class="table table-stripped" style="width:100%">
                            <thead>
                                <th>Order Id</th>
                                <th>Customer Name</th>
                                <th>Address</th>
                                <th>Amount</th>
                                <th>Assigned To</th>
                                <th></th>
                            </thead>
                            <tbody>
                                <%
                                    List<Orders> deliveringOrders = ordersFacade.getDeliveringOrders();

                                    for (Orders order : deliveringOrders) {
                                        out.println("<tr>");
                                        out.println("<td>" + order.getId() + "</td>");
                                        out.println("<td>" + order.getCustomer().getName() + "</td>");
                                        out.println("<td>" + order.getAddress() + "</td>");
                                        out.println("<td>RM " + order.getTotalAmount() + "</td>");
                                        out.println("<td>" + order.getDeliveryStaff().getName() + "</td>");
                                        out.println("<td>");
                                        out.println("<a href=\"orderdetails.jsp?id=" + order.getId() + "\"> <span class=\"btn btn-secondary btn-sm\">View Details</span></a>");
                                        out.println("</td>");
                                        out.println("</tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane fade" id="delivered">
                        <table id="deliveredTable" class="table table-stripped" style="width:100%">
                            <thead>
                                <th>Order Id</th>
                                <th>Customer Name</th>
                                <th>Address</th>
                                <th>Amount</th>
                                <th>Assigned To</th>
                                <th>Delivered Time</th>
                                <th></th>
                            </thead>
                            <tbody>
                                <%
                                    List<Orders> deliveredOrders = ordersFacade.getDeliveredOrders();

                                    for (Orders order : deliveredOrders) {
                                        out.println("<tr>");
                                        out.println("<td>" + order.getId() + "</td>");
                                        out.println("<td>" + order.getCustomer().getName() + "</td>");
                                        out.println("<td>" + order.getAddress() + "</td>");
                                        out.println("<td>RM " + order.getTotalAmount() + "</td>");
                                        out.println("<td>" + order.getDeliveryStaff().getName() + "</td>");
                                        out.println("<td>" + order.getDeliveredTime() + "</td>");
                                        out.println("<td>");
                                        out.println("<a href=\"orderdetails.jsp?id=" + order.getId() + "\"> <span class=\"btn btn-secondary btn-sm\">View Details</span></a>");
                                        out.println("</td>");
                                        out.println("</tr>");
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%
            // Removes notice and noticeBg from session
            session.removeAttribute("noticeBg");
            session.removeAttribute("notice");
        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#pendingTable').DataTable();
                $('#assignedTable').DataTable();
                $('#deliveringTable').DataTable();
                $('#deliveredTable').DataTable();
            });
        </script>
    </body>
</html>
