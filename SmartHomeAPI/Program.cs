using Microsoft.EntityFrameworkCore;
using SmartHomeAPI.Data;
using SmartHomeAPI.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapPost("/api/sensor-data", async (SensorData data, AppDbContext db) =>
{
    db.SensorData.Add(data);
    await db.SaveChangesAsync();
    return Results.Created($"/api/sensor-data/{data.Id}", data);
});

app.MapGet("/api/sensors", async (AppDbContext db) =>
{
    var sensors = await db.Sensors.ToListAsync();
    return Results.Ok(sensors);
});

app.MapGet("/api/sensor-data/{sensor_id}", async (int sensor_id, AppDbContext db) =>
{
    var data = await db.SensorData
        .Where(s => s.SensorId == sensor_id)
        .OrderByDescending(s => s.CreatedAt)
        .ToListAsync();

    return data.Any()
        ? Results.Ok(data)
        : Results.NotFound($"Brak danych dla czujnika {sensor_id}");
});

app.Run();
