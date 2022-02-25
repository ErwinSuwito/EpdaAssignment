<%@page import="model.Enums"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="model.Users"%>
<%@page import="model.UsersFacade"%>
<%
    Context context = new InitialContext();
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
        <title>Manage Staffs | APStore </title>
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
            <h2>Manage Staffs</h2>
            <div class="col-12 mt-4">
                <%
                    String notice = (String) request.getSession(false).getAttribute("notice");
                    String noticeBg = (String) request.getSession(false).getAttribute("noticeBg");
                    if (notice != null) {
                        out.println("<div class=\"alert alert-" + noticeBg + "\" role=\"alert\">" + notice + "</div>");
                    }
                %>
                <a href="addstaff.jsp">
                    <span class="btn btn-primary mb-3">Add Staff</span>
                </a>

                <table id="staffTable" class="table table-stripped" style="width:100%">
                    <thead>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Staff Type</th>
                    <th></th>
                    </thead>
                    <tbody>
                        <%
                            List<Users> staffs = usersFacade.findAllStaffs();

                            for (Users staff : staffs) {
                                out.println("<tr>");
                                out.println("<td>" + staff.getName() + "</td>");
                                out.println("<td>" + staff.getEmail() + "</td>");
                                out.println("<td>" + staff.getRole().toString() + "</td>");
                                out.println("<td>");
                                out.println("<a href=\"editstaff.jsp?id=" + staff.getId() + "\"> <span class=\"btn btn-secondary btn-sm\">Edit</span></a>");
                                out.println("<a href=\"deleteuser.jsp?id=" + staff.getId() + "\"> <span class=\"btn btn-danger btn-sm\">Delete</span></a>");
                                out.println("</td>");
                                out.println("</tr>");
                            }
                        %>
                    </tbody>
                </table>
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
                $('#staffTable').DataTable();
            });
        </script>
    </body>
</html>
