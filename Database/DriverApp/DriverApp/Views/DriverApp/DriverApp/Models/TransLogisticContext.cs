using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace DriverApp.Models
{
    public class TransLogisticContext : DbContext
    {
        public DbSet<Driver> Drivers { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderAssignment> OrderAssignments { get; set; }
        // другие DbSet

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            optionsBuilder.UseSqlServer(connectionString);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Driver>().ToTable("Drivers").HasKey(d => d.Id);
            modelBuilder.Entity<Order>().ToTable("Orders").HasKey(o => o.Id);
            // настройки связей и т.д.
        }
    }

    public class Driver
    {
        public string Id { get; set; }
        public string FullName { get; set; }
        public string Phone { get; set; }
        public decimal Rating { get; set; }
        public int DriverStatusId { get; set; }
    }

    public class Order
    {
        public string Id { get; set; }
        public System.DateTime OrderDate { get; set; }
        public int OriginCityId { get; set; }
        public int DestCityId { get; set; }
        public int CargoTypeId { get; set; }
        public decimal WeightKg { get; set; }
        public decimal VolumeM3 { get; set; }
        public decimal Price { get; set; }
        public int StatusId { get; set; }
        public bool IsUrgent { get; set; }
    }
}
