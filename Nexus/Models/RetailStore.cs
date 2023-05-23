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

    public string? State { get; set; }

    public string? PostalCode { get; set; }

    public string? ManagerName { get; set; }
}
