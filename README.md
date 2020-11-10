CLIFF Docker
============

The official Docker image for the [CLIFF-CLAVIN](http://cliff.mediacloud.org/) geolocation software. If you want to run this yourself, grab and run the prebuilt image from [the rahulbot/cliff-clavin project on DockerHub](https://hub.docker.com/repository/docker/rahulbot/cliff-clavin/general).

**Note: CLAVIN, and by extension CLIFF, is very memory hungry due to the geonames index. To properly run, a minimum of 4GB of RAM is necessary. Any less and you'll experience errors.**

Building and Running Yourself
-----------------------------

If you don't want to use the prebuilt image, you can build this image yourself using Docker:

```
docker build -t cliff .
```

Run it with enough memory, and sticking to port 8080:

```
docker run -p 8080:8080 -m 8G -d cliff
```

The first time it runs it will take a while to load all the models and database into memory. You can watch the docker logs to monitor the progress. Web requests won't return anything valid while it is loading.

Once it is loaded, you can test it at a URL like:

```
http://localhost:8080/cliff-2.6.1/parse/text?q=This%20is%20some%20text%20about%20New%20York%20City,%20and%20maybe%20about%20Accra%20as%20well,%20and%20maybe%20Boston%20as%20well.
```

Debugging
---------

This takes a lot of memory, so if it doesn't work keep an eye on the docker log for "java.lang.OutOfMemoryError: Java heap space" errors.

Releasing to Docker Hub
-----------------------

I build and release this to DockerHub for easier deployment on your server. To release the latest code I run:
```
docker build -t rahulbot/cliff-clavin .
docker run -p 8080:8080 -m 8G rahulbot/cliff-clavin
docker push rahulbot/cliff-clavin
```

To release a tagged version, I something like this run:
```
docker build -t rahulbot/cliff-clavin:2.6.1 .
docker run -p 8080:8080 -m 8G rahulbot/cliff-clavin:2.6.1
docker push rahulbot/cliff-clavin:2.6.1
```

Acknowledgements
-----------------

This is forked from John Beieler's [cliff-docker](https://github.com/havlicek/cliff-docker),
which pulls heavily from Andy Halterman's [CLIFF-up](https://github.com/ahalterman/CLIFF-up) Vagrant box.
