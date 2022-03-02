<%@page import="java.time.format.TextStyle"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="model.*"%>
<%@page import="javax.naming.Context"%>
<%
    Context context = new InitialContext();
    ProductFacade productFacade = (ProductFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/ProductFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link href="site.css" rel="stylesheet">
        <title>Low Stock Report | APStore </title>
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
            <h2>Low Stock Report</h2>
            <p>Products where stock is lower than 5</p>
            <p><% out.print(LocalDateTime.now().getMonth().getDisplayName(TextStyle.FULL, Locale.getDefault()) + " " + LocalDateTime.now().getYear()); %></p>
            <button class="btn btn-outline-primary btn-sm mt-2 d-print-none" onclick="printReport()"><i class="bi bi-printer"></i>    Print</button>
            <div class="col mt-4">
                <table class="table">
                    <thead>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    </thead>
                    <tbody>
                        <%
                            List<Product> products = productFacade.findAll();
                            for (Product product : products) {
                                if ((product.getQuantity() < 5)) {
                                    out.println("<tr>");
                                    out.println("<td>" + product.getProductName() + "</td>");
                                    out.println("<td>" + product.getPrice() + "</td>");
                                    out.println("<td>" + product.getQuantity()+ "</td>");
                                    out.println("</tr>");
                                }
                            }
                        %>
                    </tbody>
                </table>
                <p>Report generated on: <% out.print(LocalDateTime.now().toString());%></p>
            </div>
        </div>
        <script>
            function printReport() {
                window.print();
            }
        </script>
    </body>
</html>
