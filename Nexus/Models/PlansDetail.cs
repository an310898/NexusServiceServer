using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class PlansDetail
{
    public int Id { get; set; }

    public int? PlansOption { get; set; }

    public string? Description { get; set; }

    public string? Duration { get; set; }

    public decimal? DataLimit { get; set; }

    public decimal? CallCharges { get; set; }

    public decimal? Price { get; set; }

    public virtual ICollection<CustomerPlan> CustomerPlans { get; set; } = new List<CustomerPlan>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual PlansOption? PlansOptionNavigation { get; set; }
}
