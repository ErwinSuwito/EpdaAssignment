<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link href="site.css" rel="stylesheet">
    
    <title>Login | APStore </title>
  </head>
    <body>
        <%@include file="WEB-INF/jspf/managing_navbar.jspf" %>
        <div class="container">
            
            
            <form action="AddProduct" method="POST">
                <label for="productName">Product Name: </label><br>
                <input type="text" id="productName" name="productName"><br>
                <label for="description">Product Description </label><br>
                <input type="text" id="description" name="description"><br>
                <label for="price">Price: </label><br>
                <input type="number" id="price" name="price"><br><br>
                <label for="quantity">Price: </label><br>
                <input type="number" id="quantity" name="quantity"><br><br>
                <input type="submit" value="Submit">
            </form>
        </div>
        
        <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
