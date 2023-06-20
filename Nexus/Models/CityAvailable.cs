using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class CityAvailable
{
    public int Id { get; set; }

    public string? Name { get; set; }

    public string? PostalCode { get; set; }

    public bool? IsHidden { get; set; }

    public virtual ICollection<Customer> Customers { get; set; } = new List<Customer>();

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    public virtual ICollection<RetailStore> RetailStores { get; set; } = new List<RetailStore>();
}
