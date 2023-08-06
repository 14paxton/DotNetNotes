---
title:        Controllers
permalink:    DotNetNotes/Controllers
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

# Core

## [create controllers](https://learn.microsoft.com/en-us/aspnet/core/web-api/?view=aspnetcore-7.0)

### [controller return actions](https://learn.microsoft.com/en-us/aspnet/core/web-api/action-return-types?view=aspnetcore-7.0)

# ASP

## [Samples](https://github.com/aspnet/samples/tree/main/samples/aspnet/WebApi)

## [WebAPI](https://learn.microsoft.com/en-us/aspnet/web-api/)

---

### Context

> HttpContext exists on both the .NET Framework and .NET Core (both of which implement .NET Standard, by the way), but being specific to the Web, it does not exist on .NET Standard.

> So, you have three options:

1. Target the .NET Framework and use System.Web.HttpContext
2. Target .NET Core and use Microsoft.AspNetCore.Http.HttpContext
3. Move the logic that uses HttpContext away from the .NET Standard project
   Do notice, though, that those classes vary greatly. The .NET Core version was created for ASP.NET Core which is vastly different to ASP.NET 4.5 and olders.

#### .Net Core

- GCP serverless function example

```csharp
public class Function : IHttpFunction {
     public async Task HandleAsync(HttpContext context){
        HttpRequest httpRequest = context.Request;
        HttpResponse httpResponse = context.Response;
        WebhookResponse response = new WebhookResponse
        {
            FulfillmentResponse = new WebhookResponse.Types.FulfillmentResponse()
        };
        using TextReader reader = new StreamReader(httpRequest.Body);
        string text = await reader.ReadToEndAsync();
        WebhookRequest webhookRequest = JsonParser.Default.Parse<WebhookRequest>(text);
        SessionInfo sessionInfo = webhookRequest.SessionInfo;
        string tag = webhookRequest.FulfillmentInfo.Tag;
        sessionInfo.Parameters.TryGetValue(key: "name", value: out var nameParameterValue);

        /*

        MY CODE

        */

        var formatter = new JsonFormatter(new JsonFormatter.Settings(true));
        httpResponse.ContentType = "application/json; charset=UTF-8";
        httpResponse.Headers.Append(key: "Access-Control-Allow-Methods", value: "GET");
        httpResponse.Headers.Append(key: "Access-Control-Allow-Headers", value: "Content-Type");
        // await httpResponse.WriteAsync(response.ToString());
        await httpResponse.WriteAsync(formatter.Format(response));
        await httpResponse.Body.FlushAsync();
    }
}
```

##### HTTP context accessor

> you can use the IHttpContextAccessor helper service to get the HTTP context in any class that is managed by the ASP.NET Core dependency injection system. This is useful when you have a common service that is used by your controllers.

- Request this interface in your constructor:

  ```csharp
      public MyMiddleware(IHttpContextAccessor httpContextAccessor)
      {
          _httpContextAccessor = httpContextAccessor;
      }
  ```

- You can then access the current HTTP context in a safe way:

  ```charp
      var context = _httpContextAccessor.HttpContext;
      // Do something with the current HTTP context...
  ```

- IHttpContextAccessor isn't always added to the service container by default, so register it in ConfigureServices just to be safe:

  ```csharp
      public void ConfigureServices(IServiceCollection services)
      {
          services.AddHttpContextAccessor();
          // if < .NET Core 2.2 use this
          //services.TryAddSingleton<IHttpContextAccessor, HttpContextAccessor>();
          // Other code...
      }
  ```

#### [.Net Framework 4+](https://learn.microsoft.com/en-us/dotnet/api/system.web.httpcontext?view=netframework-4.8.1)

```csharp
public static string GetRequestBody()
{
    var bodyStream = new StreamReader(HttpContext.Current.Request.InputStream);
    bodyStream.BaseStream.Seek(0, SeekOrigin.Begin);
    var bodyText = bodyStream.ReadToEnd();
    return bodyText;
}
```

```csharp
public async Task<IHttpActionResult> GetSomething()
{
    var rawMessage = await Request.Content.ReadAsStringAsync();
    // ...
    return Ok();
}
```

