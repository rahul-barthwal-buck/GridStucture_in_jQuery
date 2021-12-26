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
using Newtonsoft.Json;

namespace GirdStructure
{
    public partial class Index : System.Web.UI.Page
    {
        private static string strConnectionString = ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString;
        private static SqlCommand _sqlCommand;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool DeleteProductDetails(int Id)
        {

            bool result = false;
            using (SqlConnection sqlconnection = new SqlConnection(strConnectionString))
            {
                sqlconnection.Open();
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

        [WebMethod]
        public static bool UpdateProductDetails(Products product)
        {
        
            bool result = false;
            using (SqlConnection sqlconnection = new SqlConnection(strConnectionString))
            {
                sqlconnection.Open();
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

        [WebMethod]
        public static List<Products> GetProductDetails(int pageSize, int nextOrPreviousProduct, string sortBy)
        {
            List<Products> productList = new List<Products>();
            productList.Clear();
            PagingAndSorting paging = new PagingAndSorting();
            paging.PageSize = pageSize;
            paging.NextOrPrevious = nextOrPreviousProduct;
            paging.SortBy = sortBy;
           
            using (SqlConnection sqlconnection = new SqlConnection(strConnectionString))
            {
                sqlconnection.Open();
                using (SqlCommand sqlCommand = new SqlCommand("sp_Get_ProductDetails", sqlconnection))
                {
                    sqlCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@PageSize", paging.PageSize);
                    sqlCommand.Parameters.AddWithValue("@NextOrPrevious", paging.NextOrPrevious);
                    sqlCommand.Parameters.AddWithValue("@SortBy", paging.SortBy);

                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        Products f = new Products();
                        f.ProductId = (int)reader["Product_Id"];
                        f.ProductName = (string)reader["Name"];
                        f.QuantityPerUnit = (int)reader["Quantity_Per_Unit"];
                        f.UnitPrice = (int)reader["Unit_Price"];
                        f.UnitsInStock = (int)reader["Units_In_Stock"];
                        productList.Add(f);
                    }
                    sqlconnection.Close();
                }
            }
            return productList;
        }

    }
}