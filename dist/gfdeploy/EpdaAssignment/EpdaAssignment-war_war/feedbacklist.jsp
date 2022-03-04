<%@page import="model.*"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%
    Context context = new InitialContext();
    FeedbackFacade feedbackFacacde = (FeedbackFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/FeedbackFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.4/css/dataTables.bootstrap5.min.css">
        <link href="site.css" rel="stylesheet">
        <title>Feedbacks | APStore </title>
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
            <h2>Feedbacks</h2>
            <div class="col-12 mt-4">
                <table id="feedbackTable" class="table table-stripped" style="width:100%">
                    <thead>
                    <th>Submitted On</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    </thead>
                    <tbody>
                        <%
                            List<Feedback> feedbacks = feedbackFacacde.findAll();

                            for (Feedback feedback : feedbacks) {
                                out.println("<tr>");
                                out.println("<td>" + feedback.getSubmittedOn().toString() + "</td>");
                                out.println("<td>" + feedback.getStarCount() + "</td>");
                                out.println("<td>" + feedback.getComment() + "</td>");
                                out.println("</tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.11.4/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#feedbackTable').DataTable();
            });
        </script>
    </body>
</html>
