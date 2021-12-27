using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace GirdStructure
{
    public partial class Index : System.Web.UI.Page
    {
        private static string strConnectionString = ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString;
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //Below DeleteProductDetails web method is used to delete the product details by Id of that Product
        [WebMethod]
        public static bool DeleteProductDetails(int Id)
        {

            bool result = false;
            using (SqlConnection sqlconnection = new SqlConnection(strConnectionString))
            {
                sqlconnection.Open();
                
                // here sp_Delete_ProductDetails Stored procedure is used to delete that product details
                using (SqlCommand sqlCommand = new SqlCommand("sp_Delete_ProductDetails", sqlconnection))
                {
                    sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add(new SqlParameter("@ProductId", Id));

                    int rowsDeleteCount = sqlCommand.ExecuteNonQuery();
                    if (rowsDeleteCount != 0)
                        result = true;
                }
            }
            return result;
        }

        //Below UpdateProductDetails web method is used to Update the values of Product
        [WebMethod]
        public static bool UpdateProductDetails(Products product)
        {
        
            bool result = false;
            using (SqlConnection sqlconnection = new SqlConnection(strConnectionString))
            {
                sqlconnection.Open();
                // here sp_Update_ProductDetails Stored procedure is used to update that product details
                using (SqlCommand sqlCommand = new SqlCommand("sp_Update_ProductDetails", sqlconnection))
                {
                    sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@ProductName", product.ProductName);
                    sqlCommand.Parameters.AddWithValue("@QuantityPerUnit", product.QuantityPerUnit);
                    sqlCommand.Parameters.AddWithValue("@UnitPrice", product.UnitPrice);
                    sqlCommand.Parameters.AddWithValue("@UnitsInStock", product.UnitsInStock);
                    sqlCommand.Parameters.AddWithValue("@ProductId", product.ProductId);

                    int rowsDeleteCount = sqlCommand.ExecuteNonQuery();
                    if (rowsDeleteCount != 0)
                        result = true;
                }
            }
            return result;

        }

        //Below GetProductDetails web method is used to fetch the ProductDetails. Here paramters such as pageSize is used to get the page size from the dropdown select tag and nextOrPreviousProduct is used to get the value from next or previous button of pagination and sortBy is used to get the value from sorting attr applied to the table th tag for each column
        [WebMethod]
        public static List<Products> GetProductDetails(int pageSize, int nextOrPreviousProduct, string sortBy)
        {
            //List of product type model class is used to get and set the values.
            List<Products> productList = new List<Products>();
            productList.Clear();
            //Below PagindAndSorting object is created to get and set the value of pageSize and nextOrPreviousProduct value and then use them in our Stored Procedure
            PagingAndSorting paging = new PagingAndSorting();
            paging.PageSize = pageSize;
            paging.NextOrPrevious = nextOrPreviousProduct;
            paging.SortBy = sortBy;
           
            using (SqlConnection sqlconnection = new SqlConnection(strConnectionString))
            {
                sqlconnection.Open();
                // here sp_Get_ProductDetails Stored procedure is used to get all the product details
                using (SqlCommand sqlCommand = new SqlCommand("sp_Get_ProductDetails", sqlconnection))
                {
                    sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@PageSize", paging.PageSize);
                    sqlCommand.Parameters.AddWithValue("@NextOrPrevious", paging.NextOrPrevious);
                    sqlCommand.Parameters.AddWithValue("@SortBy", paging.SortBy);

                    //Here Using SQLReader is used which is connection oriented and here using because no updation performed in this function.
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        //Here the returend object is type casted into respective data type and thenm stored in the model class varibale and then added into the List of Product type and then returen the list object for displaying the data 
                        Products product = new Products();
                        product.ProductId = (int)reader["Product_Id"];
                        product.ProductName = (string)reader["Name"];
                        product.QuantityPerUnit = (int)reader["Quantity_Per_Unit"];
                        product.UnitPrice = (decimal)reader["Unit_Price"];
                        product.UnitsInStock = (int)reader["Units_In_Stock"];
                        productList.Add(product);
                    }
                    sqlconnection.Close();
                }
            }
            return productList;
        }

    }
}