using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GirdStructure
{
    public class Products
    { 
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int QuantityPerUnit { get; set; }
        public int UnitPrice { get; set; }
        public int UnitsInStock { get; set; }

    }
}