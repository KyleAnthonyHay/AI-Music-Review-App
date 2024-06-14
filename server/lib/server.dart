import 'dart:io';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:postgres/postgres.dart';
import 'dart:convert';

Router configureRoutes() {
  final router = Router();
  router.post('/insert-entry', (Request request) async {
    String content = await request.readAsString();
    final db = await Connection.open(Endpoint(
        host: '10.95.16.3',
        database: 'reviews',
        username: 'postgres',
        password: 'VPtyUmfOBB]VRZCB',
    ));
    List<String> params = [];
    params = content.split(",");
    String p0 = params[0];
    String p1 = params[1];
    String p2 = params[2];
    String p3 = params[3];
    String p4 = params[4];
    String p5 = params[5];
    await db.execute('INSERT INTO user_reviews (reviewID, midiName, author, title, description, rating) VALUES (\'$p0\', \'$p1\', \'$p2\', \'$p3\', \'$p4\', \'$p5\');');
    return Response.ok('Received: $params');
  });

  router.post('/matching-midi', (Request request) async {
    String content = await request.readAsString();
    final db = await Connection.open(Endpoint(
        host: '10.95.16.3',
        database: 'reviews',
        username: 'postgres',
        password: 'VPtyUmfOBB]VRZCB',
    ));
    List<List<dynamic>> results = await db.execute('SELECT * FROM user_reviews WHERE midiName = \'$content\';');
    List<Map<String, dynamic>> jsonResponse = results.map((row) {
      return {
        'reviewID': row[0],
        'midiName': row[1],
        'author': row[2],
        'title': row[3],
        'description': row[4],
        'rating': row[5],
      };
    }).toList();

    await db.close();
    return Response.ok(jsonEncode(jsonResponse),
          headers: {'Content-Type': 'application/json'});
  });

  return router;
}

// Entry point
void main(List<String> args) async {
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(configureRoutes());

  final ip = InternetAddress.anyIPv4;
  final port = 8080;

  // Serve requests
  final server = await io.serve(handler, ip, port);
  print('Serving at http://${server.address.host}:${server.port}');
}