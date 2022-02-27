<%@page import="model.Enums.LoginStateRole"%>
<%@page import="model.Enums"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.ProductFacade"%>
<%
    Context context = new InitialContext();
    ProductFacade productFacade = (ProductFacade) context.lookup("java:global/EpdaAssignment/EpdaAssignment-ejb/ProductFacade");

    if (request.getParameter("id") == null) {
        response.sendRedirect("notfound.jsp");
        return;
    }

    Long productId = Long.parseLong(request.getParameter("id"));
    Product product = productFacade.find(productId);
    if (product == null) {
        response.sendRedirect("notfound.jsp");
        return;
    }
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="site.css" rel="stylesheet">
        <title><% out.print(product.getProductName()); %> | APStore</title>
    </head>
    <%
        // Redirects user to proper home pages for staffs
        LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == LoginStateRole.DeliveryStaff) {
            response.sendRedirect("adminhome.jsp");
            return;
        }

        if (state == Enums.LoginStateRole.ManagingStaff) {
            response.sendRedirect("adminhome.jsp");
            return;
        }
    %>
    <body>
        <%@include file="/WEB-INF/jspf/customer_navbar.jspf" %>
        <div class="container mt-5">
            <div class="row">
                <div class="row">
                    <div class="col-12 col-sm-4 d-flex align-items-center ms-1">
                        <img src="<% out.print(product.getProductImage()); %>" 
                             class="img-fluid" style="max-height: 320px; max-width: 320px">
                    </div>
                    <div class="col ms-5 ms-sm-1">
                        <h3 class="mt-2">
                            <% out.print(product.getProductName()); %>
                        </h3>
                        <h4 class="mt-2">
                            RM <b><% out.print(product.getPrice()); %></b> per unit
                        </h4>
                        <form class="mt-2" action="AddItemToCart" method="POST">
                            <input type="hidden" id="id" name="id" value="<% out.print(product.getId());%>">
                            <div class="row g-3 align-items-center">
                                <div class="col-auto">
                                    <label for="quantity" class="col-form-label">Quantity</label>
                                </div>
                                <div class="col-auto">
                                    <input type="number" id="quantity" name="quantity" class="form-control"
                                           value="1" min="1" max="<% out.print(product.getQuantity()); %>">
                                </div>
                                <div class="col-auto">
                                    <button type="submit" value="submit" class="btn btn-primary">Add to cart</button>
                                </div>
                            </div>
                        </form>
                        <p class="mt-2">Only <% out.print(product.getQuantity());%> unit(s) left</p>
                    </div>
                </div>
                <div class="row ms-5 ms-sm-1 mt-4">
                    <h3>Product Description</h3>
                    <p><% out.print(product.getDescription());%></p>
                </div>
            </div>
        </div>
    </body>
</html>
