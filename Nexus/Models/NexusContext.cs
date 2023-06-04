using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Nexus.Models;

public partial class NexusContext : DbContext
{
    public NexusContext()
    {
    }

    public NexusContext(DbContextOptions<NexusContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Billing> Billings { get; set; }

    public virtual DbSet<CityAvailable> CityAvailables { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<CustomerPlan> CustomerPlans { get; set; }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<Feedback> Feedbacks { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<Plan> Plans { get; set; }

    public virtual DbSet<PlansDetail> PlansDetails { get; set; }

    public virtual DbSet<PlansOption> PlansOptions { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<RetailStore> RetailStores { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("name=NexusConn");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Billing>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Billing__3214EC07CB9B46C2");

            entity.ToTable("Billing");

            entity.Property(e => e.BillAmount).HasColumnType("decimal(10, 3)");
            entity.Property(e => e.BillingDate).HasColumnType("date");
            entity.Property(e => e.CustomerId)
                .HasMaxLength(12)
                .IsUnicode(false)
                .HasColumnName("CustomerID");
            entity.Property(e => e.PaymentDate).HasColumnType("date");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.Billings)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK__Billing__Custome__6EF57B66");
        });

        modelBuilder.Entity<CityAvailable>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__CityAvai__3214EC078E95E231");

            entity.ToTable("CityAvailable");

            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.PostalCode)
                .HasMaxLength(10)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Customer__3214EC07F6122ECE");

            entity.Property(e => e.Id)
                .HasMaxLength(12)
                .IsUnicode(false);
            entity.Property(e => e.Address).HasMaxLength(100);
            entity.Property(e => e.CreatedDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.LastName).HasMaxLength(50);
            entity.Property(e => e.Phone)
                .HasMaxLength(11)
                .IsUnicode(false);
            entity.Property(e => e.SecurityDeposit).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.State).HasMaxLength(50);

            entity.HasOne(d => d.City).WithMany(p => p.Customers)
                .HasForeignKey(d => d.CityId)
                .HasConstraintName("FK__Customers__CityI__3A81B327");
        });

        modelBuilder.Entity<CustomerPlan>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Customer__3214EC074887FDFD");

            entity.ToTable("CustomerPlan");

            entity.Property(e => e.CustomerId)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK__CustomerP__Custo__5535A963");

            entity.HasOne(d => d.PlanDetail).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.PlanDetailId)
                .HasConstraintName("FK__CustomerP__PlanD__5812160E");

            entity.HasOne(d => d.Plan).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.PlanId)
                .HasConstraintName("FK__CustomerP__PlanI__5629CD9C");

            entity.HasOne(d => d.PlanOptionNavigation).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.PlanOption)
                .HasConstraintName("FK__CustomerP__PlanO__571DF1D5");

            entity.HasOne(d => d.Product).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__CustomerP__Produ__59063A47");
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Employee__3214EC0701C0CE0E");

            entity.Property(e => e.CreatedDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("date");
            entity.Property(e => e.DateOfBirth).HasColumnType("date");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.Gender)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.JoiningDate).HasColumnType("date");
            entity.Property(e => e.LastName).HasMaxLength(50);
            entity.Property(e => e.Password)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Salary).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.State)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Role).WithMany(p => p.Employees)
                .HasForeignKey(d => d.RoleId)
                .HasConstraintName("FK__Employees__RoleI__403A8C7D");
        });

        modelBuilder.Entity<Feedback>(entity =>
        {
            entity.HasKey(e => e.FeedbackId).HasName("PK__Feedback__6A4BEDF6ED7EA842");

            entity.ToTable("Feedback");

            entity.Property(e => e.FeedbackId).HasColumnName("FeedbackID");
            entity.Property(e => e.Comments).HasMaxLength(200);
            entity.Property(e => e.CustomerId)
                .HasMaxLength(12)
                .IsUnicode(false)
                .HasColumnName("CustomerID");
            entity.Property(e => e.OrderId).HasColumnName("OrderID");

            entity.HasOne(d => d.Customer).WithMany(p => p.Feedbacks)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK__Feedback__Custom__6383C8BA");

            entity.HasOne(d => d.Order).WithMany(p => p.Feedbacks)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__Feedback__OrderI__628FA481");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Orders__3214EC07F966AC71");

            entity.Property(e => e.CustomerId)
                .HasMaxLength(12)
                .IsUnicode(false)
                .HasColumnName("CustomerID");
            entity.Property(e => e.DeliveryDate).HasColumnType("date");
            entity.Property(e => e.OrderDate).HasColumnType("date");
            entity.Property(e => e.OrderStatus)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.PaymentMethod).HasMaxLength(50);
            entity.Property(e => e.PlanDetailId).HasColumnName("PlanDetailID");

            entity.HasOne(d => d.Customer).WithMany(p => p.Orders)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK__Orders__Customer__5070F446");

            entity.HasOne(d => d.PlanDetail).WithMany(p => p.Orders)
                .HasForeignKey(d => d.PlanDetailId)
                .HasConstraintName("FK__Orders__PlanDeta__5165187F");

            entity.HasOne(d => d.Product).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__Orders__ProductI__52593CB8");
        });

        modelBuilder.Entity<Plan>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Plans__3214EC0719E19CE8");

            entity.Property(e => e.Amount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.ConnectionType)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
        });

        modelBuilder.Entity<PlansDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__PlansDet__3214EC0775E0A73C");

            entity.ToTable("PlansDetail");

            entity.Property(e => e.CallCharges)
                .HasMaxLength(300)
                .IsUnicode(false);
            entity.Property(e => e.DataLimit).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Description)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.Duration)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.PlansOption).WithMany(p => p.PlansDetails)
                .HasForeignKey(d => d.PlansOptionId)
                .HasConstraintName("FK__PlansDeta__Plans__49C3F6B7");
        });

        modelBuilder.Entity<PlansOption>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__PlansOpt__3214EC077AB72867");

            entity.ToTable("PlansOption");

            entity.Property(e => e.OptionName)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Plan).WithMany(p => p.PlansOptions)
                .HasForeignKey(d => d.PlanId)
                .HasConstraintName("FK__PlansOpti__PlanI__46E78A0C");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Products__3214EC074D247AE4");

            entity.Property(e => e.Description).IsUnicode(false);
            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
            entity.Property(e => e.Manufacturer)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.ProductName)
                .HasMaxLength(100)
                .IsUnicode(false);

            entity.HasOne(d => d.ForPlanNavigation).WithMany(p => p.Products)
                .HasForeignKey(d => d.ForPlan)
                .HasConstraintName("FK__Products__ForPla__4D94879B");
        });

        modelBuilder.Entity<RetailStore>(entity =>
        {
            entity.HasKey(e => e.StoreId).HasName("PK__RetailSt__3B82F0E1C1714629");

            entity.Property(e => e.StoreId).HasColumnName("StoreID");
            entity.Property(e => e.Address).HasMaxLength(100);
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.State)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.StoreName).HasMaxLength(100);

            entity.HasOne(d => d.City).WithMany(p => p.RetailStores)
                .HasForeignKey(d => d.CityId)
                .HasConstraintName("FK__RetailSto__CityI__5EBF139D");

            entity.HasOne(d => d.Manager).WithMany(p => p.RetailStores)
                .HasForeignKey(d => d.ManagerId)
                .HasConstraintName("FK__RetailSto__Manag__5FB337D6");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Roles__3214EC07722801F3");

            entity.Property(e => e.RoleName).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
