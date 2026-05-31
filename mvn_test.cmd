@echo off
cd /d %~dp0
call mvn -q test

