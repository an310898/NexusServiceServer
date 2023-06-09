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
            entity.HasKey(e => e.Id).HasName("PK__Billing__3214EC07801FA6AB");

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
                .HasConstraintName("FK__Billing__Custome__5FB337D6");
        });

        modelBuilder.Entity<CityAvailable>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__CityAvai__3214EC07FEBEE3F9");

            entity.ToTable("CityAvailable");

            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.PostalCode)
                .HasMaxLength(10)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Customer__3214EC07E90FF86A");

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
            entity.HasKey(e => e.Id).HasName("PK__Customer__3214EC07ED4F9C92");

            entity.ToTable("CustomerPlan");

            entity.Property(e => e.CustomerId)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK__CustomerP__Custo__59063A47");

            entity.HasOne(d => d.PlanDetail).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.PlanDetailId)
                .HasConstraintName("FK__CustomerP__PlanD__5BE2A6F2");

            entity.HasOne(d => d.Plan).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.PlanId)
                .HasConstraintName("FK__CustomerP__PlanI__59FA5E80");

            entity.HasOne(d => d.PlanOptionNavigation).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.PlanOption)
                .HasConstraintName("FK__CustomerP__PlanO__5AEE82B9");

            entity.HasOne(d => d.Product).WithMany(p => p.CustomerPlans)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__CustomerP__Produ__5CD6CB2B");
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Employee__3214EC07A4C6A8D1");

            entity.HasIndex(e => e.Username, "UQ__Employee__536C85E4FB059868").IsUnique();

            entity.HasIndex(e => e.Phone, "UQ__Employee__5C7E359ED6EE5CB3").IsUnique();

            entity.HasIndex(e => e.Email, "UQ__Employee__A9D10534166E468D").IsUnique();

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
            entity.Property(e => e.JoiningDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("date");
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
                .HasConstraintName("FK__Employees__RoleI__440B1D61");
        });

        modelBuilder.Entity<Feedback>(entity =>
        {
            entity.HasKey(e => e.FeedbackId).HasName("PK__Feedback__6A4BEDF62623AE04");

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
                .HasConstraintName("FK__Feedback__Custom__6754599E");

            entity.HasOne(d => d.Order).WithMany(p => p.Feedbacks)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__Feedback__OrderI__66603565");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Orders__3214EC07169DABD6");

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
                .HasConstraintName("FK__Orders__Customer__5441852A");

            entity.HasOne(d => d.PlanDetail).WithMany(p => p.Orders)
                .HasForeignKey(d => d.PlanDetailId)
                .HasConstraintName("FK__Orders__PlanDeta__5535A963");

            entity.HasOne(d => d.Product).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__Orders__ProductI__5629CD9C");
        });

        modelBuilder.Entity<Plan>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Plans__3214EC07B942F6ED");

            entity.Property(e => e.Amount).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.ConnectionType)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.IsHidden).HasDefaultValueSql("((0))");
        });

        modelBuilder.Entity<PlansDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__PlansDet__3214EC07F92C5DD5");

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
                .HasConstraintName("FK__PlansDeta__Plans__4D94879B");
        });

        modelBuilder.Entity<PlansOption>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__PlansOpt__3214EC0730B31211");

            entity.ToTable("PlansOption");

            entity.Property(e => e.OptionName)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Plan).WithMany(p => p.PlansOptions)
                .HasForeignKey(d => d.PlanId)
                .HasConstraintName("FK__PlansOpti__PlanI__4AB81AF0");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Products__3214EC07B3BA8E78");

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
                .HasConstraintName("FK__Products__ForPla__5165187F");
        });

        modelBuilder.Entity<RetailStore>(entity =>
        {
            entity.HasKey(e => e.StoreId).HasName("PK__RetailSt__3B82F0E1D8653811");

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
                .HasConstraintName("FK__RetailSto__CityI__628FA481");

            entity.HasOne(d => d.Manager).WithMany(p => p.RetailStores)
                .HasForeignKey(d => d.ManagerId)
                .HasConstraintName("FK__RetailSto__Manag__6383C8BA");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Roles__3214EC07BCB1229C");

            entity.Property(e => e.RoleName).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
