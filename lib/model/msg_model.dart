class Message {
  final String text;
  final bool isUser; // true if message sent by user, false if received from bot

  Message({required this.text, required this.isUser});
}