<%@page import="model.Enums.OrderStatus"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="model.*"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.format.TextStyle"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="model.Enums"%>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link href="site.css" rel="stylesheet">
        <title>Monthly Purchases and Revenue | APStore </title>
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
            <h6 class="text-uppercase">report</h6>
            <h2>Monthly Purchases and Revenue</h2>
            <p><% out.print(LocalDateTime.now().getMonth().getDisplayName(TextStyle.FULL, Locale.getDefault()) + " " + LocalDateTime.now().getYear()); %></p>
            <button class="btn btn-outline-primary btn-sm mt-2 d-print-none" onclick="printReport()"><i class="bi bi-printer"></i>    Print</button>
            <div class="col mt-4">
                <table class="table">
                    <thead>
                    <th>Order ID</th>
                    <th>Order Date</th>
                    <th>Total Amount</th>
                    </thead>
                    <tbody>
                        <%
                            double revenue = 0.0;
                            List<Orders> orders = ordersFacade.findAll();
                            for (Orders order : orders) {
                                if ((order.getSubmittedTime().getMonthValue() == LocalDateTime.now().getMonthValue())
                                        && (order.getSubmittedTime().getYear() == LocalDateTime.now().getYear()) 
                                        && (order.getStatus() == OrderStatus.Delivered)) {
                                    revenue += order.getTotalAmount();
                                    out.println("<tr>");
                                    out.println("<td>" + order.getId() + "</td>");
                                    out.println("<td>" + order.getSubmittedTime().toString() + "</td>");
                                    out.println("<td>RM " + order.getTotalAmount() + "</td>");
                                    out.println("</tr>");
                                }
                            }
                        %>
                    </tbody>
                </table>

                <p>Total revenue this month: RM <% out.print(revenue);%></p>
                <p>Report generated on: <% out.print(LocalDateTime.now().toString()); %></p>
            </div>
        </div>
        <script>
            function printReport() {
                window.print();
            }
        </script>
    </body>
</html>