- using extention method

```csharp
using System.IO;
using System.Text;

namespace System.Web.Http
{
    public static class ApiControllerExtensions
    {
        public static string GetRequestBody(this ApiController controller)
        {
            using (var stream = new MemoryStream())
            {
                var context = (HttpContextBase)controller.Request.Properties["MS_HttpContext"];
                context.Request.InputStream.Seek(0, SeekOrigin.Begin);
                context.Request.InputStream.CopyTo(stream);
                var requestBody = Encoding.UTF8.GetString(stream.ToArray());
                return requestBody;
            }
        }
    }
}
```

```csharp
      public static async Task<HttpResponseMessage> Run([HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = "HttpTriggerCSharp/name/{name}")]HttpRequestMessage req, string name, TraceWriter log)
    {
        log.Info("C# HTTP trigger function processed a request.");

        dynamic dataArray = await req.Content.ReadAsAsync<object>();

        string output = dataArray.ToString();

        var data = Newtonsoft.Json.JsonConvert.DeserializeObject<Benutzer>(output);

        // Fetching the name from the path parameter in the request URL
        return req.CreateResponse(HttpStatusCode.OK, data);

    }
```

---

**NOTE**

> if you're receiving an empty string from this method, it means something else has already read it. When it does that, it leaves the pointer at the end. An alternative method of doing this is as follows:

```csharp
public IHttpActionResult GetSomething()
{
    var reader = new StreamReader(Request.Body);
    reader.BaseStream.Seek(0, SeekOrigin.Begin);
    var rawMessage = reader.ReadToEnd();

    return Ok();

}
```

> In this case, your endpoint doesn't need to be async (unless you have other async-methods)

---

> - For other future users who do not want to make their controllers asynchronous, or cannot access the HttpContext, or are using dotnet core (this answer is the first I found on Google trying to do this), the following worked for me:

```csharp
     [HttpPut("{pathId}/{subPathId}"),
     public IActionResult Put(int pathId, int subPathId, [FromBody] myViewModel viewModel)
     {
         var body = new StreamReader(Request.Body);
         //The modelbinder has already read the stream and need to reset the stream index
         body.BaseStream.Seek(0, SeekOrigin.Begin);
         var requestBody = body.ReadToEnd();
         //etc, we use this for an audit trail
     }
```

---

##### [Request](https://learn.microsoft.com/en-us/dotnet/api/system.web.httprequestbase?view=netframework-4.8.1)

###### use query string

```csharp
public partial class AddToCart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string rawId = Request["ProductID"];
            int productId;
            if (!String.IsNullOrEmpty(rawId) && int.TryParse(rawId, out productId))
            {
                using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
                {
                    usersShoppingCart.AddToCart(productId);
                }
            }
            else
            {
                throw new Exception("Tried to call AddToCart.aspx without setting a ProductId.");
            }
            Response.Redirect("ShoppingCart.aspx");
        }
    }
```

- also

  ```csharp
         string fullname1 = Request.QueryString["fullname"];
  ```

###### is authenticated

```csharp
        public partial class RestrictedPage : Page

    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                var rawUrl = Request.RawUrl;
                Response.Redirect("/Account/Login?ru=" + Server.HtmlEncode(rawUrl));
            }
        }
    }
```

###### form

```csharp
        int loop1;
        NameValueCollection coll;

        //Load Form variables into NameValueCollection variable.
        coll=Request.Form;
        // Get names of all forms into a string array.
        String[] arr1 = coll.AllKeys;
        for (loop1 = 0; loop1 < arr1.Length; loop1++)
        {
           Response.Write("Form: " + arr1[loop1] + "<br>");
        }
```

###### cookies

