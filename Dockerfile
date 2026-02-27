FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY OnlineShop.csproj .
RUN dotnet restore OnlineShop.csproj
COPY . .
RUN dotnet publish OnlineShop.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:$"{PORT:-8080}"
ENV ASPNETCORE_ENVIRONMENT=Production
ENTRYPOINT ["dotnet", "OnlineShop.dll"]
