using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GirdStructure
{
    public class PagingAndSorting
    {
        public int PageSize { get; set; }
        public int NextOrPrevious { get; set; }
        public string SortBy { get; set; }
    }
}