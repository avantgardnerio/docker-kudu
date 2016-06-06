Build
-----
docker build -t docker-kudu .

Run master
----------
docker run -d --name kudu-master -p 8051:8051 -it docker-kudu master

Run tablet
----------
docker run -d --name kudu-tserver -p 8050:8050 --link kudu-master -e KUDU_MASTER=kudu-master docker-kudu tserver

View logs
---------
docker logs -f kudu-master
docker logs -f kudu-tserver

Console
-------
docker run --rm -it --link kudu-tserver -e KUDU_TSERVER=kudu-tserver docker-kudu cli status
