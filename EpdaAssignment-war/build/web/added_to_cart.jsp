<%@page import="model.Enums.LoginStateRole"%>
<%@page import="model.Enums"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.ProductFacade"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="site.css" rel="stylesheet">
        <title>APStore</title>
    </head>
    <body>
        <%@include file="/WEB-INF/jspf/customer_navbar.jspf" %>
        <div class="container mt-5">
            <div class="row">
                <h1>Item added to cart!</h1>
                <p>Click on the button below to browser for more items or check out.</p>
                <div class="d-grid gap-2 d-md-block">
                    <a href="index.jsp">
                        <button class="btn btn-primary" type="button">Browse Items</button>
                    </a>
                    <a href="cart.jsp">
                        <button class="btn btn-primary" type="button">Check Out</button>
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>
