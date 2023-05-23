using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class CustomerPlan
{
    public int Id { get; set; }

    public string? CustomerId { get; set; }

    public int? PlanDetailId { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual PlansDetail? PlanDetail { get; set; }
}
