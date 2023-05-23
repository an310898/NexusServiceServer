using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class Payment
{
    public int PaymentId { get; set; }

    public int? BillingId { get; set; }

    public decimal? Amount { get; set; }

    public DateTime? PaymentDate { get; set; }

    public virtual Billing? Billing { get; set; }
}
