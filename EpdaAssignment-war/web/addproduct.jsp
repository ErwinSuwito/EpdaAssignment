<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link href="site.css" rel="stylesheet">
    
    <title>Add Product | APStore </title>
  </head>
    <body>
        <%@include file="/WEB-INF/jspf/managing_navbar.jspf" %>
        <div class="container mt-5">
            <h2>Add new product</h2>
            <div class="col-8 mt-4">
                <form action="AddProduct" method="POST">
                    <div class="row mb-3">
                        <label for="productName" class="col-sm-2 col-form-label">Product Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="productName" id="productName" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="productImage" class="col-sm-2 col-form-label">Product Image</label>
                        <div class="col-sm-10">
                            <input type="url" class="form-control" name="productImage" id="productImage" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="description" class="col-sm-2 col-form-label">Description</label>
                        <div class="col-sm-10">
                            <textarea row="3" class ="form-control" name="description" id="description" required></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="price" class="col-sm-2 col-form-label">Price</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-text">RM</span>
                                <input type="number" class="form-control" id="price" name="price" required>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="quantity" class="col-sm-2 col-form-label">Quantity</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" name="quantity" id="quantity" required>
                        </div>
                    </div>
                    <button type="submit" value="submit" class="btn btn-primary">Add Product</button>
                </form>
            </div>
        </div>
        <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>
