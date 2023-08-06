---
title:        Google
permalink:    DotNetNotes/Google
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

# Client Libraries

# [API ExplorerV3](https://developers.google.com/apis-explorer/#p/dialogflow/v3/)

## [.Net client Library](https://cloud.google.com/dotnet/docs/reference/Google.Cloud.Dialogflow.Cx.V3/latest)

---

## [Authorizing Example](https://github.com/14paxton/GCPAuthorization)

``` csharp
using System.Reflection;
using Google.Apis.Auth.OAuth2;
using Google.Cloud.Dialogflow.Cx.V3;
using Google.Cloud.Iam.Credentials.V1;
using Grpc.Auth;
using Grpc.Core;
using Environment = System.Environment;

string currentDir = Directory.GetCurrentDirectory();
string path = Path.Combine(new FileInfo(Assembly.GetExecutingAssembly().Location).DirectoryName, "vcu-chat-bot");
// string[] scopes = { "https://www.googleapis.com/auth/dialogflow", "https://www.googleapis.com/auth/cloud-platform" };
IReadOnlyList<string> scopes = SessionsClient.DefaultScopes;
FileStream stream = new(path, FileMode.Open, FileAccess.Read);
GoogleCredential? credentialAccount = GoogleCredential.FromFile(path);
GoogleCredential? credentialAccountFromStreamAsync = GoogleCredential.FromStreamAsync(stream, CancellationToken.None).Result;

//MANUALLY SET ENV VAR
Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);

//IAMCredentialsClientBuilder
//From an ICredential from file
ICredential credential = GoogleCredential.FromFile(path);

IAMCredentialsClientBuilder iamcredintialFromPathBuilder = new()
{
    CredentialsPath = path,
    Scopes = scopes
};
IAMCredentialsClient? iamcredintialFromPath = iamcredintialFromPathBuilder.Build();

IAMCredentialsClientBuilder iamcredintialJsonBuilder = new()
{
    JsonCredentials = File.ReadAllText(path),
    Scopes = scopes
};
IAMCredentialsClient iamcredentialsJson = iamcredintialJsonBuilder.BuildAsync().Result;

IAMCredentialsClientBuilder iamcredintialGoogleCredentialsClientBuilder = new()
{
    GoogleCredential = credentialAccountFromStreamAsync,
    Scopes = scopes
};
IAMCredentialsClient? iamcredentialGoogleCred = iamcredintialGoogleCredentialsClientBuilder.BuildAsync().Result;

SessionsClientBuilder? sessionsClientBuilderTokenAccess = new()
{
    TokenAccessMethod = (s, token) => credential.GetAccessTokenForRequestAsync(s, token)
};

SessionsClient sessionsClientICred = sessionsClientBuilderTokenAccess.Build();

// SessionsClient sessionsClient = SessionsClient.CreateAsync().Result;

// from file stream
// GoogleCredential credentialStream;
// using (FileStream stream = new(path, FileMode.Open, FileAccess.Read))
// {
//     credentialStream = GoogleCredential.FromStream(stream)
//         .CreateScoped(scopes);
// }

// use default credential
GoogleCredential credentialDefault = GoogleCredential.GetApplicationDefault();
ServiceAccountCredential? serviceAccountCredential =
    credentialDefault.UnderlyingCredential as ServiceAccountCredential;
SessionsClientBuilder sessionsClientBuilderFromDefault = new()
{
    ChannelCredentials = serviceAccountCredential.ToChannelCredentials()
};
SessionsClient sessionsClientFromDefault = sessionsClientBuilderFromDefault.Build();

//Authenticate to the service by using Service Account from channel
GoogleCredential? credentialFromFile = GoogleCredential.FromFile(path).CreateScoped(SessionsClient.DefaultScopes);
Channel channel = new(SessionsClient.DefaultEndpoint, credentialFromFile.ToChannelCredentials());
Sessions.SessionsClient sessionsClientFromChannel = new(channel);

//USE SESSION BUILDER
SessionsClientBuilder sessionsClientBuilderFromCred = new()
{
    GoogleCredential = credentialAccount
};
SessionsClient sessionsClientFromCred = sessionsClientBuilderFromCred.Build();

// From a path to a JSON file
SessionsClient? sessionsClientFromeJson = new SessionsClientBuilder
{
    CredentialsPath = path
}.Build();

// From JSON you already have as a string
string json = File.ReadAllText(path);
SessionsClient? sessionsClientFromJsonString = new SessionsClientBuilder
{
    JsonCredentials = json
}.Build();


DetectIntentRequest request = new()
{
    SessionAsSessionName = SessionName.FromProjectLocationAgentSession("project", "global",
        "agent", "1234session"),
    QueryParams = new QueryParameters(),
    QueryInput = new QueryInput(),
    OutputAudioConfig = new OutputAudioConfig()
};

request.QueryInput.Text = new TextInput
{
    Text = "hello"
};

request.QueryInput.LanguageCode = "en";

// Make the request
DetectIntentResponse response = sessionsClientFromCred.DetectIntent(request);

Console.WriteLine(response);
```

