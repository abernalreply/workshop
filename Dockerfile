FROM microsoft/dotnet:2.1-sdk as build-env
WORKDIR /build
COPY . ./
RUN dotnet restore TodoApi.csproj
RUN dotnet publish -c Release -o out TodoApi.csproj
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /build/out/ ./
EXPOSE 80
ENTRYPOINT ["dotnet", "TodoApi.dll"]
