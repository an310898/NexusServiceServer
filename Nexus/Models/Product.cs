using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class Product
{
    public int Id { get; set; }

    public string? ProductName { get; set; }

    public string? ProductImageUrl { get; set; }

    public string? Description { get; set; }

    public decimal? Price { get; set; }

    public int? QuantityInStock { get; set; }

    public bool? IsHidden { get; set; }

    public string? Manufacturer { get; set; }

    public int? ForPlan { get; set; }

    public virtual ICollection<BillDetail> BillDetails { get; set; } = new List<BillDetail>();

    public virtual Plan? ForPlanNavigation { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
