using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class AllPlanDetailTable
{
    public int PlanId { get; set; }

    public string ConnectionType { get; set; } = null!;

    public decimal Amount { get; set; }

    public bool? IsHidden { get; set; }

    public int PlanOptionId { get; set; }

    public string? OptionName { get; set; }

    public int PlanDetailId { get; set; }

    public string? Description { get; set; }

    public string? Duration { get; set; }

    public decimal? DataLimit { get; set; }

    public string? CallCharges { get; set; }

    public decimal? Price { get; set; }
}
