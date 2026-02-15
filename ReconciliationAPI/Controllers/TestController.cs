using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace ReconciliationAPI.Controllers;

[ApiController]
[Route("api/test")]
public class TestController : ControllerBase
{
    private readonly IConfiguration _config;

    public TestController(IConfiguration config)
    {
        _config = config;
    }

    [HttpGet]
    public async Task<IActionResult> TestConnection()
    {
        try
        {
            using var conn = new SqlConnection(
                _config.GetConnectionString("DefaultConnection"));

            await conn.OpenAsync();
            return Ok("Database connected successfully 🚀");
        }
        catch (Exception ex)
        {
            return BadRequest(ex.Message);
        }
    }
}
