import 'package:flutter_mockito_unit_test/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// class MockClient extends Mock implements http.Client {}

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  MockClient client;
  late AlbumDataSource dataSource;
  setUpAll(() {
    client = MockClient();
    dataSource = AlbumDataSource(client);
  });
  test('add album', () async {
    final client = MockClient();

    // Use Mockito to return an unsuccessful response when it calls the
    // provided http.Client.
    when(client.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      body: {"title": 'foo', "body": 'bar', "userId": 1},
      headers: {
        'Content-Type': 'application/json',
      },
    )).thenAnswer((_) async => http.Response(
        '{"userId": 1, "id": 101, "title": "mock", "body":"bar"}', 200));
    // Album album = await ;
    // print(album);
    Album res = await dataSource.addAlbum();
    print(res);
    // expect(addAlbum(client), isA<Album>());
  });

  // group('fetchAlbum', () {
  //   test('returns an Album if the http call completes successfully', () async {
  //     final client = MockClient();

  //     // Use Mockito to return a successful response when it calls the
  //     // provided http.Client.
  //     when(client
  //             .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
  //         .thenAnswer((_) async =>
  //             http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

  //     expect(await fetchAlbum(client), isA<Album>());
  //   });

  //   test('throws an exception if the http call completes with an error',
  //       () async {
  //     final client = MockClient();

  //     // Use Mockito to return an unsuccessful response when it calls the
  //     // provided http.Client.
  //     when(client
  //             .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
  //         .thenAnswer((_) async => http.Response('Not Found', 404));
  //     Album album = await fetchAlbum(client);
  //     print(album);
  //     expect(album, throwsException);
  //   });

  // });
}
