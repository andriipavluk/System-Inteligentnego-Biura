namespace SmartHomeAPI.Models;

public class SensorData
{
    public int Id { get; set; }
    public int SensorId { get; set; }
    public string Type { get; set; } = string.Empty;
    public double Value { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
