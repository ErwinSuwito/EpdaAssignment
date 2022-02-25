<%@page import="model.Enums"%>
<%@page import="model.StaffFacade"%>
<%@page import="model.Staff"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
    Context context = new InitialContext();
    StaffFacade staffFacade = (StaffFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/StaffFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="site.css" rel="stylesheet">

        <title>Confirm Delete Staff | APStore </title>
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
            <h2>Delete staff?</h2>
            <div class="alert alert-danger">
                <b>All user data will be permanently deleted and not recoverable.</b>
            </div>
            <%
                if (request.getParameter("id") == null) {
                    response.sendRedirect("notfound.jsp");
                    return;
                }

                String id = request.getParameter("id");
                Staff staffToDelete = staffFacade.find(id);
                if (staffToDelete == null) {
                    response.sendRedirect("notfound.jsp");
                    return;
                }
            %>
            <div class="col-8 mt-4">
                <form action="DeleteStaff" method="POST">
                    <input type="hidden" class="form-control" name="id" id="id" value="<% out.print(staffToDelete.getId());%>">
                    <div class="row mb-3">
                        <label for="id" class="col-sm-2 col-form-label">Staff Email:</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email" value="<% out.print(staffToDelete.getId());%>" disabled readonly>
                        </div>
                    </div>
                    <button type="submit" value="submit" class="btn btn-danger">Delete</button>
                    <a href="stafflist.jsp"><span class="btn btn-primary">Cancel</span></a>
                </form>
            </div>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
