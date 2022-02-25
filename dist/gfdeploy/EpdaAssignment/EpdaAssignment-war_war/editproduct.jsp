<%@page import="model.Enums"%>
<%@page import="model.ProductFacade"%>
<%@page import="model.Product"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%
    Context context = new InitialContext();
    ProductFacade productFacade = (ProductFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/ProductFacade");
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="site.css" rel="stylesheet">

        <title>Edit Product | APStore </title>
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
            <h2>Edit Product</h2>
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

                    Long id = Long.parseLong(request.getParameter("id"));
                    Product product = productFacade.find(id);
                    if (product == null) {
                        response.sendRedirect("notfound.jsp");
                        return;
                    }
                %>
                <form action="EditProduct" method="POST">
                    <input type="hidden" name="productId" id="productId" value="<% out.print(product.getId()); %>">
                    <div class="row mb-3">
                        <label for="productName" class="col-sm-2 col-form-label">Product Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="productName" id="productName" value="<% out.print(product.getProductName()); %>" maxlength="255" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="productImage" class="col-sm-2 col-form-label">Product Image</label>
                        <div class="col-sm-10">
                            <input type="url" class="form-control" name="productImage" id="productImage" value="<% out.print(product.getProductImage()); %>" maxlength="255" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="description" class="col-sm-2 col-form-label">Description</label>
                        <div class="col-sm-10">
                            <textarea row="3" class ="form-control" name="description" id="description" maxlength="255" required><% out.print(product.getDescription()); %></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="price" class="col-sm-2 col-form-label">Price</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-text">RM</span>
                                <input type="number" class="form-control" id="price" name="price" step="0.01" value="<%out.print(product.getPrice());%>" required>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="quantity" class="col-sm-2 col-form-label">Quantity</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" name="quantity" id="quantity" value="<%out.print(product.getQuantity());%>" required>
                        </div>
                    </div>
                    <hr>
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
