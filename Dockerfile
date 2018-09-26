FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

COPY . .
RUN dotnet restore


WORKDIR /app/critical-core

RUN dotnet publish -c Release -o dist

FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app

COPY --from=build /app/critical-core/dist ./

EXPOSE 80

ENTRYPOINT ["dotnet", "critical-core.dll"]

