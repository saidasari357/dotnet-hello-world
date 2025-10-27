# ---- Build Stage ----
FROM mcr.microsoft.com/dotnet/sdk:2.1 AS build
WORKDIR /app
COPY . .
RUN dotnet restore hello-world-api/hello-world-api.csproj
RUN dotnet publish hello-world-api/hello-world-api.csproj -c Release -o out

# ---- Runtime Stage ----
FROM mcr.microsoft.com/dotnet/aspnet:2.1
WORKDIR /app
COPY --from=build /app/hello-world-api/out .
EXPOSE 5000
ENTRYPOINT ["dotnet", "hello-world-api.dll"]
