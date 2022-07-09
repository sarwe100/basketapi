
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /Basket
EXPOSE 80

COPY ["Basket.API/Basket.API.csproj", "Basket.API/"]
RUN dotnet restore "Basket.API/Basket.API.csproj"
COPY . .
WORKDIR "/Basket/Basket.API"
RUN dotnet build "Basket.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Basket.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Basket.API.dll"]