---

## [REST API Client Library](https://developers.google.com/api-client-library/dotnet/apis)

### [DialogFlowCXV3](<https://cloud.google.com/dotnet/docs/reference/Google.Cloud.Dialogflow.Cx.V3/latest>)

#### [Detect Intent](https://cloud.google.com/dotnet/docs/reference/Google.Cloud.Dialogflow.Cx.V3/latest/Google.Cloud.Dialogflow.Cx.V3.SessionsClient#Google_Cloud_Dialogflow_Cx_V3_SessionsClient_DetectIntent_Google_Cloud_Dialogflow_Cx_V3_DetectIntentRequest_Google_Api_Gax_Grpc_CallSettings_)

- using `Google.Apis.Dialogflow.v3.Data`

  ```csharp
  GoogleCloudDialogflowCxV3EventInput eventInput = new GoogleCloudDialogflowCxV3EventInput { Event__ = eventName };
                GoogleCloudDialogflowCxV3DetectIntentRequest detectIntentRequestBody = new GoogleCloudDialogflowCxV3DetectIntentRequest
                {
                    QueryInput = new GoogleCloudDialogflowCxV3QueryInput
                    {
                        Event__ = eventInput,
                        LanguageCode = "en-US"
                    },
                    QueryParams = new GoogleCloudDialogflowCxV3QueryParameters()
                };


                Dictionary<string, object> customParams = visitor
                                                                 .GetType()
                                                                 .GetProperties(BindingFlags.Instance | BindingFlags.Public)
                                                                 .ToDictionary(keySelector: prop => prop.Name, elementSelector: prop => prop.GetValue(visitor, index: null));

                customParams.Add("session-id", sessionId);
                customParams.Add("session-uri", sessionUri);
                detectIntentRequestBody.QueryParams = new GoogleCloudDialogflowCxV3QueryParameters { Parameters = customParams };

                GoogleCloudDialogflowCxV3DetectIntentResponse detectIntentResponse = new DialogflowService(new BaseClientService.Initializer
                {
                    HttpClientInitializer = credential,
                    ApplicationName = projectId
                }).Projects
                    .Locations
                    .Agents
                    .Sessions
                    .DetectIntent(detectIntentRequestBody, sessionUri)
                    .Execute();

  ```

    - using GoogleCloudGoogle.Cloud.DialogflowGoogle.Cloud.Dialogflow.CxV3

      ```csharp
          // Create client
        SessionsClient sessionsClient = SessionsClient.Create();
        // Initialize request argument(s)
        DetectIntentRequest request = new DetectIntentRequest
        {
            SessionAsSessionName = SessionName.FromProjectLocationAgentSession("[PROJECT]", "[LOCATION]", "[AGENT]", "[SESSION]"),
            QueryParams = new QueryParameters(),
            QueryInput = new QueryInput(),
            OutputAudioConfig = new OutputAudioConfig(),
        };
        // Make the request
        DetectIntentResponse response = sessionsClient.DetectIntent(request);
  
        //or
        public virtual Task<DetectIntentResponse> DetectIntentAsync(DetectIntentRequest request, CallSettings callSettings = null)
      ```

#### [DetectIntentResponse](https://cloud.google.com/dotnet/docs/reference/Google.Cloud.Dialogflow.Cx.V3/latest/Google.Cloud.Dialogflow.Cx.V3.DetectIntentResponse)

```json
{
  "responseId": "bda416d2-134c-4bbb-a0a1-37820eb0257e",
  "queryResult": {
    "text": "test",
    "languageCode": "en",
    "parameters": {
      "session-id": "a57d22-fbe-afb-ee4-69a8f62b3",
      "session-url": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/environments/ec5f3114-e5d6-497f-bf92-53723c698230/sessions/a57d22-fbe-afb-ee4-69a8f62b3"
    },
    "responseMessages": [
      {
        "text": {
          "text": [
            "When you test me that helps my developers improve my performance."
          ],
          "allowPlaybackInterruption": true
        }
      },
      {}
    ],
    "currentPage": {
      "name": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/flows/00000000-0000-0000-0000-000000000000/pages/START_PAGE",
      "displayName": "Start Page"
    },
    "intent": {
      "name": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/intents/3a13ea29-83bd-4131-9144-2f511b42fcc2",
      "displayName": "small_talk.user.testing_agent"
    },
    "intentDetectionConfidence": 1,
    "diagnosticInfo": {
      "Transition Targets Chain": [
        {
          "TargetFlow": "7bf60f85-19fe-48bd-ac27-2b5db2cde4de"
        },
        {
          "TargetPage": "END_FLOW"
        }
      ],
      "Session Id": "a57d22-fbe-afb-ee4-69a8f62b3",
      "Triggered Transition Names": [
        "807b27e2-59da-4a37-8b1c-c7d109cb816f",
        "807b27e2-59da-4a37-8b1c-c7d109cb816f"
      ],
      "Execution Sequence": [],
      "Alternative Matched Intents": [
        {
          "Active": true,
          "Id": "3a13ea29-83bd-4131-9144-2f511b42fcc2",
          "Type": "NLU",
          "Score": 1,
          "DisplayName": "small_talk.user.testing_agent"
        }
      ]
    },
    "match": {
      "intent": {
        "name": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/intents/3a13ea29-83bd-4131-9144-2f511b42fcc2",
        "displayName": "small_talk.user.testing_agent"
      },
      "resolvedInput": "test",
      "matchType": "INTENT",
      "confidence": 1
    }
  },
  "responseType": "FINAL"
}
```

