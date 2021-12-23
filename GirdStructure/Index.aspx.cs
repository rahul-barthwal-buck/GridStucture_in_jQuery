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
        public static string GetAllProducts()
        {
            SqlConnection _sqlConnection = new SqlConnection(strConnectionString);
            _sqlConnection.Open();
            SqlDataAdapter _sqlDataAdapter = new SqlDataAdapter("SELECT Product_Id,Name,Quantity_Per_Unit,Unit_Price,Units_In_Stock FROM ProductDetails", _sqlConnection);
            DataSet _dtSet = new DataSet();
            _sqlDataAdapter.Fill(_dtSet);

            string data = JsonConvert.SerializeObject(_dtSet, Formatting.Indented);
            return data;
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

    }
}