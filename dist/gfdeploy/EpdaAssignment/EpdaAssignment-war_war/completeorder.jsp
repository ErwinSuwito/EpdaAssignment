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
    OrderProductFacade orderProductFacade = (OrderProductFacade)context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/OrderProductFacade");
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

        <title>Complete Order | APStore </title>
    </head>
    <%
        // Gets the current session to check if user is logged in
        LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state != LoginStateRole.DeliveryStaff) {
            response.sendRedirect("unauthorized.jsp");
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
    %>
    <body>
        <%@include file="/WEB-INF/jspf/empty_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Complete Order</h2>
            <h6>Order ID <% out.print(order.getId()); %></h6>
            <div class="row mt-4">
                <div class="alert alert-warning">
                    Updating the status to Delivered will automatically generate the receipt.
                </div>
                <%
                    String notice = (String) request.getSession(false).getAttribute("notice");
                    String noticeBg = (String) request.getSession(false).getAttribute("noticeBg");
                    if (notice != null) {
                        out.println("<div class=\"alert alert-" + noticeBg + "\" role=\"alert\">" + notice + "</div>");
                    }
                %>
            </div>
            <div class="row">
                <div class="col-8 mt-5">
                    <form action="UpdateOrderStatus" method="POST">
                    <input type="hidden" id="orderId" name="orderId" value="<% out.print(order.getId()); %>">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">Status</label>
                        <div class="col-sm-10">
                            <select name="orderStatus" class="form-select">
                                <option value="Delivered" selected>Delivered</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="totalAmount" class="col-sm-2 col-form-label">Total Amount</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-text">RM</span>
                                <input type="number" class="form-control" id="totalAmount" name="totalAmount" step="0.01" value="<% out.print(order.getTotalAmount()); %>" disabled readodnly>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="amountTendered" class="col-sm-2 col-form-label">Amount Tendered</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-text">RM</span>
                                <input type="number" class="form-control" id="amountTendered" name="amountTendered" step="0.01" min="<% out.print(order.getTotalAmount()); %>" required>
                            </div>
                        </div>
                    </div>
                    <button type="submit" value="submit" class="btn btn-primary">Complete Order</button>
                </form>
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
