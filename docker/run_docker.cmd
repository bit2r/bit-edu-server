@call .\env.cmd 
set DAEMON=
if "%1" == "" set DAEMON=-d

set IMAGE_NAME=r2bit/bit-edu-server:latest
set TMP_FS=--tmpfs /run/lock --tmpfs /run -v %CD%\cgroup:/sys/fs/cgroup:ro
set TMP_FS=--privileged


echo start %IMAGE_NAME% to %CONTAINER_NAME% : %WEB_PORT%
docker rm %CONTAINER_NAME%
docker run %DAEMON% -it --hostname %CONTAINER_NAME%  %TMP_FS% -p %WEB_PORT%:80 -p %SSH_PORT%:22 --name %CONTAINER_NAME% -v "%cd%\..\workspace:/home/bit-server/workspace" %IMAGE_NAME%
