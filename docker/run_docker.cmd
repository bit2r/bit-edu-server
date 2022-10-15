docker run -d --rm -p 9090:80 -p 4444:22 -p 3939:3838  -p 8443:443  -v "%cd%\..\workspace:/home/bit-server/workspace" joygram/bit-server 