---

#### [WebhookRequest](https://cloud.google.com/dotnet/docs/reference/Google.Cloud.Dialogflow.Cx.V3/latest/Google.Cloud.Dialogflow.Cx.V3.WebhookRequest#Google_Cloud_Dialogflow_Cx_V3_WebhookRequest__ctor)

- Get WebhookRequest , From DialogFlowCX request call

    - .Net Core 6

      ```csharp
        public async Task HandleAsync(HttpContext context){
            HttpRequest httpRequest = context.Request;
            HttpResponse httpResponse = context.Response;
  
            using TextReader reader = new StreamReader(httpRequest.Body);
            string text = await reader.ReadToEndAsync();
  
            JsonParser.Settings parserSettings = JsonParser.Settings.Default.WithIgnoreUnknownFields(true);
            JsonParser          jParser        = new (parserSettings);
            WebhookRequest      webhookRequest = jParser.Parse <WebhookRequest>(text);
            SessionInfo         sessionInfo    = webhookRequest.SessionInfo;
            string              tag            = webhookRequest.FulfillmentInfo.Tag;
            sessionInfo.Parameters.TryGetValue(key: "name", value: out var nameParameterValue);
  
            ...
  
            JsonFormatter formatter = new JsonFormatter(new JsonFormatter.Settings(true));
  
  
            httpResponse.ContentType = "application/json; charset=UTF-8";
            httpResponse.Headers.Append(key: "Access-Control-Allow-Methods", value: "GET");
            httpResponse.Headers.Append(key: "Access-Control-Allow-Headers", value: "Content-Type");
  
            // await httpResponse.WriteAsync(response.ToString());
            await httpResponse.WriteAsync(formatter.Format(response));
            await httpResponse.Body.FlushAsync();
        }
      ```

    - .Net Framework 4.8

      ```csharp
       public async Task<IHttpActionResult> Post(object sender)
            {
                 HttpRequest httpRequest = HttpContext.Current.Request;
                TextReader reader = new StreamReader(httpRequest.InputStream);
                string text = await reader.ReadToEndAsync();
  
                _log.Info($"http request body- WebhookRequest : {text}");
  
                JsonParser.Settings parserSettings = JsonParser.Settings.Default.WithIgnoreUnknownFields(true);
                JsonParser jParser = new JsonParser(parserSettings);
                WebhookRequest webhookRequest = jParser.Parse<WebhookRequest>(text);
                SessionInfo sessionInfo = webhookRequest.SessionInfo;
                string tag = webhookRequest.FulfillmentInfo.Tag;
                sessionInfo.Parameters.TryGetValue(key: "name", value: out Value nameParameterValue);
  
                ...
  
                return Json(JsonConvert.DeserializeObject(response.ToString()));
            }
      ```

##### JSON Example

```json
{
  "detectIntentResponseId": "ffd03c89-b8c3-4d43-99ac-a31f5cc3e761",
  "pageInfo": {
    "currentPage": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/flows/00000000-0000-0000-0000-000000000000/pages/START_PAGE",
    "displayName": "Start Page"
  },
  "sessionInfo": {
    "session": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/sessions/ffd700-fa3-4dc-d35-231249af3",
    "parameters": {
      "name": "rusty"
    }
  },
  "fulfillmentInfo": {
    "tag": "comm100-customfields"
  },
  "triggerEvent": "initiate-bot-event",
  "languageCode": "en"
}
```

###### JSON With types for Protobuf

