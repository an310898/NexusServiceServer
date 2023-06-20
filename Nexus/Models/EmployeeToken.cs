using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class EmployeeToken
{
    public int Id { get; set; }

    public int? EmployeeId { get; set; }

    public string? Token { get; set; }

    public DateTime? Expired { get; set; }

    public virtual Employee? Employee { get; set; }
}
