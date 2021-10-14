FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env


WORKDIR /testservice
COPY . .
EXPOSE 7001
ENV ASPNETCORE_URLS="http://*:7001"

RUN dotnet restore
RUN dotnet publish -c Development -o out

FROM mcr.microsoft.com/dotnet/nightly/aspnet:5.0
WORKDIR /testservice
COPY --from=build-env /testservice/out .
ENTRYPOINT ["dotnet", "TestService.dll"]