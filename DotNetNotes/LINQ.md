---
title:        LINQ
permalink:    DotNetNotes/LINQ
category:     DotNetNotes
parent:       DotNetNotes
layout:       default
has_children: false
share:        true
shortRepo:
  - dotnetnotes
  - default
---


<br/>

<details markdown="block">
<summary>
Table of contents
</summary>
{: .text-delta }
1. TOC
{:toc}
</details>

<br/>

***

<br/>

# Quick Snips

## use in foreach

```csharp
foreach (DetectIntentResponse jsonPayload in
				         from row in rawData
				         select JsonConvert.DeserializeObject<JsonElement>(row.JsonPayload, enumConverter)
				         into json2
				         let parserSettings = JsonParser.Settings.Default.WithIgnoreUnknownFields(true)
				         let jParser = new JsonParser(parserSettings)
				         select jParser.Parse<DetectIntentResponse>(json2.GetString()))
				{ 
                                   [code]
                                
                                  }
```

## modify list

```csharp
loggingServiceV2Client.ListLogEntriesAsync(resourceNames: query.ResourceNames, filter: query.Filter, orderBy: query.OrderBy)
                        .ToListAsync()
                        .Result
                        .AsParallel()
                        .Select(selector: RawData.CreateInstance)
                        .ToList()
                        .GetRange(index: 1, count: 10);
```

```csharp
 List<RawData> c = loggingServiceV2Client.ListLogEntries(resourceNames: query.ResourceNames, filter: query.Filter, orderBy: query.OrderBy)
                        .AsParallel()
                        .Select(selector: RawData.CreateInstance)
                        .ToList();
```

```csharp
var c = loggingServiceV2Client
                    .ListLogEntries(resourceNames: query.ResourceNames, filter: query.Filter, orderBy: query.OrderBy)
                    .AsParallel()
                    .Select(selector: entry => RawData.CreateInstance(timestamp: entry.ReceiveTimestamp, severity: entry.Severity, type: entry?.Resource?.Type, logName: entry.LogName, textPayload: entry?.TextPayload, protoPayload: entry?.ProtoPayload, jsonPayload: entry?.JsonPayload))
                    .ToList();
```

***

# Examples

```csharp

		static void Main(string[] args)
		{
			IEnumerable<int> data = Enumerable.Range(1, 50);

			IEnumerable<string> method = // IEnumerable<string>
				data.Where(x => x % 2 == 0).Select(x => x.ToString());

			IEnumerable<string> query = // IEnumerable<string>
				from d in data where d % 2 == 0 select d.ToString();

			Debugger.Break();

			var projection = from d in data
				select new
				{
					Even = d % 2 == 0,
					Odd = !(d % 2 == 0),
					Value = d
				};

			string[] letters =
			{
				"A", "C", "B", "E", "Q"
			};

			Debugger.Break();

			IOrderedEnumerable<int> sortAsc = from d in data orderby d select d;

			IOrderedEnumerable<int> sortDesc = data.OrderByDescending(x => x);

			Debugger.Break();

			// candy

			string[] values =
			{
				"A", "B", "A", "C", "A", "D"
			};

			IEnumerable<string> distinct = values.Distinct();
			string              first    = values.First();
			string              firstOr  = values.FirstOrDefault();
			string              last     = values.Last();
			IEnumerable<string> page     = values.Skip(2).Take(2);

			Debugger.Break();

			// aggregates

			IEnumerable<int> numbers = Enumerable.Range(1, 50);
			bool             any     = numbers.Any(x => x % 2 == 0);
			int              count   = numbers.Count(x => x % 2 == 0);
			int              sum     = numbers.Sum();
			int              max     = numbers.Max();
			int              min     = numbers.Min();
			double           avg     = numbers.Average();

			Debugger.Break();

			Dictionary<string, string> dictionary = new Dictionary<string, string>
			{
				{
					"1", "B"
				},
				{
					"2", "A"
				},
				{
					"3", "B"
				},
				{
					"4", "A"
				}
			};

			var group = // IEnumerable<string, IEnumerable<string>>
				from d1 in dictionary
				group d1 by d1.Value
				into g
				select new
				{
					g.Key,
					Members = g
				};

			Debugger.Break();

			Dictionary<string, string> dictionary1 = new Dictionary<string, string>
			{
				{
					"1", "B"
				},
				{
					"2", "A"
				},
				{
					"3", "B"
				},
				{
					"4", "A"
				}
			};

			Dictionary<string, string> dictionary2 = new Dictionary<string, string>
			{
				{
					"5", "B"
				},
				{
					"6", "A"
				},
				{
					"7", "B"
				},
				{
					"8", "A"
				}
			};

			var join = from d1 in dictionary1
				join d2 in dictionary2 on d1.Value equals d2.Value
				select new
				{
					Key1 = d1.Key,
					Key2 = d2.Key,
					d1.Value
				};

			Debugger.Break();

		}
```