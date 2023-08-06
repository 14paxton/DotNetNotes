---
title:        HTTP
permalink:    DotNetNotes/HTTP
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

# [HTTPClient](https://learn.microsoft.com/en-us/dotnet/api/system.net.http.httpclient?view=net-8.0)

```csharp
var client = new HttpClient();
var request = new HttpRequestMessage(HttpMethod.Get, "localhost:8080");
request.Headers.Add("Authorization", "Basic YnJhbmRvbmpwQHZlcmlkaWFuY3Uub3JnOmU4N2EyOGJlZjM4MTRkNjBhMDljNDNkYjgwNTQ1MzMy");
var content = new StringContent("{\r\n    \"detectIntentResponseId\": \"3e510315-157d-4453-85c0-45c07173d226\",\r\n    \"pageInfo\": {\r\n        \"currentPage\": \"projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/flows/00000000-0000-0000-0000-000000000000/pages/START_PAGE\",\r\n        \"displayName\": \"Start Page\"\r\n    },\r\n    \"sessionInfo\": {\r\n        \"session\": \"projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/sessions/629d48-27e-702-88f-fb482bc14\",\r\n        \"parameters\": {\r\n            \"name\": \"maynard\"\r\n        }\r\n    },\r\n    \"fulfillmentInfo\": {\r\n        \"tag\": \"customfields\"\r\n    },\r\n    \"messages\": [\r\n        {\r\n            \"text\": {\r\n                \"text\": [\r\n                    \"-- debug --\\nvisitor \\u003d $session.params.visitor\"\r\n                ],\r\n                \"allowPlaybackInterruption\": true,\r\n                \"redactedText\": [\r\n                    \"-- debug --\\nvisitor \\u003d $session.params.visitor\"\r\n                ]\r\n            },\r\n            \"responseType\": \"HANDLER_PROMPT\",\r\n            \"source\": \"VIRTUAL_AGENT\"\r\n        }\r\n    ],\r\n    \"triggerEvent\": \"initiate-bot-event\",\r\n    \"languageCode\": \"en\"\r\n}", null, "application/json");
request.Content = content;
var response = await client.SendAsync(request);
response.EnsureSuccessStatusCode();
Console.WriteLine(await response.Content.ReadAsStringAsync());
```

## create basic auth

```csharp
  var mergedCredentials = string.Format("{0}:{1}", _comm100ApiUsername, _comm100ApiKey);
  var encodedCredentials = Convert.ToBase64String(byteCredentials);
  var byteCredentials = Encoding.UTF8.GetBytes(mergedCredentials);
  client.DefaultRequestHeaders.Add("Authorization", "Basic " + encodedCredentials);
```

# [RestSharp](https://restsharp.dev/intro.html#introduction)

```csharp
var options = new RestClientOptions("null")
{
  MaxTimeout = -1,
};
var client = new RestClient(options);
var request = new RestRequest("localhost:8080", Method.Get);
request.AddHeader("Content-Type", "application/json");
request.AddHeader("Authorization", "Basic YnJhbmRvbmpwQHZlcmlkaWFuY3Uub3JnOmU4N2EyOGJlZjM4MTRkNjBhMDljNDNkYjgwNTQ1MzMy");
var body = "json";
request.AddStringBody(body, DataFormat.Json);
RestResponse response = await client.ExecuteAsync(request);
Console.WriteLine(response.Content);
```

> or

```csharp
RestClientOptions options = new RestClientOptions(_stringUrl)
     {
      Authenticator = new HttpBasicAuthenticator(username, apiKey),
      MaxTimeout = -1
     };

     RestClient client = new RestClient(options);
     RestRequest restRequest = new RestRequest(/the/endpoint);
     restRequest.AddParameter("siteId", paramValue);
     RestResponse response = await client.ExecuteAsync(restRequest);

     List<JsonElement> visitorList = JsonSerializer.Deserialize<List<JsonElement>>(response.Content ?? string.Empty);
     List<JsonElement> filteredList = visitorList.FindAll(match: visitor => visitor.GetProperty("name").GetString() == nameParameterValue.StringValue);
```