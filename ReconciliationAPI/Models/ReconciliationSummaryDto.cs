namespace ReconciliationAPI.Models;

public class ReconciliationSummaryDto
{
    public int ReconRunId { get; set; }
    public string? MatchStatus { get; set; }
    public string? MatchRule { get; set; }
    public int TransactionCount { get; set; }
    public decimal TotalAmount { get; set; }
}
