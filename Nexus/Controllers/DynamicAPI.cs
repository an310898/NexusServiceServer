using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Nexus.Controllers
{
    [Route("/[controller]")]
    [ApiController]
    
    public class DynamicAPI : ControllerBase
    {
        private readonly string connectionString;

        public DynamicAPI(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("NexusConn");
        }


        [HttpPost("{name}")]
        public IActionResult CallStoreProcedure(string name, [FromBody] List<object> parameters = default)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(name, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        for (int i = 0; i < parameters.Count; i++)
                        {
                            SqlParameter parameter = new SqlParameter($"@p{i}", parameters[i]);
                            command.Parameters.Add(parameter);
                        }
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        DataTable resultTable = new DataTable();
                        adapter.Fill(resultTable);

                        List<Dictionary<string, object>> resultList = new List<Dictionary<string, object>>();
                        foreach (DataRow row in resultTable.Rows)
                        {
                            Dictionary<string, object> resultDict = new Dictionary<string, object>();
                            foreach (DataColumn col in resultTable.Columns)
                            {
                                resultDict[col.ColumnName] = row[col];
                            }
                            resultList.Add(resultDict);
                        }

                        return Ok(resultList);
                    }
                }
            }
        }
    }
}
