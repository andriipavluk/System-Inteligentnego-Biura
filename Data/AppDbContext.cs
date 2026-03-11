cat > Data/AppDbContext.cs << 'EOF'
using Microsoft.EntityFrameworkCore;
using SmartHomeAPI.Models;

namespace SmartHomeAPI.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options) { }

    public DbSet<Sensor> Sensors { get; set; }
    public DbSet<SensorData> SensorData { get; set; }
}
EOF