---
title:        HttpRepl
permalink:    DotNetNotes/HttpRepl
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

# [HttpRepl](https://learn.microsoft.com/en-us/aspnet/core/web-api/http-repl/?view=aspnetcore-7.0&tabs=windows)

## - setup

```bash
#install
 dotnet tool install;

#set path to tools
export PATH="$PATH:/Users/bp/.dotnet/tools";

#test web api
httprepl http://localhost:5001 
```

</br>

## - list and select controllers

```
ls , cd
```

</br>

## - post

> >

```bash
post -c "{"name":"Hawaii", "isGlutenFree":false}"
```