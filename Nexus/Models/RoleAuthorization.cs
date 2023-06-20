using System;
using System.Collections.Generic;

namespace Nexus.Models;

public partial class RoleAuthorization
{
    public int? RoleId { get; set; }

    public int? AuthorizationId { get; set; }

    public virtual Author? Authorization { get; set; }

    public virtual Role? Role { get; set; }
}
