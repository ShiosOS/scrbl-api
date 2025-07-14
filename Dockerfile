# Use the SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["ScrblApi.csproj", "./"]
RUN dotnet restore
COPY . .
WORKDIR "/src/."
RUN dotnet build "ScrblApi.csproj" -c Release -o /app/build

# Use the ASP.NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/build .
ENV ASPNETCORE_URLS="http://+:80" 
EXPOSE 80
ENTRYPOINT ["dotnet", "ScrblApi.dll"]
