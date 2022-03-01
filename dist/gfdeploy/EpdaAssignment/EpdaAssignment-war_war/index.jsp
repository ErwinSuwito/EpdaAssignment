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
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="site.css" rel="stylesheet">
        <title>APStore</title>
    </head>
    <%
        // Redirects user to proper home pages for staffs
        LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == LoginStateRole.DeliveryStaff) {
            response.sendRedirect("delivery_profile.jsp");
            return;
        }

        if (state == Enums.LoginStateRole.ManagingStaff) {
            response.sendRedirect("admin_profile.jsp");
            return;
        }
    %>
    <body>
        <%@include file="/WEB-INF/jspf/customer_navbar.jspf" %>
        <div class="container mt-5">
            <div class="row">
                <%
                    List<Product> availableProducts = productFacade.getAvailableProducts();
                    if (availableProducts.size() < 1) {
                        out.println("<h1>Sorry, We're sold out</h1>");
                        out.println("<h3>Check back soon! We'll be here with more products soon.</h3>");
                    }

                    for (Product p : availableProducts) {
                        out.println("<div class=\"col-sm-3 mb-4\">");
                        out.println("<div class=\"card\">");
                        out.println("<img src=\"" + p.getProductImage() + "\"class=\"card-img-top img-fluid\" style=\"max-height: 200px;\">");
                        out.println("<div class=\"card-body\">");
                        out.println("<h5 class=\"card-title\">" + p.getProductName() + "</h5>");
                        out.println("<p class=\"card-text\">RM " + p.getPrice() + "</p>");
                        out.println("<span class=\"btn btn-primary btn-sm\">");
                        out.println("<a href=\"product.jsp?id=" + p.getId() + "\">View Details</a>");
                        out.println("</span>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("</div>");
                    }
                %>
            </div>
        </div>
    </body>
</html>
