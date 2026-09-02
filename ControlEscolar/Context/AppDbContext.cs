using Microsoft.EntityFrameworkCore;
using ControlEscolar.Models;

namespace ControlEscolar.Context
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options){}

        public DbSet<Alumno> alumno { get; set; }
        }
}
