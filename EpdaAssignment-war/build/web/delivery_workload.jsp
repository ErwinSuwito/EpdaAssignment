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
    UsersFacade usersFacade = (UsersFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/UsersFacade");
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
        <title>Monthly Delivery Workload | APStore </title>
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
            <h2>Monthly Delivery Workload</h2>
            <p><% out.print(LocalDateTime.now().getMonth().getDisplayName(TextStyle.FULL, Locale.getDefault()) + " " + LocalDateTime.now().getYear()); %></p>
            <button class="btn btn-outline-primary btn-sm mt-2 d-print-none" onclick="printReport()"><i class="bi bi-printer"></i>    Print</button>
            <div class="col mt-4">
                <table class="table">
                    <thead>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Created Date</th>
                    </thead>
                    <tbody>
                        <%
                            List<Users> users = usersFacade.findAllCustomers();
                            for (Users user : users) {
                                if ((user.getCreatedDate().getYear() == LocalDateTime.now().getYear())
                                        && (user.getCreatedDate().getMonth() == LocalDateTime.now().getMonth())) {
                                    out.println("<tr>");
                                    out.println("<td>" + user.getName() + "</td>");
                                    out.println("<td>" + user.getEmail() + "</td>");
                                    out.println("<td>" + user.getPhoneNumber() + "</td>");
                                    out.println("<td>" + user.getCreatedDate() + "</td>");
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
