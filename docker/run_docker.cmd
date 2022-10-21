@call .\env.cmd 
set IMAGE_NAME=joygram/bit-server:latest
echo start %IMAGE_NAME% to %CONTAINER_NAME% : %WEB_PORT%
rem docker run -d --rm -p %WEB_PORT%:80 -p %SSH_PORT%:22 -p %SHINY_PORT%:3838  -p %SSL_PORT%:443 -p %RSTUDIO_PORT%:8787 --name %CONTAINER_NAME% -v "%cd%\..\workspace:/home/bit-server/workspace" %IMAGE_NAME%
docker run -d -it -p %WEB_PORT%:80 -p %SSH_PORT%:22 -p 8080:8080 -p 5000:5000 --name %CONTAINER_NAME% -v "%cd%\..\workspace:/home/bit-server/workspace" %IMAGE_NAME%
