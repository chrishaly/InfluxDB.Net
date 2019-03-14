using System;
using System.Threading.Tasks;
using Xunit;

namespace InfluxDB.Net.Tests.Core
{
	public class UnitTest1
	{
		[Fact]
		public async Task Test1()
		{
			var client = new InfluxDb("http://localhost:8086", "root", "root");
			var continuousQueries = await client.DescribeContinuousQueriesAsync("mydb");
		}
	}
}
