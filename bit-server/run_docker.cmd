docker run -d --rm -p 3939:3838 -p 9090:80 -p 8443:443 -p 2222:22 -v "%cd%\..\workspace:/home/bit-server/workspace" joygram/bit-server 
