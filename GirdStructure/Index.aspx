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
        .down {
          transform: rotate(45deg);
          -webkit-transform: rotate(45deg);
        }
        #SortByProduct
        {
            font-size:15px;
            font-weight:bold;
            margin-left:35px;
        }
        
    </style>
</head>
<body>
   <center>
       <h1 class="display-2">Grid Structure in jQuery</h1>
       <br />
       <br />
       <div id="data" class="table-responsive"></div>
        <div class="table-responsive">
           <table class='table table-bordered table-striped table-sm prdtable' border='1' style="width:800px;">
               <tr>
                   <td align="right">
                       Go to Page:
                       <input type="text" style="width:40px;text-align:center;" value="1"  id="GotoPage"/>
                       Show rows:
                       <select id="drpPageSize" onchange="GetPageSize(this);">
                          <option  value="5" selected="selected">5</option>
                          <option value="10">10</option>
                          <option value="15">15</option>
                       </select>
                       <input type="button" value="<" onclick="return GetPreviousProduct();" />
                       <input type="button" value=">" onclick ="return GetNextProduct();" />
                   </td>
               </tr>
           </table>
       </div>
   </center>
    <script type="text/javascript">
        function GetPageSize(sel) {
            var val = sel.value;
            $.ajax({
                url: "Index.aspx/GetProductDetailsByPageSize",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({pageSize:val}),
                success: function (data) {
                    //console.log(val);
                    //console.log(data.d.length);
                    $("#data").empty();
                    // var Data = JSON.parse(data.d);
                    //var arr = Data.Table;
                    var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Id</th><th>Product Name<select id='#SortByProduct'><option selected='selected'>&darr;</option></select></th><th>Quantity per Unit</th><th>Unit Price</th></tr>";
                    for (var i = 0; i < data.d.length; i++) {
                        temp += "<tr>";
                        temp += "<td>" + "<label>" + data.d[i].ProductId + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].ProductName + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].QuantityPerUnit + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].UnitPrice + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].UnitsInStock + "</label>" + "</td>";
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
        }


        var count = 1;

        function GetNextProduct() {

            var pgVal = $("#drpPageSize").val();
            var gtPage = count;
            $("#GotoPage").val(++gtPage);
            $.ajax({
                url: "Index.aspx/GetNextProduct",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ pageSize: pgVal, nextProduct: count }),
                success: function (data) {

                    //console.log(val);
                    //console.log(data.d.length);
                    $("#data").empty();
                    // var Data = JSON.parse(data.d);
                    //var arr = Data.Table;
                    var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Id</th><th>Product Name<select id='#SortByProduct'><option selected='selected'>&darr;</option></select></th><th>Quantity per Unit</th><th>Unit Price</th></tr>";
                    for (var i = 0; i < data.d.length; i++) {
                        temp += "<tr>";
                        temp += "<td>" + "<label>" + data.d[i].ProductId + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].ProductName + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].QuantityPerUnit + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].UnitPrice + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].UnitsInStock + "</label>" + "</td>";
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
            count++;
        }

        function GetPreviousProduct() {
            --count;

            if (count <= 0) {
                count = 1;
            }
                console.log(count);
                var pgVal = $("#drpPageSize").val();
                var gtPrevPage = count;
                $("#GotoPage").val(gtPrevPage);
                $.ajax({
                    url: "Index.aspx/GetNextProduct",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ pageSize: pgVal, nextProduct: count-1 }),
                    success: function (data) {

                        //console.log(val);
                        //console.log(data.d.length);
                        $("#data").empty();
                        // var Data = JSON.parse(data.d);
                        //var arr = Data.Table;
                        var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Id</th><th>Product Name<select id='#SortByProduct'><option selected='selected'>&darr;</option></select></th><th>Quantity per Unit</th><th>Unit Price</th></tr>";
                        for (var i = 0; i < data.d.length; i++) {
                            temp += "<tr>";
                            temp += "<td>" + "<label>" + data.d[i].ProductId + "</label>" + "</td>";
                            temp += "<td>" + "<label>" + data.d[i].ProductName + "</label>" + "</td>";
                            temp += "<td>" + "<label>" + data.d[i].QuantityPerUnit + "</label>" + "</td>";
                            temp += "<td>" + "<label>" + data.d[i].UnitPrice + "</label>" + "</td>";
                            temp += "<td>" + "<label>" + data.d[i].UnitsInStock + "</label>" + "</td>";
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
          
        }

        //var regex = /^[a-zA-Z0-9]{3,200}$/i;
        //if (!regex.test($('#chk').val())) {
        //    alert("Please fill data currectly...");
        //}
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
                            $(this).append("<input type='text' id='chk' value='" + value + "' />");
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

            var pageVal = $("#drpPageSize").val();
            $.ajax({
                url: "Index.aspx/GetAllProducts",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ pageSize: pageVal }),
                success: function (data) {
                    $("#data").empty();
                   // var Data = JSON.parse(data.d);
                    //var arr = Data.Table;
                   // console.log(data.d.length);
                    var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Id</th><th>Product Name<select id='#SortByProduct'><option selected='selected'>&darr;</option></select></th><th>Quantity per Unit</th><th>Unit Price</th></tr>";
                    for (var i = 0; i < data.d.length; i++) {
                        temp += "<tr>";
                        temp += "<td>" + "<label>" + data.d[i].ProductId + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].ProductName + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].QuantityPerUnit + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].UnitPrice + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].UnitsInStock + "</label>" + "</td>";
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
