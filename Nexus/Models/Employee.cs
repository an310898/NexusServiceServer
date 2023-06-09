using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class Employee
{
    public int Id { get; set; }

    public string? FirstName { get; set; }

    public string? LastName { get; set; }

    public string? Email { get; set; }

    public string? Phone { get; set; }

    public string? Username { get; set; }

    public string? Password { get; set; }

    public DateTime? DateOfBirth { get; set; }

    public string? Gender { get; set; }

    public DateTime? JoiningDate { get; set; }

    public decimal? Salary { get; set; }

    public int? RoleId { get; set; }

    public string? State { get; set; }

    public DateTime? CreatedDate { get; set; }

    public virtual ICollection<RetailStore> RetailStores { get; set; } = new List<RetailStore>();

    public virtual Role? Role { get; set; }
}
