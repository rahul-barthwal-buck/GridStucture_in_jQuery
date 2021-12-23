<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GirdStructure.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Grid Structure</title>
     <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
     <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
    <style>
        .prdtable tr td:hover
        {
             background: #F5ECFF;
             color:#6100CE;
        }
    </style>
</head>
<body>
   <center>
       <h1 class="display-2">Grid Structure in jQuery</h1>
       <br />
       <br />
       <div id="data" class="table-responsive"></div>
      
   </center>
    <script type="text/javascript">

        function DeleteProductDetails(control) {
            var Info = {
                Id: $(control).closest("tr").find("label").html()
            };

            swal({
                title: "Are you sure?",
                text: "Once deleted, you will not be able to recover this Product Details!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {

                    $.ajax({
                        url: "Index.aspx/DeleteProductDetails",
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify(Info),
                        success: function (data) {
                            // alert("Data Deleted successfully");
                            swal("Data Deleted successfully...", {
                                icon: "success",
                            });
                            $(control).closest("tr").remove();
                        },
                        error: function (error) {
                            //alert("Fail");
                            console.log(error);
                            swal({
                                title: " Oops!",
                                text: " Something went wrong, you should choose again!",
                                icon: "error",
                                button: "Continue",
                            });
                        }
                    });

                } else {
                    swal("Data Not Deleted!");
                }
            });


        }

        function EditProductDetails(control) {
            if ($(control).val() == "Edit") {

                var i = 0;
                $(control).closest("tr").find("td").each(function (control) {
                    if (i != 0) {
                        if ($(this).find("label").length > 0) {
                            var value = $(this).find("label").html();
                            $(this).find("label").hide();
                            $(this).append("<input type='text' value='" + value + "' />");
                        }

                    }
                    i++;
                    $(this).find("input[itag='Edit']").val("Update");
                });

            }
            else {
                var Info = {
                    ProductId: $(control).closest("tr").find("td:nth-child(1)").find("label").html(),
                    ProductName: $(control).closest("tr").find("td:nth-child(2)").find("input").val(),
                    QuantityPerUnit: $(control).closest("tr").find("td:nth-child(3)").find("input").val(),
                    UnitPrice: $(control).closest("tr").find("td:nth-child(4)").find("input").val(),
                    UnitsInStock: $(control).closest("tr").find("td:nth-child(5)").find("input").val()
                };

                $.ajax({
                    url: "Index.aspx/UpdateProductDetails",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ product: Info }),
                    success: function (data) {

                        ProductName = $(control).closest("tr").find("td:nth-child(2)").find("input").val();
                        $(control).closest("tr").find("td:nth-child(2)").find("input").remove();
                        $(control).closest("tr").find("td:nth-child(2)").append("<label>" + ProductName + "</label>");

                        QuantityPerUnit = $(control).closest("tr").find("td:nth-child(3)").find("input").val();
                        $(control).closest("tr").find("td:nth-child(3)").find("input").remove();
                        $(control).closest("tr").find("td:nth-child(3)").append("<label>" + QuantityPerUnit + "</label>");

                        UnitPrice = $(control).closest("tr").find("td:nth-child(4)").find("input").val();
                        $(control).closest("tr").find("td:nth-child(4)").find("input").remove();
                        $(control).closest("tr").find("td:nth-child(4)").append("<label>" + UnitPrice + "</label>");

                        UnitsInStock = $(control).closest("tr").find("td:nth-child(5)").find("input").val();
                        $(control).closest("tr").find("td:nth-child(5)").find("input").remove();
                        $(control).closest("tr").find("td:nth-child(5)").append("<label>" + UnitsInStock + "</label>");

                        $(control).val("Edit");
                        //console.log(data.d);
                        //alert("Data updated successfully...");
                        //swal("Data updated successfully...");
                        swal({
                            title: "Great",
                            text: "Data updated successfully...",
                            icon: "success",
                            button: "Continue",
                        });
                    },
                    error: function (error) {
                        // alert(error.status);
                        swal({
                            title: " Oops!",
                            text: " Something went wrong, you should choose again!",
                            icon: "error",
                            button: "oh no!",
                        });
                        console.log(error);
                    }

                });
            }
        }

        $(function () {


            $.ajax({
                url: "Index.aspx/GetAllProducts",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $("#data").empty();
                    var Data = JSON.parse(data.d);
                    var arr = Data.Table;
                    var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Id</th><th>Product Name</th><th>Quantity per Unit</th><th>Unit Price</th></tr>";
                    for (var i = 0; i < arr.length; i++) {
                        temp += "<tr>";
                        temp += "<td>" + "<label>" + arr[i].Product_Id + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + arr[i].Name + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + arr[i].Quantity_Per_Unit + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + arr[i].Unit_Price + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + arr[i].Units_In_Stock + "</label>" + "</td>";
                        temp += "<td><input type='button' class='btn btn-success' itag='Edit' value='Edit' onclick='return EditProductDetails(this)'/></td>";
                        temp += "<td><input type='button' class='btn btn-danger' itag='Delete' value='Delete' onclick='return DeleteProductDetails(this);'/></td>";
                        temp += "</tr>";
                    }
                    $("#data").append(temp);
                },
                error: function (error) {
                    alert("Fail");
                }
            });

        });
    </script>
</body>
</html>
