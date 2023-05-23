using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class BillDetail
{
    public int Id { get; set; }

    public int? BillingId { get; set; }

    public int? ProductId { get; set; }

    public int? Quantity { get; set; }

    public decimal? TotalPrice { get; set; }

    public virtual Billing? Billing { get; set; }

    public virtual Product? Product { get; set; }
}
