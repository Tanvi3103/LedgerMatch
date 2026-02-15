using Microsoft.AspNetCore.Mvc;
using ReconciliationAPI.Models;
using ReconciliationAPI.Services;

namespace ReconciliationAPI.Controllers;

[ApiController]
[Route("api/reconciliation")]
public class ReconciliationController : ControllerBase
{
    private readonly ReconciliationService _service;

    public ReconciliationController(ReconciliationService service)
    {
        _service = service;
    }

    [HttpPost("run")]
    public async Task<IActionResult> Run([FromBody] RunReconciliationRequest request)
    {
        var result = await _service.RunReconciliation(request.Tolerance);
        return Ok(result);
    }
}
