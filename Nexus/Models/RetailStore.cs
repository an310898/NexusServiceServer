using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class RetailStore
{
    public int StoreId { get; set; }

    public string? StoreName { get; set; }

    public string? Address { get; set; }

    public string? Phone { get; set; }

    public string? City { get; set; }

    public bool? State { get; set; }

    public string? PostalCode { get; set; }

    public int? ManagerId { get; set; }

    public virtual Employee? Manager { get; set; }
}
