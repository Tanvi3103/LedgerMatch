using Microsoft.Data.SqlClient;
using System.Data;
using ReconciliationAPI.Models;

namespace ReconciliationAPI.Services;

public class ReconciliationService
{
    private readonly IConfiguration _config;

    public ReconciliationService(IConfiguration config)
    {
        _config = config;
    }

    public async Task<List<ReconciliationSummaryDto>> RunReconciliation(decimal tolerance)
    {
        var results = new List<ReconciliationSummaryDto>();

        using var conn = new SqlConnection(
            _config.GetConnectionString("DefaultConnection"));

        using var cmd = new SqlCommand("sp_RunReconciliation", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Tolerance", tolerance);

        await conn.OpenAsync();
        using var reader = await cmd.ExecuteReaderAsync();

        while (await reader.ReadAsync())
        {   
            results.Add(new ReconciliationSummaryDto
            {
                ReconRunId = Convert.ToInt32(reader["ReconRunId"]),
                MatchStatus = reader["MatchStatus"]?.ToString(),
                MatchRule = reader["MatchRule"]?.ToString(),
                TransactionCount = Convert.ToInt32(reader["TransactionCount"]),
                TotalAmount = Convert.ToDecimal(reader["TotalAmount"])
            });
        }


        return results;
    }
}
