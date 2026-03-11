cat > Models/SensorData.cs << 'EOF'
namespace SmartHomeAPI.Models;

public class SensorData
{
    public int Id { get; set; }
    public int SensorId { get; set; }
    public string Type { get; set; } = string.Empty;
    public double Value { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}

public class Sensor
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public int RoomId { get; set; }
}
EOF