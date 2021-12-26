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
        a{
            text-decoration:none;
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
        var count = 1;

        var clickedSortBy = "";
        
        function GetPageSize(sel) {

            var val = sel.value;
            var SortAscProductName = $("#SortByAscProductName").attr("id");
            var SortDescProductName = $("#SortByDescProductName").attr("id");
            var SortByAscQuantityperUnit = $("#SortByAscQuantityperUnit").attr("id");
            var SortByDescQuantityperUnit = $("#SortByDescQuantityperUnit").attr("id");
            var SortByAscUnitPrice = $("#SortByAscUnitPrice").attr("id");
            var SortByDescUnitPrice = $("#SortByDescUnitPrice").attr("id");

            if (clickedSortBy == SortAscProductName) {
                clickedSortBy = SortByAscProductName;
            }
            if (clickedSortBy == SortDescProductName) {
                clickedSortBy = SortDescProductName;
            }
            if (clickedSortBy == SortByAscQuantityperUnit) {
                clickedSortBy = SortByAscQuantityperUnit;
            }
            if (clickedSortBy == SortByDescQuantityperUnit) {
                clickedSortBy = SortByDescQuantityperUnit;
            }
            if (clickedSortBy == SortByAscUnitPrice) {
                clickedSortBy = SortByAscUnitPrice;
            }
            if (clickedSortBy == SortByDescUnitPrice) {
                clickedSortBy = SortByDescUnitPrice;
            }

            if (clickedSortBy == "") {
                clickedSortBy = null;
            }

            $.ajax({
                url: "Index.aspx/GetProductDetails",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ pageSize: val, nextOrPreviousProduct: count - 1, sortBy: clickedSortBy}),
                success: function (data) {
                    console.log("PageSize: " + val + ", nextOrPreviousProduct: " + (count - 1) + ", sortBy: " + clickedSortBy);
                    console.log("Data returned: " + data);
                    //console.log(val);
                    //console.log(data.d.length);
                    $("#data").empty();
                    // var Data = JSON.parse(data.d);
                    //var arr = Data.Table;
                    var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th onclick='SortByProductId();' >Product Id</th><th>Product Name&nbsp;&nbsp;<a href='#' id='SortByAscProductName' onclick='SortByAscProductName();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescProductName' onclick='SortByDescProductName();' style='font-size:20px;'>&darr;</a></th><th>Quantity per Unit&nbsp;&nbsp;<a href='#' id='SortByAscQuantityperUnit' onclick='SortByAscQuantityperUnit();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescQuantityperUnit' onclick='SortByDescQuantityperUnit();' style='font-size:20px;'>&darr;</a></th><th>Unit Price&nbsp;&nbsp;<a href='#' id='SortByAscUnitPrice' onclick='SortByAscUnitPrice();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescUnitPrice' onclick='SortByDescUnitPrice();' style='font-size:20px;'>&darr;</a></th></tr>";
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


       
        function GetNextProduct() {
            var SortAscProductName = $("#SortByAscProductName").attr("id");
            var SortDescProductName = $("#SortByDescProductName").attr("id");
            var SortByAscQuantityperUnit = $("#SortByAscQuantityperUnit").attr("id");
            var SortByDescQuantityperUnit = $("#SortByDescQuantityperUnit").attr("id");
            var SortByAscUnitPrice = $("#SortByAscUnitPrice").attr("id");
            var SortByDescUnitPrice = $("#SortByDescUnitPrice").attr("id");

            if (clickedSortBy == SortAscProductName) {
                clickedSortBy = SortByAscProductName;
            }
            if (clickedSortBy == SortDescProductName) {
                clickedSortBy = SortDescProductName;
            }
            if (clickedSortBy == SortByAscQuantityperUnit) {
                clickedSortBy = SortByAscQuantityperUnit;
            }
            if (clickedSortBy == SortByDescQuantityperUnit) {
                clickedSortBy = SortByDescQuantityperUnit;
            }
            if (clickedSortBy == SortByAscUnitPrice) {
                clickedSortBy = SortByAscUnitPrice;
            }
            if (clickedSortBy == SortByDescUnitPrice) {
                clickedSortBy = SortByDescUnitPrice;
            }

            if (clickedSortBy == "") {
                clickedSortBy = null;
            }

            var pgVal = $("#drpPageSize").val();
            var gtPage = count;
            $("#GotoPage").val(++gtPage);
            $.ajax({
                url: "Index.aspx/GetProductDetails",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ pageSize: pgVal, nextOrPreviousProduct: count, sortBy: clickedSortBy }),
                success: function (data) {

                    //console.log(data.d);
                    if (data.d.length <= 0) {
                        GetPreviousProduct();
                    } else {
                        $("#data").empty();
                        // var Data = JSON.parse(data.d);
                        //var arr = Data.Table;
                        var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th onclick='SortByProductId();' >Product Id</th><th>Product Name&nbsp;&nbsp;<a href='#' id='SortByAscProductName' onclick='SortByAscProductName();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescProductName' onclick='SortByDescProductName();' style='font-size:20px;'>&darr;</a></th><th>Quantity per Unit&nbsp;&nbsp;<a href='#' id='SortByAscQuantityperUnit' onclick='SortByAscQuantityperUnit();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescQuantityperUnit' onclick='SortByDescQuantityperUnit();' style='font-size:20px;'>&darr;</a></th><th>Unit Price&nbsp;&nbsp;<a href='#' id='SortByAscUnitPrice' onclick='SortByAscUnitPrice();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescUnitPrice' onclick='SortByDescUnitPrice();' style='font-size:20px;'>&darr;</a></th></tr>";
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
                    }
                },
                error: function (error) {
                    alert("Fail");
                }
            });
            count++;
        }

        function GetPreviousProduct() {
            var SortAscProductName = $("#SortByAscProductName").attr("id");
            var SortDescProductName = $("#SortByDescProductName").attr("id");
            var SortByAscQuantityperUnit = $("#SortByAscQuantityperUnit").attr("id");
            var SortByDescQuantityperUnit = $("#SortByDescQuantityperUnit").attr("id");
            var SortByAscUnitPrice = $("#SortByAscUnitPrice").attr("id");
            var SortByDescUnitPrice = $("#SortByDescUnitPrice").attr("id");

            if (clickedSortBy == SortAscProductName) {
                clickedSortBy = SortByAscProductName;
            }
            if (clickedSortBy == SortDescProductName) {
                clickedSortBy = SortDescProductName;
            }
            if (clickedSortBy == SortByAscQuantityperUnit) {
                clickedSortBy = SortByAscQuantityperUnit;
            }
            if (clickedSortBy == SortByDescQuantityperUnit) {
                clickedSortBy = SortByDescQuantityperUnit;
            }
            if (clickedSortBy == SortByAscUnitPrice) {
                clickedSortBy = SortByAscUnitPrice;
            }
            if (clickedSortBy == SortByDescUnitPrice) {
                clickedSortBy = SortByDescUnitPrice;
            }

            if (clickedSortBy == "") {
                clickedSortBy = null;
            }

            --count;

            if (count <= 0) {
                count = 1;
            }
               // console.log(count);
                var pgVal = $("#drpPageSize").val();
                var gtPrevPage = count;
                $("#GotoPage").val(gtPrevPage);
                $.ajax({
                    url: "Index.aspx/GetProductDetails",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ pageSize: pgVal, nextOrPreviousProduct: count-1, sortBy: clickedSortBy }),
                    success: function (data) {

                        //console.log(val);
                        //console.log(data.d.length);
                        $("#data").empty();
                        // var Data = JSON.parse(data.d);
                        //var arr = Data.Table;
                        var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th onclick='SortByProductId();' >Product Id</th><th>Product Name&nbsp;&nbsp;<a href='#' id='SortByAscProductName' onclick='SortByAscProductName();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescProductName' onclick='SortByDescProductName();' style='font-size:20px;'>&darr;</a></th><th>Quantity per Unit&nbsp;&nbsp;<a href='#' id='SortByAscQuantityperUnit' onclick='SortByAscQuantityperUnit();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescQuantityperUnit' onclick='SortByDescQuantityperUnit();' style='font-size:20px;'>&darr;</a></th><th>Unit Price&nbsp;&nbsp;<a href='#' id='SortByAscUnitPrice' onclick='SortByAscUnitPrice();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescUnitPrice' onclick='SortByDescUnitPrice();' style='font-size:20px;'>&darr;</a></th></tr>";
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

        function LoadTable() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;

            GetProductDetails(pageVal, countVal - 1, null);
        }

        $(function () {

            LoadTable();
           

        });


        function SortByDescProductName() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;
            var SortByDescProductName = $("#SortByDescProductName").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByDescProductName);
            clickedSortBy = SortByDescProductName;
            console.log(SortByDescProductName);
            console.log(countVal-1);
            console.log(pageVal);
        };

        function SortByAscProductName() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;
            var SortByAscProductName = $("#SortByAscProductName").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByAscProductName);
            clickedSortBy = SortByAscProductName;
            console.log(SortByAscProductName);
            console.log(countVal - 1);
            console.log(pageVal);
        };

        function SortByAscQuantityperUnit() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;
            var SortByAscQuantityperUnit = $("#SortByAscQuantityperUnit").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByAscQuantityperUnit);
            clickedSortBy = SortByAscQuantityperUnit;
            console.log(SortByAscQuantityperUnit);
            console.log(countVal - 1);
            console.log(pageVal);
        };

        function SortByDescQuantityperUnit() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;
            var SortByDescQuantityperUnit = $("#SortByDescQuantityperUnit").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByDescQuantityperUnit);
            clickedSortBy = SortByDescQuantityperUnit;
            console.log(SortByDescQuantityperUnit);
            console.log(countVal - 1);
            console.log(pageVal);
        };

        function SortByAscUnitPrice() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;
            var SortByAscUnitPrice = $("#SortByAscUnitPrice").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByAscUnitPrice);
            clickedSortBy = SortByAscUnitPrice;
            console.log(SortByAscUnitPrice);
            console.log(countVal - 1);
            console.log(pageVal);
        };

        function SortByDescUnitPrice() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;
            var SortByDescUnitPrice = $("#SortByDescUnitPrice").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByDescUnitPrice);
            clickedSortBy = SortByDescUnitPrice;
            console.log(SortByDescUnitPrice);
            console.log(countVal - 1);
            console.log(pageVal);
        };


        function SortByProductId() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;
            //var SortByProductId = $("#SortByProductId").attr("id");
            GetProductDetails(pageVal, countVal - 1, null);
            clickedSortBy = "";
            console.log(null);
            console.log(countVal - 1);
            console.log(pageVal);
        };

        function GetProductDetails(pgVal, counter, sortBy) {
            console.log("PageSize:" + pgVal + ", Count: " + counter + ", SortBy: " + sortBy);
            $.ajax({
                url: "Index.aspx/GetProductDetails",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ pageSize: pgVal, nextOrPreviousProduct: counter, sortBy: sortBy }),
                success: function (data) {
                    console.log(data);
                    $("#data").empty();
                    // var Data = JSON.parse(data.d);
                    //var arr = Data.Table;
                    // console.log(data.d.length);
                    var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='4'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='2' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th onclick='SortByProductId();' >Product Id</th><th>Product Name&nbsp;&nbsp;<a href='#' id='SortByAscProductName' onclick='SortByAscProductName();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescProductName' onclick='SortByDescProductName();' style='font-size:20px;'>&darr;</a></th><th>Quantity per Unit&nbsp;&nbsp;<a href='#' id='SortByAscQuantityperUnit' onclick='SortByAscQuantityperUnit();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescQuantityperUnit' onclick='SortByDescQuantityperUnit();' style='font-size:20px;'>&darr;</a></th><th>Unit Price&nbsp;&nbsp;<a href='#' id='SortByAscUnitPrice' onclick='SortByAscUnitPrice();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescUnitPrice' onclick='SortByDescUnitPrice();' style='font-size:20px;'>&darr;</a></th></tr>";
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
    </script>
</body>
</html>
