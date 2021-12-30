<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GirdStructure.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Grid Structure</title>
     <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
      <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"/>
      <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link href="Index.css" rel="stylesheet" />
    
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
                       <input type="text" class="GotoPage" value="1"  id="GotoPage"/>
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
       <br />
       <br />
       <div style="font-weight:bold;">
           <h3>User Manual</h3>
           <ol>
               <li>For Sorting click on the arrows in the grid. ( for Ascending click up arrow and for Descending click down arrow )</li>
               <li>When Click on any arrow then pagination will be peformed according to the arrow clicked for sorting and when user click next or previous button it shows result according to the sorting</li>
               <li>By Selecting the Dropdown the Details will be displayed the Grid </li>
               <li>For Editing the Row values in Table, An Inline Editing is done. For checking clicks on Edit button in any row of table</li>
               <li>If don't want to Edit Details after clicking Edit button, and Cancel Update Display. Click on it to cancle the recent changes</li>
           </ol>
       </div>
       <div id="dialog" title="Title from my div element">
           Dialog text
       </div>
        <div id="dialog2" title="Title from my div element">
           Dialog text 2
       </div>

    <script type="text/javascript">
        //Count for paging
        var count = 1;

        //It stored the id of the anchor tag for asc and desc 
        var clickedSortBy = "";

        //This function will be called when dropdown for pageszie will be select
        function GetPageSize(sel) {

            let val = sel.value;

            //Below code is fetching the Id from anchor tags of Id
            let SortAscProductName = $("#SortByAscProductName").attr("id");
            let SortDescProductName = $("#SortByDescProductName").attr("id");
            let SortAscQuantityperUnit = $("#SortByAscQuantityperUnit").attr("id");
            let SortDescQuantityperUnit = $("#SortByDescQuantityperUnit").attr("id");
            let SortAscUnitPrice = $("#SortByAscUnitPrice").attr("id");
            let SortDescUnitPrice = $("#SortByDescUnitPrice").attr("id");

            //If clikedSortBy is equal to Ids attr then set clickedSortby with the Id atrr value
            if (clickedSortBy == SortAscProductName) {
                clickedSortBy = SortByAscProductName;
            }
            if (clickedSortBy == SortDescProductName) {
                clickedSortBy = SortDescProductName;
            }
            if (clickedSortBy == SortAscQuantityperUnit) {
                clickedSortBy = SortAscQuantityperUnit;
            }
            if (clickedSortBy == SortDescQuantityperUnit) {
                clickedSortBy = SortDescQuantityperUnit;
            }
            if (clickedSortBy == SortAscUnitPrice) {
                clickedSortBy = SortAscUnitPrice;
            }
            if (clickedSortBy == SortDescUnitPrice) {
                clickedSortBy = SortDescUnitPrice;
            }

            if (clickedSortBy == "") {
                clickedSortBy = null;
            }

            //Below ajax code will be executed when this function is called
            $.ajax({
                url: "Index.aspx/GetProductDetails",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ pageSize: val, nextOrPreviousProduct: count - 1, sortBy: clickedSortBy}),
                success: function (data) {
                    //To remove previous enteries from the table and div.First we need to empty that div.
                    $("#data").empty();
                 
                    var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='3'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='3' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Name&nbsp;&nbsp;<a href='#' id='SortByAscProductName' onclick='SortByAscProductName();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescProductName' onclick='SortByDescProductName();' style='font-size:20px;'>&darr;</a></th><th>Quantity per Unit&nbsp;&nbsp;<a href='#' id='SortByAscQuantityperUnit' onclick='SortByAscQuantityperUnit();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescQuantityperUnit' onclick='SortByDescQuantityperUnit();' style='font-size:20px;'>&darr;</a></th><th>Unit Price&nbsp;&nbsp;<a href='#' id='SortByAscUnitPrice' onclick='SortByAscUnitPrice();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescUnitPrice' onclick='SortByDescUnitPrice();' style='font-size:20px;'>&darr;</a></th></tr>";
                    for (var i = 0; i < data.d.length; i++) {
                        temp += "<tr>";

                        //Below taking input filed hiiden for Product Id so that it can help in operations and not visible to the user.
                        temp += "<input type='hidden' id='Prod_Id' value='" + data.d[i].ProductId + "'>";

                        temp += "<td>" + "<label>" + data.d[i].ProductName + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].QuantityPerUnit + "</label>" + "</td>";
                        temp += "<td>" + "<b>&dollar;</b><label>" + data.d[i].UnitPrice + ".00</label>" + "</td>";
                        temp += "<td>" + "<label id='chkUnitInStock'>" + data.d[i].UnitsInStock + "</label>" + "</td>";
                        temp += "<td><input type='button' class='btn btn-success' itag='Edit' value='Edit' onclick='return EditProductDetails(this)'/></td>";
                        temp += "<td><input type='button' class='btn btn-danger' itag='Delete' value='Delete' onclick='return DeleteProductDetails(this);'/></td>";
                        temp += "</tr>";
                    }

                    //Appending the temp varibale which contain table in th data div.
                    $("#data").append(temp);

                },
                error: function (error) {
                    $("#dialog").dialog({
                        title: "Error"
                    });
                    $("#dialog").html("Something went wrong, you should choose again!").dialog("open");
                }
            });
        }


        function GetNextProduct() {
            let SortAscProductName = $("#SortByAscProductName").attr("id");
            let SortDescProductName = $("#SortByDescProductName").attr("id");
            let SortAscQuantityperUnit = $("#SortByAscQuantityperUnit").attr("id");
            let SortDescQuantityperUnit = $("#SortByDescQuantityperUnit").attr("id");
            let SortAscUnitPrice = $("#SortByAscUnitPrice").attr("id");
            let SortDescUnitPrice = $("#SortByDescUnitPrice").attr("id");

            if (clickedSortBy == SortAscProductName) {
                clickedSortBy = SortAscProductName;
            }
            if (clickedSortBy == SortDescProductName) {
                clickedSortBy = SortDescProductName;
            }
            if (clickedSortBy == SortAscQuantityperUnit) {
                clickedSortBy = SortAscQuantityperUnit;
            }
            if (clickedSortBy == SortDescQuantityperUnit) {
                clickedSortBy = SortDescQuantityperUnit;
            }
            if (clickedSortBy == SortAscUnitPrice) {
                clickedSortBy = SortAscUnitPrice;
            }
            if (clickedSortBy == SortDescUnitPrice) {
                clickedSortBy = SortDescUnitPrice;
            }

            if (clickedSortBy == "") {
                clickedSortBy = null;
            }

            //Below pgVal is used to fecth the value from DropDown for page size
            var pgVal = $("#drpPageSize").val();

            //gtPage is used to used to set the count value and show it into the GotoPage Id and due to this Page number will show when user click next in pagination
            var gtPage = count;
            $("#GotoPage").val(++gtPage);

            $.ajax({
                url: "Index.aspx/GetProductDetails",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ pageSize: pgVal, nextOrPreviousProduct: count, sortBy: clickedSortBy }),
                success: function (data) {

                    //If user click previous button and if user reach last page then to prevent it from error it call the GetPreviousProduct and  then Its shows the inital page
                    if (data.d.length <= 0) {
                        GetPreviousProduct();
                    } else {
                        //If user does not reach the last page then below code will run.
                        $("#data").empty();
                 
                        var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='3'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='3' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Name&nbsp;&nbsp;<a href='#' id='SortByAscProductName' onclick='SortByAscProductName();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescProductName' onclick='SortByDescProductName();' style='font-size:20px;'>&darr;</a></th><th>Quantity per Unit&nbsp;&nbsp;<a href='#' id='SortByAscQuantityperUnit' onclick='SortByAscQuantityperUnit();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescQuantityperUnit' onclick='SortByDescQuantityperUnit();' style='font-size:20px;'>&darr;</a></th><th>Unit Price&nbsp;&nbsp;<a href='#' id='SortByAscUnitPrice' onclick='SortByAscUnitPrice();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescUnitPrice' onclick='SortByDescUnitPrice();' style='font-size:20px;'>&darr;</a></th></tr>";
                        for (var i = 0; i < data.d.length; i++) {
                            temp += "<tr>";
                         
                            temp += "<input type='hidden' id='Prod_Id' value='" + data.d[i].ProductId + "'>";
                            temp += "<td>" + "<label>" + data.d[i].ProductName + "</label>" + "</td>";
                            temp += "<td>" + "<label>" + data.d[i].QuantityPerUnit + "</label>" + "</td>";
                            temp += "<td>" + "<b>&dollar;</b><label>" + data.d[i].UnitPrice + ".00</label>" + "</td>";
                            temp += "<td>" + "<label id='chkUnitInStock'>" + data.d[i].UnitsInStock + "</label>" + "</td>";
                            temp += "<td><input type='button' class='btn btn-success' itag='Edit' value='Edit' onclick='return EditProductDetails(this)'/></td>";
                            temp += "<td><input type='button' class='btn btn-danger' itag='Delete' value='Delete' onclick='return DeleteProductDetails(this);'/></td>";
                            temp += "</tr>";
                        }

                        $("#data").append(temp);
          
                    }
                },
                error: function (error) {
                    $("#dialog").dialog({
                        title: "Error"
                    });
                    $("#dialog").html("Something went wrong, you should choose again!").dialog("open");
                }
            });
            count++;
        }

        function GetPreviousProduct() {
            let SortAscProductName = $("#SortByAscProductName").attr("id");
            let SortDescProductName = $("#SortByDescProductName").attr("id");
            let SortAscQuantityperUnit = $("#SortByAscQuantityperUnit").attr("id");
            let SortDescQuantityperUnit = $("#SortByDescQuantityperUnit").attr("id");
            let SortAscUnitPrice = $("#SortByAscUnitPrice").attr("id");
            let SortDescUnitPrice = $("#SortByDescUnitPrice").attr("id");

            if (clickedSortBy == SortAscProductName) {
                clickedSortBy = SortAscProductName;
            }
            if (clickedSortBy == SortDescProductName) {
                clickedSortBy = SortDescProductName;
            }
            if (clickedSortBy == SortAscQuantityperUnit) {
                clickedSortBy = SortAscQuantityperUnit;
            }
            if (clickedSortBy == SortDescQuantityperUnit) {
                clickedSortBy = SortDescQuantityperUnit;
            }
            if (clickedSortBy == SortAscUnitPrice) {
                clickedSortBy = SortAscUnitPrice;
            }
            if (clickedSortBy == SortDescUnitPrice) {
                clickedSortBy = SortDescUnitPrice;
            }

            if (clickedSortBy == "") {
                clickedSortBy = null;
            }

            //when user click previous button and GetPreviousProduct function call then count value decreases and with the help of this previous value will be fetched and also helps in pagination
            --count;

            //If count value is less than or equal to 0 then it it set the count value to 1 and inital pag of table and values will be displayed to avoid error.
            if (count <= 0) {
                count = 1;
            }
       
            var pgVal = $("#drpPageSize").val();
            
                var gtPrevPage = count;
            $("#GotoPage").val(gtPrevPage);
                //below ajax code will be called when GetPreviousProducts function called
                $.ajax({
                    url: "Index.aspx/GetProductDetails",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ pageSize: pgVal, nextOrPreviousProduct: count-1, sortBy: clickedSortBy }),
                    success: function (data) {
                        $("#data").empty();

                        var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='3'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='3' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Name&nbsp;&nbsp;<a href='#' id='SortByAscProductName' onclick='SortByAscProductName();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescProductName' onclick='SortByDescProductName();' style='font-size:20px;'>&darr;</a></th><th>Quantity per Unit&nbsp;&nbsp;<a href='#' id='SortByAscQuantityperUnit' onclick='SortByAscQuantityperUnit();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescQuantityperUnit' onclick='SortByDescQuantityperUnit();' style='font-size:20px;'>&darr;</a></th><th>Unit Price&nbsp;&nbsp;<a href='#' id='SortByAscUnitPrice' onclick='SortByAscUnitPrice();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescUnitPrice' onclick='SortByDescUnitPrice();' style='font-size:20px;'>&darr;</a></th></tr>";
                        for (var i = 0; i < data.d.length; i++) {
                            temp += "<tr>";

                            temp += "<input type='hidden' id='Prod_Id' value='" + data.d[i].ProductId + "'>";
                            temp += "<td>" + "<label>" + data.d[i].ProductName + "</label>" + "</td>";
                            temp += "<td>" + "<label>" + data.d[i].QuantityPerUnit + "</label>" + "</td>";
                            temp += "<td>" + "<b>&dollar;</b><label>" + data.d[i].UnitPrice + ".00</label>" + "</td>";
                            temp += "<td>" + "<label id='chkUnitInStock'>" + data.d[i].UnitsInStock + "</label>" + "</td>";
                            temp += "<td><input type='button' class='btn btn-success' itag='Edit' value='Edit' onclick='return EditProductDetails(this)'/></td>";
                            temp += "<td><input type='button' class='btn btn-danger' itag='Delete' value='Delete' onclick='return DeleteProductDetails(this);'/></td>";
                            temp += "</tr>";
                        }

                        $("#data").append(temp);
          
                    },
                    error: function (error) {
                        $("#dialog").dialog({
                            title: "Error"
                        });
                        $("#dialog").html("Something went wrong, you should choose again!").dialog("open");
                    }
                });
          
        }

       
        function DeleteProductDetails(control) {
            //Info is used to pass as data into the ajax code.

            //Here control comes from the From when user pressed Delete button.
            //Closest is the function which allows us to find the closest element in DOM that allow us to identify based on selector.
            //Find is used to find the inner elements of the selected element

            console.log($(control).closest("tr").find("input[type='hidden']").val());
            var Info = {
                Id: $(control).closest("tr").find("input[type='hidden']").val()
            };

            $("#dialog2").dialog({
                title: "Success",
                draggable: false,
                resizeable: false,
                closeOnEscape: false,
                modal: true,
                autoOpen: false,
                buttons: {
                    OK: function () {
                        $.ajax({
                            url: "Index.aspx/DeleteProductDetails",
                            type: "POST",
                            contentType: "application/json;charset=utf-8",
                            dataType: "json",
                            data: JSON.stringify(Info),
                            success: function (data) {

                                $("#dialog").html("Data Deleted Successfully...").dialog("open");

                                $(control).closest("tr").remove();
                                LoadTable();
                            },
                            error: function (error) {
                           
                                $("#dialog").dialog({
                                    title: "Error"
                                });
                                $("#dialog").html("Something went wrong, you should choose again!").dialog("open");

                            }
                        });
                        $(this).dialog("close");
                    },
                    Cancel: function () { $(this).dialog("close"); }
                },
                height: 200,
                width:650
            });

            $("#dialog2").html("Once deleted, you will not be able to recover this Product Details!").dialog("open");

        }

        function CancelUpdate(control) {
            $("#dialog2").dialog({
                title: "Cancelled",
                draggable: false,
                resizeable: false,
                closeOnEscape: false,
                modal: true,
                autoOpen: false,
                buttons: {
                    OK: function () {
                        let j = 0;
                        $(control).closest("tr").find("td").each(function (control) {

                            if (j < 4) {

                                if ($(this).find("input").length > 0) {

                                    var value = $(this).find("input").val();

                                    $(this).find("input").hide();
                                    $(this).append("<label>" + value + "</label>");
                                }

                            } else {
                                return false;
                            }
                            j++;
                     
                        });
                        $(control).closest("tr").find("input[itag='Edit']").val("Edit");
                        $(control).closest("tr").find("td:eq(6)").remove();
                        $("#dialog").html("Cancel Updation").dialog("open");
                        $(this).dialog("close");

                    },
                    Cancel: function () { $(this).dialog("close"); }
                }
            });

            $("#dialog2").html("Are you sure to Cancel Update ?").dialog("open");
        }


        //Below function is called when user clicks Edit button
        function EditProductDetails(control) {
            //If the value of Button is Edit then Below If condition runs 
            if ($(control).val() == "Edit") {

                let i = 0;

                //Here we are finding all the td tags from the tr one by one.
                $(control).closest("tr").find("td").each(function (control) {
                    if (i < 4) {
                        //If length of label is greater than 0 means its not empty then below if condition runs
                        if ($(this).find("label").length > 0) {
                            //Here value variable stores the lable html value
                            var value = $(this).find("label").html();
                            //And Then hide then label and replace it with input tag for updating the value
                            $(this).find("label").hide();
                            $(this).append("<input type='text' id='Val" + i + "' value='" + value + "' />");
                        }
                       
                        //Here Value of Edit button is changed From Edit to Update and to defined Edit button uniquely. Here uses itag is as attribute in button.
                        // $(this).find("input[itag='Edit']").val("Update");
                        $(this).closest("tr").find("td:eq(4)").find("input").val("Update");
                    } else {
                        return false;
                    }
                    i++;
                 
                });

         
                var newrow = "<td class='CancelUpdate'><input type='button' class='btn btn-primary' itag='CancelEdit' value='Cancel Update' onclick='return CancelUpdate(this);'/></td>";
                $(control).closest("tr").find("td:eq(5)").after(newrow);

            }
            //If the value of Button is Not Edit ( in this case it becomes Update) then below else code will run
            else {
   
               //Below Prdt_name,QtyPerUnit,Unit_Price,Units_In_Stock varibale are used for validation purpose 
                var Prd_Name = $("#Val0").val();
                var QtyPerUnit = $("#Val1").val();
                var Unit_Price = $("#Val2").val();
                var Units_In_Stock = $("#Val3").val();
                //regex1 is used for Product Name
                var regex1 = /^[a-zA-Z0-9\s]{3,30}$/;
                //regex2 is used for Quantity per unit, Units in Stock
                var regex2 = /^[1-9]{1}[0-9]{0,10}$/;
                //regex3 is used for Unit Price
                var regex3 = /^[1-9]{1}[0-9]{0,10}\.[0-9]{2}$/;;

                //If all or any one of them is empty then below if condition runs
                if (Prd_Name == "" || QtyPerUnit == "" || Unit_Price == "" || Units_In_Stock == "") {

                    $("#dialog").dialog({
                        title:"Error"
                    });
                    $("#dialog").html("All Fields is required!").dialog("open");
                }
                //if Product Name does not matches the required expression then below code runs
                else if (!regex1.test(Prd_Name)) {
                    $("#dialog").dialog({
                        title: "Error"
                    });
                    $("#dialog").html("Product Name only contain alphabets or Character length must between 3 and 30 !").dialog("open");
                }
                //if Qunatity per unit does not matches the required expression then below code runs
                else if (!regex2.test(QtyPerUnit)) {
                    $("#dialog").dialog({
                        title: "Error"
                    });
                    $("#dialog").html("Quantity Per Unit must be number! and and must be less than 10 digit!").dialog("open");
                }
                 //if Unit price does not matches the required expression then below code runs
                else if (!regex3.test(Unit_Price)) {
                    $("#dialog").dialog({
                        title: "Error"
                    });
                    $("#dialog").html("Unit Price must be decimal! and and must be less than 12 digit!").dialog("open");
                }
                 //if Units in stock does not matches the required expression then below code runs
                else if (!regex2.test(Units_In_Stock)) {
                    $("#dialog").dialog({
                        title: "Error"
                    });
                    $("#dialog").html("Units In Stock must be number! and and must be less than 10 digit!").dialog("open");
                }
                //If all the required regular expression are true then below code will run
                else {

                    $(control).closest("tr").find("td:eq(6)").remove();

                        //Here Info is used to send the data into the ajax code
                        var Info = {
                            ProductId:  $(control).closest("tr").find("input[type='hidden']").val(),
                            ProductName: $(control).closest("tr").find("td:nth-child(2)").find("input").val(),
                            QuantityPerUnit: $(control).closest("tr").find("td:nth-child(3)").find("input").val(),
                            UnitPrice: $(control).closest("tr").find("td:nth-child(4)").find("input").val(),
                            UnitsInStock: $(control).closest("tr").find("td:nth-child(5)").find("input").val()
                        };

                        //Below ajax code will run when Update button clicks and all the required constraints are true.
                        $.ajax({
                            url: "Index.aspx/UpdateProductDetails",
                            type: "POST",
                            contentType: "application/json;charset=utf-8",
                            dataType: "json",
                            data: JSON.stringify({ product: Info }),
                            success: function (data) {
                                //Here firstly fetching the value from input tag  and storing them into a varibale
                                //Then removing that input tag
                                //Then appending the label instead of input tag which was displayed when user clicked on Update button which comes after Edit
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

                                //After Changing all Input tag to label below code will change the value of Update button to its previous value which is Edit
                                
                                $(control).val("Edit");

                                $("#dialog").html("Data updated successfully...").dialog("open");
                            },
                            error: function (error) {

                                //console.log(error);
                                $("#dialog").dialog({
                                    title: "Error"
                                });
                                $("#dialog").html("Something went wrong, you should choose again!").dialog("open");
                            }

                        });


                }

               
            }
        }

        //LoadTable will be called when our page loads
        function LoadTable() {
            var pageVal = $("#drpPageSize").val();

            var countVal = count;
            //Here passing the inital value of page size and count value into the GetProductDetails function for pagination
            //Here null is passed because at inital no sorting is preformed
            GetProductDetails(pageVal, countVal - 1, null);
        }

        $(function () {

            //LoadTbale function calling to load inital view of table into the page
            LoadTable();

            $("#dialog").dialog({
                title: "Success",
                draggable: false,
                resizeable: false,
                closeOnEscape: false,
                modal: true,
                autoOpen: false,
                buttons: {
                    OK: function () { $(this).dialog("close"); }
                },
                height: 250,
                width:500,
            });
            $("#dialog2").dialog({
                title: "Operations",
                draggable: false,
                resizeable: false,
                closeOnEscape: false,
                modal: true,
                autoOpen: false
            });
        });

        //below function called when user clicks down arrow in the ProductName 
        function SortByDescProductName() {
            let pageVal = $("#drpPageSize").val();

            let countVal = count;
            let SortByDescProductName = $("#SortByDescProductName").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByDescProductName);
            clickedSortBy = SortByDescProductName;
        };

        //below function called when user clicks up arrow in the ProductName 
        function SortByAscProductName() {
            let pageVal = $("#drpPageSize").val();
            let countVal = count;
            let SortByAscProductName = $("#SortByAscProductName").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByAscProductName);
            clickedSortBy = SortByAscProductName;
        };

        //below function called when user clicks up arrow in the Quantity per Unit 
        function SortByAscQuantityperUnit() {
            let pageVal = $("#drpPageSize").val();

            let countVal = count;
            let SortByAscQuantityperUnit = $("#SortByAscQuantityperUnit").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByAscQuantityperUnit);
            clickedSortBy = SortByAscQuantityperUnit;
        };

        //below function called when user clicks down arrow in the Quantity per Unit 
        function SortByDescQuantityperUnit() {
            let pageVal = $("#drpPageSize").val();

            let countVal = count;
            let SortByDescQuantityperUnit = $("#SortByDescQuantityperUnit").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByDescQuantityperUnit);
            clickedSortBy = SortByDescQuantityperUnit;
        };

        //below function called when user clicks up arrow in the Unit Price 
        function SortByAscUnitPrice() {
            let pageVal = $("#drpPageSize").val();

            let countVal = count;
            let SortByAscUnitPrice = $("#SortByAscUnitPrice").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByAscUnitPrice);
            clickedSortBy = SortByAscUnitPrice;
        };

        //below function called when user clicks down arrow in the Unit Price 
        function SortByDescUnitPrice() {
            let pageVal = $("#drpPageSize").val();

            let countVal = count;
            let SortByDescUnitPrice = $("#SortByDescUnitPrice").attr("id");
            GetProductDetails(pageVal, countVal - 1, SortByDescUnitPrice);
            clickedSortBy = SortByDescUnitPrice;
        };


        //Below is function to fetch all the product details and pgVal is paramter to get PageSize and counter to get count varibale value and sortBy to get the Id attr value of Sorting
        function GetProductDetails(pgVal, counter, sortBy) {
       
            $.ajax({
                url: "Index.aspx/GetProductDetails",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ pageSize: pgVal, nextOrPreviousProduct: counter, sortBy: sortBy }),
                success: function (data) {
                   
                    $("#data").empty();
                    //Prod_Id.length = 0;
                    var temp = "<table style='width:800px;' class='table table-bordered table-striped table-sm prdtable' border='1'><tr style='text-align:center;'><th colspan='3'>Product Details</th><th  rowspan='2' style='padding-top:20px;'>Units In Stock</th><th colspan='3' rowspan='2' style='padding-top:20px;'>Operations</th></tr><tr><th>Product Name&nbsp;&nbsp;<a href='#' id='SortByAscProductName' onclick='SortByAscProductName();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescProductName' onclick='SortByDescProductName();' style='font-size:20px;'>&darr;</a></th><th>Quantity per Unit&nbsp;&nbsp;<a href='#' id='SortByAscQuantityperUnit' onclick='SortByAscQuantityperUnit();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescQuantityperUnit' onclick='SortByDescQuantityperUnit();' style='font-size:20px;'>&darr;</a></th><th>Unit Price&nbsp;&nbsp;<a href='#' id='SortByAscUnitPrice' onclick='SortByAscUnitPrice();' style='font-size:20px;'>&uarr;</a>&nbsp;<a href='#' id='SortByDescUnitPrice' onclick='SortByDescUnitPrice();' style='font-size:20px;'>&darr;</a></th></tr>";
                    for (var i = 0; i < data.d.length; i++) {
                        temp += "<tr>";

                        temp += "<input type='hidden' id='Prod_Id' value='" + data.d[i].ProductId + "'>";
                        temp += "<td>" + "<label>" + data.d[i].ProductName + "</label>" + "</td>";
                        temp += "<td>" + "<label>" + data.d[i].QuantityPerUnit + "</label>" + "</td>";
                        temp += "<td>" + "<b>&dollar;</b><label>"+ data.d[i].UnitPrice + ".00</label>" + "</td>";
                        temp += "<td>" + "<label class='chkUnitInStock'>" + data.d[i].UnitsInStock + "</label>" + "</td>";
                        temp += "<td><input type='button' class='btn btn-success' itag='Edit' value='Edit' onclick='return EditProductDetails(this)'/></td>";
                        temp += "<td><input type='button' class='btn btn-danger' itag='Delete' value='Delete' onclick='return DeleteProductDetails(this);'/></td>";
                        temp += "</tr>";

                    }
                    $("#data").append(temp);
                },
                error: function (error) {
                    $("#dialog").dialog({
                        title: "Error"
                    });
                    $("#dialog").html("Something went wrong, you should choose again!").dialog("open");
                }
            });
        }
    </script>
</body>
</html>
