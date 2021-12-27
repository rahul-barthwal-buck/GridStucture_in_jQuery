using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GirdStructure
{
    //This class is for paging and sorting
    public class PagingAndSorting
    {
        public int PageSize { get; set; }
        public int NextOrPrevious { get; set; }
        public string SortBy { get; set; }
    }
}