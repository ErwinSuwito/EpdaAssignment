<%@page import="model.Enums"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<%
    Context context = new InitialContext();
    OrdersFacade ordersFacade = (OrdersFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/OrdersFacade");
    UsersFacade usersFacade = (UsersFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/UsersFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.4/css/dataTables.bootstrap5.min.css">
        <link href="site.css" rel="stylesheet">
        <title>Assign Delivery | APStore </title>
    </head>
    <%
        // Gets the current session to check if user is logged in
        Enums.LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state != Enums.LoginStateRole.ManagingStaff) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        if (request.getParameter("id") == null) {
            response.sendRedirect("notfound.jsp");
            return;
        }

        Long orderId = Long.parseLong(request.getParameter("id"));
        Orders order = ordersFacade.find(orderId);
        List<Users> deliveryStaffs = usersFacade.findDeliveryStaffs();

        if (order == null) {
            response.sendRedirect("notfound.jsp");
            return;
        }
    %>
    <body>
        <%@include file="/WEB-INF/jspf/managing_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Assign Delivery</h2>
            <div class="col-8 mt-4">
                <form action="AssignDeliveryStaff" method="POST">
                    <input type="hidden" id="orderId" name="orderId" value="<% out.print(order.getId()); %>">
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">Delivery Staff</label>
                        <div class="col-sm-10">
                            <select name="staffId" class="form-select">
                                <option selected>Select delivery staff</option>
                                <%
                                    for (Users staff : deliveryStaffs) {
                                        out.println("<option value=\"" + staff.getId() + "\">" + staff.getName() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <button type="submit" value="submit" class="btn btn-primary">Assign Delivery</button>
                </form>
            </div>
        </div>

        <%
            // Removes notice and noticeBg from session
            session.removeAttribute("noticeBg");
            session.removeAttribute("notice");
        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#pendingTable').DataTable();
                $('#assignedTable').DataTable();
                $('#deliveringTable').DataTable();
                $('#deliveredTable').DataTable();
            });
        </script>
    </body>
</html>
