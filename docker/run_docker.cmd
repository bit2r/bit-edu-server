@call .\env.cmd 
docker run -d --rm -p %WEB_PORT%:80 -p %SSH_PORT%:22 -p %SHINY_PORT%:3838  -p %SSL_PORT%:443 --name %CONTAINER_NAME% -v "%cd%\..\workspace:/home/bit-server/workspace" joygram/bit-server 
