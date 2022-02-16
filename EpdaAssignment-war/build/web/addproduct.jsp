<%-- 
    Document   : addproduct
    Created on : Feb 16, 2022, 12:00:08 PM
    Author     : erwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Add Product</h1>
        <form action="AddProduct" method="POST">
            <label for="productName">Product Name: </label><br>
            <input type="text" id="productName" name="productName"><br>
            <label for="price">Price: </label><br>
            <input type="number" id="price" name="price"><br><br>
            <label for="quantity">Price: </label><br>
            <input type="number" id="quantity" name="quantity"><br><br>
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
