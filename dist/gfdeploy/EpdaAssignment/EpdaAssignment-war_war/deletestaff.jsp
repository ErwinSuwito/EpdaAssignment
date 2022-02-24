<%@page import="model.Enums"%>
<%@page import="model.StaffFacade"%>
<%@page import="model.Staff"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
    Context context = new InitialContext();
    StaffFacade staffFacade = (StaffFacade)context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/StaffFacade");
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
    <body>
        <%@include file="/WEB-INF/jspf/managing_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Delete staff?</h2>
            <p>All user data will be permanently deleted and not recoverable.</p>
            <%
                if (request.getParameter("id") == null) {
                    response.sendRedirect("notfound.jsp");
                    return;
                }
                
                Long id = Long.parseLong(request.getParameter("id"));
                Staff staffToDelete = staffFacade.find(id);
                if (staffToDelete == null) {
                    response.sendRedirect("notfound.jsp");
                    return;
                }
            %>
            <div class="col-8 mt-4">
                <form action="DeleteStaff" method="POST">
                    <div class="row mb-3">
                        <label for="id" class="col-sm-2 col-form-label">Staff Email:</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="id" id="id" disabled readonly>
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
