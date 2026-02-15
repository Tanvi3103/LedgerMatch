namespace ReconciliationAPI.Models;

public class RunReconciliationRequest
{
    public decimal Tolerance { get; set; } = 1.00m;
}
