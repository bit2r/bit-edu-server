docker run -d --rm -p 3939:3838 -p 80:8080 -p 443:8443 -p 22:2222 -v "$(pwd)\..\workspace:/home/bit-server/workspace" bit-server-local
