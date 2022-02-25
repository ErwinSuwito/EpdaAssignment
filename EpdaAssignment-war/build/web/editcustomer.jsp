<%@page import="model.Enums"%>
<%@page import="model.CustomerFacade"%>
<%@page import="model.Customer"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
    Context context = new InitialContext();
    CustomerFacade customerFacade = (CustomerFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/CustomerFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="site.css" rel="stylesheet">

        <title>Edit Customer | APStore </title>
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
            <h2>Edit Customer</h2>
            <div class="col-8 mt-4">
                <%
                    String notice = (String) request.getSession(false).getAttribute("notice");
                    String noticeBg = (String) request.getSession(false).getAttribute("noticeBg");
                    if (notice != null) {
                        out.println("<div class=\"alert alert-" + noticeBg + "\" role=\"alert\">" + notice + "</div>");
                    }

                    if (request.getParameter("id") == null) {
                        response.sendRedirect("notfound.jsp");
                        return;
                    }

                    String id = request.getParameter("id");
                    Customer customer = customerFacade.find(id);
                    if (customer == null) {
                        response.sendRedirect("notfound.jsp");
                        return;
                    }
                %>
                <form action="EditCustomer" method="POST">
                    <input type="hidden" name="id" id="id" value="<% out.print(customer.getId()); %>">
                    <div class="alert alert-warning">
                        Entering something on the password field will change the customer's password. <b>Leave it blank to keep the customer's password.</b>
                    </div>
                    <div class="row mb-3">
                        <label for="name" class="col-sm-2 col-form-label">Full Name</label>
                        <div class="col-sm-10">
                            <input type="text" class ="form-control" name="name" id="name" value="<% out.print(customer.getName()); %>" maxlength="255" required></input>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="id" class="col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email" value="<% out.print(customer.getId()); %>" maxlength="255" disabled readonly>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="password" class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="password" id="password" maxlength="255">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="phoneNumber" class="col-sm-2 col-form-label">Phone Number</label>
                        <div class="col-sm-10">
                            <input type="tel" class ="form-control" name="phoneNumber" id="phoneNumber" maxlength="255" value="<% out.print(customer.getPhoneNumber()); %>" required></input>
                        </div>
                    </div>
                    <button type="submit" value="submit" class="btn btn-primary">Save Changes</button>
                </form>
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
