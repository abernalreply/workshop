FROM microsoft/aspnetcore-build as build-env
WORKDIR /build
COPY . ./
RUN dotnet restore TodoApi.csproj
RUN dotnet publish -c Release -o out TodoApi.csproj
FROM microsoft/aspnetcore
WORKDIR /app
COPY --from=build-env /build/out/ ./
EXPOSE 5000
ENTRYPOINT ["dotnet", "TodoApi.dll"]
