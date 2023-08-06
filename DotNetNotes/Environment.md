---
title:        Environment
permalink:    DotNetNotes/Environment
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

## Set ENV variable

```xmls
<aspNetCore processPath="%LAUNCHER_PATH%" arguments="%LAUNCHER_ARGS%" stdoutLogEnabled="false" stdoutLogFile=".\logs\stdout" forwardWindowsAuthToken="false">
    <environmentVariables>
        <environmentVariable name="ASPNETCORE_ENVIRONMENT" value="QA" />
        <environmentVariable name="AnotherVariable" value="My Value" />
    </environmentVariables>
</aspNetCore>
```

or

-- set in launchSettings.json

```json
    "https": {
"commandName": "Project",
"dotnetRunMessages": true,
"launchBrowser": true,
"launchUrl": "swagger",
"applicationUrl": "https://localhost:7278;http://localhost:5277",
"environmentVariables": {
"ASPNETCORE_ENVIRONMENT": "Development",
"GOOGLE_APPLICATION_CREDENTIALS": "C:\\Users\\bp01232023\\source\\repos\\GoogleCloudLogging\\application_default_credentials.json"
}
}
}
```

# MVC

## Set ENV variable

- set in Web.config

```xml

<appSettings>
    <add key="ENV" value="DEV"/>
</appSettings>
```

# C#

```csharp
public class EnvironmentService
    {

        string GetAppSettingValue(string key)
        {
            return ConfigurationManager.AppSettings[key];
        }

        public bool SetEnvironmentVariableFromAppSetting(string envVariableName)
        {
            var envSet = !string.IsNullOrWhiteSpace(Environment.GetEnvironmentVariable(envVariableName));

            if (!envSet)
            {
                var envValue = GetAppSettingValue(envVariableName);
                envSet = !string.IsNullOrWhiteSpace(envValue);

                if (envSet)
                {
                    Environment.SetEnvironmentVariable(envVariableName, envValue);
                    return envSet;
                }
            }

            return envSet;
        }

    }
```