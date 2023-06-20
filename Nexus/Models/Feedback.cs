using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class Feedback
{
    public int Id { get; set; }

    public int? OrderId { get; set; }

    public string? CustomerId { get; set; }

    public string? Subject { get; set; }

    public string? Comments { get; set; }

    public DateTime? CreatedDate { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual Order? Order { get; set; }
}
