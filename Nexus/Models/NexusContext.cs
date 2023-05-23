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

    public virtual DbSet<BillDetail> BillDetails { get; set; }

    public virtual DbSet<Billing> Billings { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<CustomerPlan> CustomerPlans { get; set; }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<Feedback> Feedbacks { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

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
        modelBuilder.Entity<BillDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__BillDeta__3214EC073430AD66");

            entity.Property(e => e.BillingId).HasColumnName("BillingID");
            entity.Property(e => e.TotalPrice).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.Billing).WithMany(p => p.BillDetails)
                .HasForeignKey(d => d.BillingId)
                .HasConstraintName("FK__BillDetai__Billi__5DCAEF64");

            entity.HasOne(d => d.Product).WithMany(p => p.BillDetails)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__BillDetai__Produ__5EBF139D");
        });

        modelBuilder.Entity<Billing>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Billing__3214EC07A9A93449");

            entity.ToTable("Billing");

            entity.Property(e => e.BillAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.BillingDate).HasColumnType("date");
            entity.Property(e => e.CustomerId)
                .HasMaxLength(12)
                .IsUnicode(false)
                .HasColumnName("CustomerID");
            entity.Property(e => e.PaymentAmount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PaymentDate).HasColumnType("date");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.Billings)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK__Billing__Custome__5AEE82B9");
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Customer__3214EC07B9FA943A");

            entity.Property(e => e.Id)
                .HasMaxLength(12)
                .IsUnicode(false);
            entity.Property(e => e.Address).HasMaxLength(100);
            entity.Property(e => e.City).HasMaxLength(50);
            entity.Property(e => e.CreatedDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.DateOfBirth).HasColumnType("date");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.Gender)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
            entity.Property(e => e.LastName).HasMaxLength(50);
            entity.Property(e => e.Phone)
                .HasMaxLength(11)
                .IsUnicode(false);
            entity.Property(e => e.PostalCode)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.SecurityDeposit).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.State).HasMaxLength(50);
        });

        modelBuilder.Entity<CustomerPlan>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Customer__3214EC079185DD94");

            entity.ToTable("CustomerPlan");

            entity.Property(e => e.CustomerId)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK__CustomerP__Custo__571DF1D5");

            entity.HasOne(d => d.PlanDetail).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.PlanDetailId)
                .HasConstraintName("FK__CustomerP__PlanD__5812160E");
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Employee__3214EC07004C50E4");

            entity.Property(e => e.Address).HasMaxLength(100);
            entity.Property(e => e.CreatedDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.DateOfBirth).HasColumnType("date");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.Gender)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
            entity.Property(e => e.JoiningDate).HasColumnType("date");
            entity.Property(e => e.LastName).HasMaxLength(50);
            entity.Property(e => e.Password)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Salary).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Role).WithMany(p => p.Employees)
                .HasForeignKey(d => d.RoleId)
                .HasConstraintName("FK__Employees__RoleI__3E52440B");
        });

        modelBuilder.Entity<Feedback>(entity =>
        {
            entity.HasKey(e => e.FeedbackId).HasName("PK__Feedback__6A4BEDF6CA4A49A5");

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
                .HasConstraintName("FK__Feedback__Custom__68487DD7");

            entity.HasOne(d => d.Order).WithMany(p => p.Feedbacks)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__Feedback__OrderI__6754599E");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Orders__3214EC0740D5B31C");

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
                .HasConstraintName("FK__Orders__Customer__4E88ABD4");

            entity.HasOne(d => d.PlanDetail).WithMany(p => p.Orders)
                .HasForeignKey(d => d.PlanDetailId)
                .HasConstraintName("FK__Orders__PlanDeta__4F7CD00D");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__OrderDet__3214EC07B4E522A6");

            entity.Property(e => e.Quantity).HasDefaultValueSql("((1))");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__OrderDeta__Order__52593CB8");

            entity.HasOne(d => d.Product).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__OrderDeta__Produ__534D60F1");
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("PK__Payments__9B556A5846B83AA2");

            entity.Property(e => e.PaymentId).HasColumnName("PaymentID");
            entity.Property(e => e.Amount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.BillingId).HasColumnName("BillingID");
            entity.Property(e => e.PaymentDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("date");

            entity.HasOne(d => d.Billing).WithMany(p => p.Payments)
                .HasForeignKey(d => d.BillingId)
                .HasConstraintName("FK__Payments__Billin__619B8048");
        });

        modelBuilder.Entity<Plan>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Plans__3214EC07451CD29B");

            entity.Property(e => e.Amount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.ConnectionType)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
        });

        modelBuilder.Entity<PlansDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__PlansDet__3214EC07DAF6745B");

            entity.ToTable("PlansDetail");

            entity.Property(e => e.CallCharges).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.DataLimit).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Description)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.Duration)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.PlansOptionNavigation).WithMany(p => p.PlansDetails)
                .HasForeignKey(d => d.PlansOption)
                .HasConstraintName("FK__PlansDeta__Plans__4BAC3F29");
        });

        modelBuilder.Entity<PlansOption>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__PlansOpt__3214EC078DB499BC");

            entity.ToTable("PlansOption");

            entity.Property(e => e.OptionName)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Plan).WithMany(p => p.PlansOptions)
                .HasForeignKey(d => d.PlanId)
                .HasConstraintName("FK__PlansOpti__PlanI__48CFD27E");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Products__3214EC077AC03DB4");

            entity.Property(e => e.Description)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
            entity.Property(e => e.Manufacturer)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.ProductName)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<RetailStore>(entity =>
        {
            entity.HasKey(e => e.StoreId).HasName("PK__RetailSt__3B82F0E149575AE3");

            entity.Property(e => e.StoreId).HasColumnName("StoreID");
            entity.Property(e => e.Address).HasMaxLength(100);
            entity.Property(e => e.City)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.ManagerName).HasMaxLength(100);
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.PostalCode)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.State)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.StoreName).HasMaxLength(100);
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Roles__3214EC0796786F2A");

            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
            entity.Property(e => e.RoleName).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
