@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ===============================
rem WebSpeak backend runner (no mvnw)
rem - Downloads Maven locally if needed
rem - Uses local Maven to run spring-boot
rem ===============================

set "BASE_DIR=%~dp0"
set "MAVEN_DIR=%BASE_DIR%\.mvn-local"
set "MAVEN_BIN=%MAVEN_DIR%\bin\mvn.cmd"
set "GROUP_DIR=%MAVEN_DIR%\.."

if not exist "%MAVEN_DIR%" mkdir "%MAVEN_DIR%" 2>nul

rem Try to download Maven 3.9.6
if not exist "%MAVEN_BIN%" (
  echo Maven not found locally. Downloading Maven...
  set "ZIP_URL=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.6/apache-maven-3.9.6-bin.zip"
  set "ZIP_PATH=%MAVEN_DIR%\apache-maven-3.9.6-bin.zip"

  powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile '%ZIP_PATH%' -UseBasicParsing } catch { exit 1 }"
  if errorlevel 1 (
    echo Failed to download Maven.
    exit /b 1
  )

  powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Path '%ZIP_PATH%' -DestinationPath '%MAVEN_DIR%' -Force"
)

rem Maven extracted folder name
set "EXTRACT_DIR=%MAVEN_DIR%\apache-maven-3.9.6"
if not exist "%EXTRACT_DIR%\bin\mvn.cmd" (
  echo Maven extraction not found at: %EXTRACT_DIR%
  exit /b 1
)

set "MAVEN_BIN=%EXTRACT_DIR%\bin\mvn.cmd"

echo Starting backend on 8081...
"%MAVEN_BIN%" -f "%BASE_DIR%pom.xml" spring-boot:run -Dspring-boot.run.arguments=--server.port=8081

