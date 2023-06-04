using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class CustomerPlan
{
    public int Id { get; set; }

    public string? CustomerId { get; set; }

    public int? PlanId { get; set; }

    public int? PlanOption { get; set; }

    public int? PlanDetailId { get; set; }

    public int? ProductId { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual Plan? Plan { get; set; }

    public virtual PlansDetail? PlanDetail { get; set; }

    public virtual PlansOption? PlanOptionNavigation { get; set; }

    public virtual Product? Product { get; set; }
}
