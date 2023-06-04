using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class Plan
{
    public int Id { get; set; }

    public string ConnectionType { get; set; } = null!;

    public decimal Amount { get; set; }

    public bool? IsHidden { get; set; }

    public virtual ICollection<CustomerPlan> CustomerPlans { get; set; } = new List<CustomerPlan>();

    public virtual ICollection<PlansOption> PlansOptions { get; set; } = new List<PlansOption>();

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
