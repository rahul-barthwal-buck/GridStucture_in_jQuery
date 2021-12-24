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
        public static List<Products> GetAllProducts(int pageSize)
        {

            List<Products> productList = new List<Products>();
            productList.Clear();
            PagingAndSorting paging = new PagingAndSorting();
            paging.PageSize = pageSize;
            using (SqlConnection cn = new SqlConnection(strConnectionString))
            {
                cn.Open();
                SqlCommand sqlCommand = new SqlCommand("SELECT TOP(@PageSize) Product_Id,Name,Quantity_Per_Unit,Unit_Price,Units_In_Stock FROM ProductDetails", cn);
                sqlCommand.Parameters.AddWithValue("@PageSize", paging.PageSize);
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
                cn.Close();
            }
            return productList;


        }

        [WebMethod]
        public static bool DeleteProductDetails(int Id)
        {
            try
            {
                SqlConnection _sqlConnection = new SqlConnection(strConnectionString);
                _sqlConnection.Open();
                SqlCommand _sqlCommand = new SqlCommand("DELETE FROM ProductDetails WHERE Product_Id=" + Id, _sqlConnection);
                _sqlCommand.ExecuteNonQuery();
                _sqlConnection.Close();

            }
            catch (Exception e)
            {
                return false;
            }
            return true;
        }

        [WebMethod]
        public static bool UpdateProductDetails(Products product)
        {
            try
            {
                SqlConnection _sqlConnection = new SqlConnection(strConnectionString);
                _sqlConnection.Open();
                SqlCommand _sqlCommand = new SqlCommand("UPDATE ProductDetails SET Name=@ProductName,Quantity_Per_Unit=@QuantityPerUnit,Unit_Price=@UnitPrice, Units_In_Stock=@UnitsInStock WHERE Product_Id=@ProductId", _sqlConnection);
                _sqlCommand.Parameters.AddWithValue("@ProductName", product.ProductName);
                _sqlCommand.Parameters.AddWithValue("@QuantityPerUnit", product.QuantityPerUnit);
                _sqlCommand.Parameters.AddWithValue("@UnitPrice", product.UnitPrice);
                _sqlCommand.Parameters.AddWithValue("@UnitsInStock", product.UnitsInStock);
                _sqlCommand.Parameters.AddWithValue("@ProductId", product.ProductId);
                _sqlCommand.ExecuteNonQuery();
                _sqlConnection.Close();

            }
            catch (Exception e)
            {
                return false;
            }
            return true;
        }


        [WebMethod]
        public static List<Products> GetProductDetailsByPageSize(int pageSize)
        {
            List<Products> productList = new List<Products>();
            productList.Clear();
            PagingAndSorting paging = new PagingAndSorting();
            paging.PageSize = pageSize;
            using (SqlConnection cn = new SqlConnection(strConnectionString))
            {
                cn.Open();
                SqlCommand sqlCommand = new SqlCommand("SELECT TOP(@PageSize) Product_Id,Name,Quantity_Per_Unit,Unit_Price,Units_In_Stock FROM ProductDetails", cn);
                sqlCommand.Parameters.AddWithValue("@PageSize",paging.PageSize);
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
                cn.Close();
            }
            return productList;
        }


        [WebMethod]
        public static List<Products> GetNextProduct(int pageSize, int nextProduct)
        {
            List<Products> productList = new List<Products>();
            productList.Clear();
            PagingAndSorting paging = new PagingAndSorting();
            paging.PageSize = pageSize;
            paging.NextProduct = nextProduct;
            using (SqlConnection cn = new SqlConnection(strConnectionString))
            {
                cn.Open();
                SqlCommand sqlCommand = new SqlCommand("SELECT Product_Id,Name,Quantity_Per_Unit,Unit_Price,Units_In_Stock FROM ProductDetails ORDER BY  Product_Id,Name,Quantity_Per_Unit,Unit_Price,Units_In_Stock OFFSET (@PageSize*@NextProduct) ROWS FETCH NEXT (@PageSize) ROWS ONLY", cn);
                sqlCommand.Parameters.AddWithValue("@PageSize", paging.PageSize);
                sqlCommand.Parameters.AddWithValue("@NextProduct", paging.NextProduct);
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
                cn.Close();
            }
            return productList;
        }


        [WebMethod]
        public static List<Products> GetPreviousProduct(int pageSize, int nextProduct)
        {
            List<Products> productList = new List<Products>();
            productList.Clear();
            PagingAndSorting paging = new PagingAndSorting();
            paging.PageSize = pageSize;
            paging.NextProduct = nextProduct;
            using (SqlConnection cn = new SqlConnection(strConnectionString))
            {
                cn.Open();
                SqlCommand sqlCommand = new SqlCommand("SELECT Product_Id,Name,Quantity_Per_Unit,Unit_Price,Units_In_Stock FROM ProductDetails ORDER BY  Product_Id,Name,Quantity_Per_Unit,Unit_Price,Units_In_Stock OFFSET (@PageSize*@NextProduct) ROWS FETCH NEXT (@PageSize) ROWS ONLY", cn);
                sqlCommand.Parameters.AddWithValue("@PageSize", paging.PageSize);
                sqlCommand.Parameters.AddWithValue("@NextProduct", paging.NextProduct);
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
                cn.Close();
            }
            return productList;
        }

    }
}