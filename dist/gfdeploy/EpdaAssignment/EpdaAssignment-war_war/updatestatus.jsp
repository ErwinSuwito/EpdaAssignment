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

        <title>Update Order Status | APStore </title>
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
            <h2>Update Order Status</h2>
            <h6>Order ID <% out.print(order.getId()); %></h6>
            <div class="row mt-4">
                <div class="alert alert-warning">
                    <a href="completeorder.jsp?id=<% out.print(order.getId()); %>">Click here</a> to mark the order as completed and generate a receipt.
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
                <div class="col-8 mt-2">
                    <form action="UpdateOrderStatus" method="POST">
                    <input type="hidden" id="orderId" name="orderId" value="<% out.print(order.getId()); %>">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">Status</label>
                        <div class="col-sm-10">
                            <select name="orderStatus" class="form-select">
                                <option selected>Select status</option>
                                <option value="Assigned">Assigned</option>
                                <option value="Delivering">Delivering</option>
                            </select>
                        </div>
                    </div>
                    <button type="submit" value="submit" class="btn btn-primary">Save Changes</button>
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
