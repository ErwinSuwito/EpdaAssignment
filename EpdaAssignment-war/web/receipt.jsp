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
    OrderProductFacade orderProductFacade = (OrderProductFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/OrderProductFacade");
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

        <title>Receipt | APStore </title>
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

        List<OrderProduct> basket = orderProductFacade.findByOrder(order);

        if (state == LoginStateRole.LoggedOut) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <body>
        <div class="row justify-content-center">
            <div class="col-10 col-sm-8 mt-5">
                <div class="card">
                    <div class="card-body m-3">
                        <div class="row justify-content-between">
                            <div class="col-4">
                                <h2>APStore</h2>
                            </div>
                            <div class="col-3">
                                <h2>Thank You!</h2>
                            </div>
                        </div>
                        <hr>
                        <h4>Order Receipt</h4>
                        <div class="row justify-content-between">
                            <div class="col-3">
                                <p class="fw-light mb-0">Order ID</p>
                                <% out.println(order.getId()); %>
                                <p class="fw-light mb-0">Date and Time</p>
                                <% out.println(order.getDeliveredTime().toString());%>
                            </div>
                            <div class="col-3">
                                <p class="fw-light mb-0">Billed to</p>
                                <p class="mb-0"><% out.print(order.getCustomer().getName()); %></p>
                                <p class="mb-0"><% out.print(order.getAddress()); %></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <table class="table">
                                <thead>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>Unit Price</th>
                                <th>Total Price</th>
                                </thead>
                                <tbody>
                                    <%
                                        for (OrderProduct cartItem : order.getProductBasket()) {
                                            out.println("<tr>");
                                            out.println("<td>" + cartItem.getProduct().getProductName() + "</td>");
                                            out.println("<td>" + cartItem.getQuantityPurchased() + "</td>");
                                            out.println("<td>RM " + cartItem.getProduct().getPrice() + "</td>");
                                            out.println("<td>RM " + cartItem.getProduct().getPrice() * cartItem.getQuantityPurchased() + "</td>");
                                            out.println("</tr>");
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <div class="row justify-content-between">
                            <div class="col-4">
                                <span class="fw-bold">Total</span>
                            </div>
                            <div class="col-2">
                                <span class="fw-bold">RM <% out.print(order.getTotalAmount());%></span>
                            </div>
                        </div>
                            <hr>
                            <p class="mb-0">Thank you for shopping with us.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
