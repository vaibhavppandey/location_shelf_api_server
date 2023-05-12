A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This code handles HTTP GET requests to `/`,  `/test/<message>` and `/location` w/ optional boolean field `random`.

# Running api server

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8080 and host localhost
```

And then from a second terminal:
```
$ curl http://localhost:8080
Hello, World!
$ curl http://localhost/location?random=true
{"ip":"200.53.20.122","location":"Brazil"}
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /location?random=true
```