```csharp
int loop1, loop2;
HttpCookieCollection MyCookieColl;
HttpCookie MyCookie;

MyCookieColl = Request.Cookies;

// Capture all cookie names into a string array.
String[] arr1 = MyCookieColl.AllKeys;

// Grab individual cookie objects by cookie name.
for (loop1 = 0; loop1 < arr1.Length; loop1++)
{
   MyCookie = MyCookieColl[arr1[loop1]];
   Response.Write("Cookie: " + MyCookie.Name + "<br>");
   Response.Write ("Secure:" + MyCookie.Secure + "<br>");

   //Grab all values for single cookie into an object array.
   String[] arr2 = MyCookie.Values.AllKeys;

   //Loop through cookie Value collection and print all values.
   for (loop2 = 0; loop2 < arr2.Length; loop2++)
   {
      Response.Write("Value" + loop2 + ": " + Server.HtmlEncode(arr2[loop2]) + "<br>");
   }
}
```

###### server variables

```csharp
int loop1, loop2;
NameValueCollection coll;

// Load ServerVariable collection into NameValueCollection object.
coll=Request.ServerVariables;
// Get names of all keys into a string array.
String[] arr1 = coll.AllKeys;
for (loop1 = 0; loop1 < arr1.Length; loop1++)
{
   Response.Write("Key: " + arr1[loop1] + "<br>");
   String[] arr2=coll.GetValues(arr1[loop1]);
   for (loop2 = 0; loop2 < arr2.Length; loop2++) {
      Response.Write("Value " + loop2 + ": " + Server.HtmlEncode(arr2[loop2]) + "<br>");
   }
}
```

#### [Response](https://learn.microsoft.com/en-us/dotnet/api/system.web.httpresponsebase?view=netframework-4.8.1)

```csharp
HttpResponseMessage fullResponse = Request.CreateResponse(HttpStatusCode.OK);
                fullResponse.Content = new StreamContent(memStream);
                fullResponse.Content.Headers.ContentType = _mediaType;
                return fullResponse;
```

---

# Serialize/Deserialize

```csharp
ValueTask<WebhookRequest> t  = JsonSerializer.DeserializeAsync<WebhookRequest>(httpRequest.Body);
WebhookRequest uu = t.Result;
```

```csharp
 TextReader      reader   = new StreamReader(httpRequest.Body);
 string          text     = await reader.ReadToEndAsync();
JsonElement     json     = JsonSerializer.Deserialize <JsonElement>(text);
JsonElement json2 = JsonConvert.DeserializeObject<JsonElement>(text, new JsonSerializerSettings());
string json3 = JsonConvert.SerializeObject(json, typeof(String), new JsonSerializerSettings());
```

```csharp
WebhookRequest webhookRequest = new WebhookRequest(json.Deserialize <WebhookRequest>());
```

```csharp
webhookRequest = (WebhookRequest) JsonConvert.DeserializeObject <object>(JsonConvert.DeserializeObject(text, typeof(object)).ToString(), new JsonSerializerSettings());
```

```csharp
WebhookRequest webhookRequest1 = JsonConvert.DeserializeObject <WebhookRequest>(text);
JsonConvert.PopulateObject( JsonConvert.ToString(json),  webhookRequest);
```

```csharp
string         h   =  JsonConvert.ToString(text);

```

```csharp
WebhookRequest pp  = JsonSerializer.Deserialize <WebhookRequest>(text);

```

```csharp
WebhookRequest   pp2 = json.Deserialize <WebhookRequest>();

```

```csharp
 object pp3 = JsonSerializer.Deserialize(text, typeof(WebhookRequest));

```

```csharp
  object   pp4 = json.Deserialize( typeof(WebhookRequest));

```

```csharp
 object   w   = JsonConvert.DeserializeObject(value: text, type: typeof(WebhookRequest));

```

```csharp
 object i   = json.Deserialize( typeof(WebhookRequest));

```

```csharp
object  kk  = json.Deserialize(typeof(WebhookRequest));
```

```csharp
WebhookRequest webhookRequest = new WebhookRequest
JsonConvert.PopulateObject(value: text, target: webhookRequest);
```

```csharp
 JObject.Parse(request.Content.ReadAsStringAsync().Result);
```

```csharp
var content = response.Content;
  var jsonResult = JsonConvert.DeserializeObject(content).ToString();
  var result= JsonConvert.DeserializeObject<Model>(jsonResult);
```