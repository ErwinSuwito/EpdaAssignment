<%@page import="model.Orders"%>
<%@page import="model.Enums"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="site.css" rel="stylesheet">

        <title>Rate and Feedback Service | APStore </title>
    </head>
    <%
        // Gets the current session to check if user is logged in
        Enums.LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state != Enums.LoginStateRole.Customer) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        if (request.getParameter("id") == null) {
            response.sendRedirect("customer_profile.jsp");
            return;
        }
    %>
    <body>
        <%@include file="/WEB-INF/jspf/customer_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Rate and Feedback Service</h2>
            <div class="col-8 mt-4">
                <form action="RateOrder" method="POST">
                    <input type="hidden" name="id" value="<% out.print(request.getParameter("id"));%>">
                    <div class="row mb-3">
                        <label for="stars" class="col-sm-2 col-form-label">Rate from 1 (worst) to 5 (good)</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" name="stars" id="stars" min="1" max="5" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="comment" class="col-sm-2 col-form-label">Comments</label>
                        <div class="col-sm-10">
                            <textarea row="3" class ="form-control" name="comment" id="comment" maxlength="255" required></textarea>
                        </div>
                    </div>
                    <button type="submit" value="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
