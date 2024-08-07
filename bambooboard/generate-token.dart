import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart'
    as http; // Must include http: any package in your pubspec.yaml

Future<void> main() async {
  const clientID = "com.bamooboard.client";
  const body = "username=bob&password=password&grant_type=password";

// Note the trailing colon (:) after the clientID.
// A client identifier secret would follow this, but there is no secret, so it is the empty string.
  final String clientCredentials =
      const Base64Encoder().convert("$clientID:".codeUnits);
  print(clientCredentials);

  final http.Response response =
        await http.post(Uri.parse("http://localhost:8888/auth/token"),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Authorization": "Basic $clientCredentials"
            },
            body: body);
  print(response.body);
}