<%@page import="model.OrderProduct"%>
<%@page import="model.Orders"%>
<%@page import="model.Enums"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.ProductFacade"%>
<%@page import="viewmodels.CartCheckResultViewModel"%>
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
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.4/css/dataTables.bootstrap5.min.css">
        <link href="site.css" rel="stylesheet">
        <title>Edit Order | APStore </title>
    </head>
    <%
        // Gets the current session to check if user is logged in
        Enums.LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == Enums.LoginStateRole.LoggedOut) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (state != Enums.LoginStateRole.Customer) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
        
        if (request.getParameter("orderId") == null) {
            response.sendRedirect("notfound.jsp");
            return;
        }
    %>
    <body>
        <%@include file="/WEB-INF/jspf/customer_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Edit Order</h2>
            <div class="row justify-content-between mt-4">
                <div class="col-8">
                    <p>Enter your new address for this order.</p>
                    <div class="row">
                        <div class="col-8">
                            <form action="UpdateOrder" method="POST">
                                <input type="hidden" name="orderId" value="<% out.print(request.getParameter("orderId")); %>" >
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" name="address" id="address" placeholder="Address" required>
                                    <label for="address">Address</label>
                                </div>
                                <button class="btn btn-primary" value="submit" type="submit">Save Changes</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>
