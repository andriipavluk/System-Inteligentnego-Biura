using Microsoft.EntityFrameworkCore;
using SmartHomeAPI.Data;
using SmartHomeAPI.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection"));
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors();

app.MapPost("/api/sensors", async (Sensor sensor, AppDbContext db) =>
{
    try
    {
        db.Sensors.Add(sensor);
        await db.SaveChangesAsync();
        return Results.Created($"/api/sensors/{sensor.Id}", sensor);
    }
    catch (Exception ex)
    {
        return Results.Problem("Error creating sensor: " + ex.Message);
    }
});

app.MapGet("/api/sensors", async (AppDbContext db) =>
{
    try
    {
        var sensors = await db.Sensors.ToListAsync();
        return Results.Ok(sensors);
    }
    catch (Exception ex)
    {
        return Results.Problem("Error retrieving sensors: " + ex.Message);
    }
});

app.MapPost("/api/sensor-data", async (SensorData data, AppDbContext db) =>
{
    try
    {
        // Optional: Check if sensor exists
        var sensorExists = await db.Sensors.AnyAsync(s => s.Id == data.SensorId);
        if (!sensorExists)
        {
            return Results.BadRequest("Sensor does not exist");
        }

        db.SensorData.Add(data);
        await db.SaveChangesAsync();
        return Results.Created($"/api/sensor-data/{data.Id}", data);
    }
    catch (Exception ex)
    {
        return Results.Problem("Error creating sensor data: " + ex.Message);
    }
});

app.MapGet("/api/sensor-data/{sensorId}", async (int sensorId, AppDbContext db) =>

{
    try
    {
        var data = await db.SensorData
            .Where(s => s.SensorId == sensorId)
            .OrderByDescending(s => s.CreatedAt)
            .ToListAsync();

        return data.Any()
            ? Results.Ok(data)
            : Results.NotFound($"No data found for sensor {sensorId}");
    }
    catch (Exception ex)
    {
        return Results.Problem("Error retrieving sensor data: " + ex.Message);
    }
});

app.Run();
