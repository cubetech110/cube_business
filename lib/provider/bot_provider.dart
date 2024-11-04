import 'package:cube_business/model/msg_model.dart';
import 'package:cube_business/services/bot_service.dart';
import 'package:flutter/material.dart';

class BotProvider extends ChangeNotifier {
  final BotService _botService = BotService();
  final TextEditingController messageController = TextEditingController();
  final String psid = 'flutter_user_${DateTime.now().millisecondsSinceEpoch}';
  
  final List<Message> _messages = [
    Message(text: 'Hi, How can help u?', isUser: false)
  ];
  
  List<Message> get messages => _messages;
  bool _sendingMessage = false;
  bool get sendingMessage => _sendingMessage;

  Future<void> sendMessage(String messageText) async {
    _messages.add(Message(text: messageText, isUser: true));
    _sendingMessage = true;
    notifyListeners();

    try {
      String? botMessage = await _botService.sendMessage(messageText, psid);
      if (botMessage != null) {
        _messages.add(Message(text: botMessage, isUser: false));
      }
    } catch (e) {
      // Handle the error in the UI
    } finally {
      _sendingMessage = false;
      notifyListeners();
    }
  }
}
