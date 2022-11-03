cd ..
@call .\env.cmd 
set IMAGE_NAME=bit-server-base
echo start %IMAGE_NAME% to %CONTAINER_NAME% : %WEB_PORT%
docker run -d -it -p %WEB_PORT%:80 -p %SSH_PORT%:22 -p 8787:8787 -p %SHINY_PORT%:3838  -p %SSL_PORT%:443 --name %CONTAINER_NAME% -v "%cd%\..\workspace:/home/bit-server/workspace" %IMAGE_NAME%
