- https://learn.microsoft.com/en-us/training/modules/build-web-api-aspnet-core/6-exercise-add-controller
- https://dotnet.microsoft.com/en-us/apps/aspnet



# Run
```bash
dotnet run --urls=https://localhost:5101
```

# HttpRepl

```bash
 dotnet tool install;

export PATH="$PATH:/Users/bp/.dotnet/tools";
httprepl http://localhost:5001                  
```

- list and select controllers
 > ls , cd

- post
```bash
post -c "{"name":"Hawaii", "isGlutenFree":false}"
```

# Entity Framework
## add
```bash
dotnet add package Microsoft.EntityFrameworkCore.Sqlite;
dotnet add package Microsoft.EntityFrameworkCore.Design;
dotnet tool install --global dotnet-ef;
```

## create db tables
```bash
using ContosoPizza.Data;
```

## apply create
```bash
dotnet ef database update --context PizzaContext
```
## revisions
```bash
dotnet ef migrations add ModelRevisions --context PizzaContext
```

## update
```bash
dotnet ef database update --context PizzaContext
```

## Build scafolding
```bash
dotnet ef dbcontext scaffold "Data Source=./Promotions/Promotions.db" Microsoft.EntityFrameworkCore.Sqlite --context-dir ./Data --output-dir .\Models
```
-
```
The preceding command:

Scaffolds a DbContext and model classes using the provided connection string.
Specifies the Microsoft.EntityFrameworkCore.Sqlite database provider should be used.
Specifies directories for the resulting DbContext and model classes.
```
