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
                Review your order and fill in the delivery address to submit your order
                <%
                    if (request.getSession(false).getAttribute("cart") == null) {
                        response.sendRedirect("cart.jsp");
                        return;
                    } else {
                        Orders order = (Orders) request.getSession(false).getAttribute("cart");
                        List<OrderProduct> cart = order.getProductBasket();
                        CartCheckResultViewModel cartCheckResult = helpers.Helpers.CheckCart(order, productFacade);
                        Boolean anyModifications = cartCheckResult.getAnyModifications();
                        double totalAmount = 0.0;

                        if (anyModifications) {
                            out.println("<div class=\"alert alert-warning\" role=\"alert\">");
                            out.println("Modifications to your cart have been made reflecting product stock.");
                            out.println("</div>");
                        }

                        if (cartCheckResult.getCart().isEmpty()) {
                            response.sendRedirect("cart.jsp");
                            return;
                        } else {
                            out.println("<div class=\"row mb-5\">");

                            for (OrderProduct cartItem : cartCheckResult.getCart()) {
                                totalAmount += cartItem.getProduct().getPrice() * cartItem.getQuantityPurchased();
                                out.println("<div class=\"row mb-5\">");
                                out.println("<div class=\"col-2\">");
                                out.println("<img class=\"img-fluid\" height=\"152px\" width=\"152px\" src=\"" + cartItem.getProduct().getProductImage() + "\">");
                                out.println("</div>");
                                out.println("<div class=\"col\">");
                                out.println("<h4>" + cartItem.getProduct().getProductName() + "</h4>");
                                out.println("<h5>RM " + cartItem.getProduct().getPrice() + " per unit</h5>");
                                out.println("<a href=\"DeleteItemFromCart?productId=" + cartItem.getProduct().getId() + "\">Remove</a>");
                                out.println("</div>");
                                out.println("<div class=\"col-2\">");
                                out.println("Quantity <span class=\"ms-2\">" + cartItem.getQuantityPurchased() + "</span>");
                                out.println("</div>");
                                out.println("</div>");
                            }
                        }
                    }
                %>
            </div>
        </div>
    </body>
</html>