```json
{
  "detectIntentResponseId": "e8379fe3-5090-44be-8df4-a064b5ebb3dc",
  "intentInfo": {
    "lastMatchedIntent": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/intents/00000000-0000-0000-0000-000000000000",
    "displayName": "Default Welcome Intent",
    "confidence": 1.0
  },
  "pageInfo": {
    "currentPage": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/flows/00000000-0000-0000-0000-000000000000/pages/START_PAGE",
    "displayName": "Start Page"
  },
  "sessionInfo": {
    "session": "projects/vcu-virtual-assistant-bot/locations/global/agents/8ec51540-2933-43d6-aad5-355545059bfe/sessions/40e94b-779-70d-a9f-3e08ab3fe",
    "parameters": {
      "@type": "type.googleapis.com/google.protobuf.Struct",
      "name": {
        "@type": "type.googleapis.com/google.protobuf.Value",
        "StringValue": "rusty"
      }
    }
  },
  "fulfillmentInfo": {
    "tag": "comm100-customfields"
  },
  "messages": [
    {
      "text": {
        "text": [
          "Greetings! How can I assist?"
        ],
        "redactedText": [
          "Greetings! How can I assist?"
        ]
      },
      "responseType": "HANDLER_PROMPT",
      "source": "VIRTUAL_AGENT"
    }
  ],
  "text": "hello",
  "languageCode": "en"
}
```

---

#### [WebhookResponse](https://cloud.google.com/dotnet/docs/reference/Google.Cloud.Dialogflow.Cx.V3/latest/Google.Cloud.Dialogflow.Cx.V3.WebhookResponse)

- `using Google.Apis.Dialogflow.v3.Data`

```csharp
GoogleCloudDialogflowCxV3WebhookResponse response = new GoogleCloudDialogflowCxV3WebhookResponse
                {
                    FulfillmentResponse = new GoogleCloudDialogflowCxV3WebhookResponseFulfillmentResponse
                        {
                            Messages = new List <GoogleCloudDialogflowCxV3ResponseMessage>()
                        },
                    SessionInfo = new GoogleCloudDialogflowCxV3SessionInfo
                        {
                            Parameters = new Dictionary <string, object>()
                        }
                };
```

- using `Google.Cloud.Dialogflow.Cx.V3`

```csharp
WebhookResponse response = new WebhookResponse
        {
            FulfillmentResponse = new WebhookResponse.Types.FulfillmentResponse()
        };
```

---

##### JSON Example

```json
{
  "fulfillmentResponse": {
    "mergeBehavior": null,
    "messages": [],
    "ETag": null
  },
  "pageInfo": null,
  "payload": null,
  "sessionInfo": {
    "parameters": {
      "security-code": "69420"
    },
    "session": null,
    "ETag": null
  },
  "targetFlow": null,
  "targetPage": null,
  "ETag": null
}
```

---

### [Logging](https://cloud.google.com/logging/docs/reference/libraries)

#### [Logging Code Examples](https://cloud.google.com/logging/docs/samples?hl=en)

#### [Writing Logs](https://cloud.google.com/functions/docs/monitoring/logging)

#### [Configuring Longs](https://cloud.google.com/dotnet/docs/reference/Google.Cloud.Diagnostics.AspNetCore3/latest#configuration-1)

---

### [Google.Protobuf.WellKnownTypes](https://protobuf.dev/reference/protobuf/google.protobuf/#value)

#### - [API Docs](https://protobuf.dev/reference/csharp/api-docs/)

#### - [GIT Protocol Buffers](https://github.com/protocolbuffers/protobuf/blob/main/README.md)

#### - [Protobuf Reference](https://cloud.google.com/dotnet/docs/reference/help/protobuf)

#### - [Namespace Google.Protobuf.WellKnownTypes (3.15.8)](https://cloud.google.com/dotnet/docs/reference/Google.Protobuf/latest/Google.Protobuf.WellKnownTypes)

- parsing a variable into googles protobuf Value object

  ```csharp
     string key = fieldObject
                       .GetProperty("name")
                       .GetString()?.Trim().ToLower()
                       .Replace(oldValue: " ", newValue: "-");

      Value  value = Value.ForString(fieldObject.GetProperty("value").GetString());

     if(!string.IsNullOrEmpty(key)) {
       response.SessionInfo.Parameters.Add(key: key, value: value);
     }
  ```

- deserialize into object

    - [JsonFormatter](https://cloud.google.com/dotnet/docs/reference/Google.Protobuf/latest/Google.Protobuf.JsonFormatter)

      ```csharp
         using Google.Protobuf.JsonFormatter;
  
        JsonFormatter formatter = new JsonFormatter(new JsonFormatter.Settings(true));
         string jsonString = formatter.Format(testMessage);
      ```

    - [JsonParser](https://cloud.google.com/dotnet/docs/reference/Google.Protobuf/latest/Google.Protobuf.JsonParser)

      ```csharp
          using Google.Protobuf.JsonParser;
  
              JsonParser.Settings parserSettings = JsonParser.Settings.Default.WithIgnoreUnknownFields(true);
              JsonParser jParser = new JsonParser(parserSettings);
              WebhookRequest webhookRequest = jParser.Parse<WebhookRequest>(text);
      ```