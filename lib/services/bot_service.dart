import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cube_business/core/secret/apis_key.dart';

class BotService {
  Future<String?> sendMessage(String messageText, String psid) async {
    String apiUrl = 'https://channel-connector.orimon.ai/orimon/v1/conversation/api/message';
    Map<String, String> headers = {
      'authorization': 'apiKey $apiKey',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      "type": "message",
      "info": {
        "psid": psid,
        "sender": "user",
        "tenantId": tenantId,
        "platformName": "web"
      },
      "message": {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "type": "text",
        "payload": {"text": messageText}
      }
    };

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(requestBody));
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        return responseData['data']['messages'][0]['payload']['text'];
      } else {
        return null; // Handle API error
      }
    } catch (e) {
      // Handle network error
      return null;
    }
  }
}
