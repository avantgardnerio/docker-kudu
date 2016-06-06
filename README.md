Build
-----
docker build -t docker-kudu .

Run
---
docker run -d --name kudu-master -p 8051:8051 -it docker-kudu master
