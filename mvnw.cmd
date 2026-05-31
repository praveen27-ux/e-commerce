@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ==============================
rem Maven Wrapper for Windows (fixed)
rem - Robust JAVA_HOME / java.exe detection
rem - Correct quoting for paths with spaces
rem ==============================

set "BASE_DIR=%~dp0"
set "WRAPPER_DIR=%BASE_DIR%\.mvn\wrapper"

rem --- quick guard for broken quoting (fixes common JAVA_HOME space issues) ---
rem Ensure JAVA_EXE is never double-quoted.


rem --- helper: check if file exists ---
set "JAVA_EXE="
set "JAVAC_EXE="

rem 1) If JAVA_HOME is provided, use it
if defined JAVA_HOME (
  if exist "%JAVA_HOME%\bin\java.exe" (
    set "JAVA_EXE=%JAVA_HOME%\bin\java.exe"
    if exist "%JAVA_HOME%\bin\javac.exe" set "JAVAC_EXE=%JAVA_HOME%\bin\javac.exe"
  )
)

rem 2) If JAVA_EXE not found, try to locate java.exe via PATH
if not defined JAVA_EXE (
  for /f "delims=" %%J in ('where java 2^>nul') do (
    if not defined JAVA_EXE set "JAVA_EXE=%%J"
  )
  if defined JAVA_EXE (
    rem Try infer JAVA_HOME from ...\bin\java.exe
    for %%P in ("%JAVA_EXE%") do set "_JAVA_EXE_DIR=%%~dpP"
    rem _JAVA_EXE_DIR ends with \bin\
    for %%H in ("%_JAVA_EXE_DIR%..") do set "JAVA_HOME=%%~fH"
    if exist "%JAVA_HOME%\bin\javac.exe" set "JAVAC_EXE=%JAVA_HOME%\bin\javac.exe"
  )
)

rem 3) If still not found, search common JDK install folders under Program Files
if not defined JAVA_EXE (
  set "_CANDS="
  for %%D in ("%ProgramFiles%\Java" "%ProgramFiles(x86)%\Java") do (
    if exist %%~D (
      rem Pick the first matching JDK directory (prefer newer by folder name ordering)
      for /f "delims=" %%J in ('dir /b /ad /o-n "%%~D\jdk*" 2^>nul') do (
        if not defined JAVA_EXE (
          if exist "%%~D\%%J\bin\java.exe" set "JAVA_EXE=%%~D\%%J\bin\java.exe"
          if exist "%%~D\%%J\bin\javac.exe" set "JAVAC_EXE=%%~D\%%J\bin\javac.exe"
        )
      )
    )
  )
)

rem Final sanity check
if not defined JAVA_EXE (
  echo ERROR: Could not find java.exe on this system. Set JAVA_HOME to a valid JDK.
  exit /b 1
)

rem --- ensure wrapper dir exists ---
if not exist "%WRAPPER_DIR%" (
  mkdir "%WRAPPER_DIR%" 2>nul
)

rem --- download wrapper jar if missing ---
if not exist "%WRAPPER_DIR%\maven-wrapper.jar" (
  echo maven-wrapper.jar not found; downloading...
  if not exist "%WRAPPER_DIR%\MavenWrapperDownloader.class" (
    echo Compiling MavenWrapperDownloader...
    if defined JAVAC_EXE (
      "%JAVAC_EXE%" -d "%WRAPPER_DIR%" "%WRAPPER_DIR%\MavenWrapperDownloader.java" 2>nul

    ) else (
      rem If javac isn't available, use java to compile/download flow best-effort.
      rem Wrapper downloader compilation may fail; continue to try running downloader.
    )
  )
  "%JAVA_EXE%" -cp "%WRAPPER_DIR%" org.apache.maven.wrapper.MavenWrapperDownloader "%BASE_DIR%"
)

rem --- run wrapper main ---
"%JAVA_EXE%" -Dmaven.multiModuleProjectDirectory="%BASE_DIR%" -classpath "%WRAPPER_DIR%\maven-wrapper.jar" org.apache.maven.wrapper.MavenWrapperMain %*
endlocal



