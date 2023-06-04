using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class PlansOption
{
    public int Id { get; set; }

    public int? PlanId { get; set; }

    public string? OptionName { get; set; }

    public virtual ICollection<CustomerPlan> CustomerPlans { get; set; } = new List<CustomerPlan>();

    public virtual Plan? Plan { get; set; }

    public virtual ICollection<PlansDetail> PlansDetails { get; set; } = new List<PlansDetail>();
}
