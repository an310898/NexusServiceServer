using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class Billing
{
    public int Id { get; set; }

    public string? CustomerId { get; set; }

    public decimal? BillAmount { get; set; }

    public decimal? PaymentAmount { get; set; }

    public DateTime? BillingDate { get; set; }

    public DateTime? PaymentDate { get; set; }

    public string? PaymentMethod { get; set; }

    public virtual ICollection<BillDetail> BillDetails { get; set; } = new List<BillDetail>();

    public virtual Customer? Customer { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();
}
