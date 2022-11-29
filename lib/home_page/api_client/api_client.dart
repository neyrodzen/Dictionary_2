import 'dart:convert';
import 'dart:io';

class ApiClient {
  HttpClient client = HttpClient();

  Future<String?> getHttp(String word) async {
    final url = Uri.parse(
        'https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=dict.1.1.20221011T142023Z.73a7064e0ea7123e.56faa6304ab446eb368af5b916d01f1aedc825fc&lang=en-ru&text=$word');
    final request = await client.getUrl(url);
    final responce = await request.close();
    final byteTostring = await responce.transform(utf8.decoder).toList();
    final str = byteTostring.join();
    final json = jsonDecode(str) as Map<String, dynamic>;
    List<dynamic> def = json['def'] ?? <dynamic>[];
    String translate = ' ';
    if (def.isNotEmpty) {
      translate = def[0]['tr'][0]['text'];
    } 

    return translate;
  }
}