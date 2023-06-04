using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class Billing
{
    public int Id { get; set; }

    public string? CustomerId { get; set; }

    public decimal? BillAmount { get; set; }

    public DateTime? BillingDate { get; set; }

    public DateTime? PaymentDate { get; set; }

    public string? PaymentMethod { get; set; }

    public virtual Customer? Customer { get; set; }
}
