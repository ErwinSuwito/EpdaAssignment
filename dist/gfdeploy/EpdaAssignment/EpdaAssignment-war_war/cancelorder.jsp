<%@page import="model.*"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
    Context context = new InitialContext();
    OrdersFacade ordersFacade = (OrdersFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/OrdersFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="site.css" rel="stylesheet">

        <title>Confirm Cancel Order | APStore </title>
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
            <h2>Cancel order?</h2>
            <p>Your order will be canceled and deleted from your account.</p>
            <%
                if (request.getParameter("id") == null) {
                    response.sendRedirect("notfound.jsp");
                    return;
                }

                Long id = Long.parseLong(request.getParameter("id"));
                Orders order = ordersFacade.find(id);
                if (order == null) {
                    response.sendRedirect("notfound.jsp");
                    return;
                }
            %>
            <div class="col-8 mt-4">
                <form action="DeleteProduct" method="POST">
                    <input type="hidden" name="id" id="id" value="<% out.print(order.getId()); %>">
                    <button type="submit" value="submit" class="btn btn-danger">Cancel Order and Delete</button>
                    <a href="productlist.jsp"><span class="btn btn-primary">Go Back</span></a>
                </form>
            </div>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
