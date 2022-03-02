<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Enums"%>
<%@page import="model.UsersFacade"%>
<%@page import="model.Users"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
    Context context = new InitialContext();
    UsersFacade usersFacade = (UsersFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/UsersFacade");
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

        <title>Edit Profile | APStore </title>
    </head>
    <%
        // Gets the current session to check if user is logged in
        Enums.LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == Enums.LoginStateRole.Customer || state == Enums.LoginStateRole.LoggedOut) {
            response.sendRedirect("login.jsp");
            return;
        }

        Users user = (Users) request.getSession(false).getAttribute("login");
    %>
    <body>
        <%@include file="/WEB-INF/jspf/empty_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Edit Profile</h2>
            <div class="row mt-4">
                <%
                    String notice = (String) request.getSession(false).getAttribute("notice");
                    String noticeBg = (String) request.getSession(false).getAttribute("noticeBg");
                    if (notice != null) {
                        out.println("<div class=\"alert alert-" + noticeBg + "\" role=\"alert\">" + notice + "</div>");
                    }
                %>
            </div>
            <div class="row">
                <form action="EditStaffInfo" method="POST">
                    <input type="hidden" name="id" id="id" value="<% out.print(user.getId()); %>">
                    <div class="row mb-3">
                        <label for="name" class="col-sm-2 col-form-label">Full Name</label>
                        <div class="col-sm-10">
                            <input type="text" class ="form-control" name="name" id="name" value="<% out.print(user.getName()); %>" maxlength="255" required></input>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="id" class="col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email" maxlength="255" value="<% out.print(user.getEmail()); %>">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="phoneNumber" class="col-sm-2 col-form-label">Phone Number</label>
                        <div class="col-sm-10">
                            <input type="tel" class ="form-control" name="phoneNumber" id="phoneNumber" value="<% out.println(user.getPhoneNumber()); %>" maxlength="255" required></input>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="icNumber" class="col-sm-2 col-form-label">IC Number</label>
                        <div class="col-sm-10">
                            <input type="text" class ="form-control" name="icNumber" id="icNumber" value="<% out.println(user.getIcNumber()); %>" maxlength="255" required></input>
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
