<%@page import="model.OrderProduct"%>
<%@page import="model.Orders"%>
<%@page import="model.Enums"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.ProductFacade"%>
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
        <title>Cart | APStore </title>
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
    %>
    <body>
        <%@include file="/WEB-INF/jspf/customer_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Cart</h2>
            <div class="row justify-content-between mt-4">
                <%
                    String notice = (String) request.getSession(false).getAttribute("notice");
                    String noticeBg = (String) request.getSession(false).getAttribute("noticeBg");
                    if (notice != null) {
                        out.println("<div class=\"alert alert-" + noticeBg + "\" role=\"alert\">" + notice + "</div>");
                    }

                    if (request.getSession(false).getAttribute("cart") == null) {
                        out.println("<h2>Your cart is empty</h2>");
                        out.println("<a href=\"index.jsp\"><button class=\"btn btn-primary mt-3\" type=\"button\">Browse Items</button></a>");
                    } else {
                        Orders order = (Orders) request.getSession(false).getAttribute("cart");
                        List<OrderProduct> cart = order.getProductBasket();

                        out.println("<div class=\"row mb-5\">");
                        out.println("<p>");
                        out.println("Shown prices and quantity purchased not final until confirmed. Purchase quantity and total price will be adjusted if stocks are not enough.");
                        out.println("</p>");
                        
                        
                        for(OrderProduct cartItem : cart) {
                            out.println("<div class=\"row mb-5\">");
                            out.println("<div class=\"col-2\">");
                            out.println("<img class=\"img-fluid\" height=\"152px\" width=\"152px\" src=\"" + cartItem.getProduct().getProductImage() + "\">");
                            out.println("</div>");
                            out.println("<div class=\"col\">");
                            out.println("<h4>" + cartItem.getProduct().getProductName() + "</h4>");
                            out.println("<h5>RM " + cartItem.getProduct().getPrice()+ " per unit</h5>");
                            out.println("<a href=\"DeleteItemFromCart?productId=" + cartItem.getProduct().getId() + "\">Remove</a>");
                            out.println("</div>");
                            out.println("<div class=\"col-2\">");
                            out.println("Quantity <span class=\"ms-2\">" + cartItem.getQuantityPurchased() + "</span>");
                            out.println("</div>");
                            out.println("</div>");
                        }
                    }
                %>
            </div>
        </div>

        <%
            // Removes notice and noticeBg from session
            session.removeAttribute("noticeBg");
            session.removeAttribute("notice");
        %>

        <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#productTable').DataTable();
            });
        </script>
    </body>
</html>
