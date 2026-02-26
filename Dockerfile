# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Runtime (Blindada)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Crear un usuario sin privilegios dentro de Linux
RUN addgroup --system --gid 1000 appgroup \
    && adduser --system --uid 1000 --ingroup appgroup --shell /bin/sh appuser

COPY --from=build /app/publish .

# Cambiar el dueño de los archivos al usuario seguro
RUN chown -R appuser:appgroup /app

# Decirle a Docker que a partir de aquí, somos un usuario normal
USER appuser

EXPOSE 8080
ENTRYPOINT ["dotnet", "TuApp.dll"]