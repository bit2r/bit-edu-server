@echo off
set WEB_PORT=9090
set SSH_PORT=4444
set SHINY_PORT=3939
set SSL_PORT=8443
set RSTUDIO_PORT=8787
set CONTAINER_NAME=bit-edu-server

set custom_env=..\workspace\conf\env.cmd
if exist %custom_env% (
	call %custom_env%
) else (
	if not exist ..\workspace\conf (
		mkdir ..\workspace\conf
	)
	copy ..\scripts\workspace_template\env.cmd %custom_env%
)