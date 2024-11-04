import 'package:cube_business/provider/bot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotScreen extends StatelessWidget {
  const BotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BotProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // Automatically adjust when the keyboard appears
        body: Consumer<BotProvider>(
          builder: (context, botProvider, child) {
            // Reverse the messages list here before passing to ListView.builder
            final messages = botProvider.messages.reversed.toList();
        
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    reverse: true, // Keep reverse to scroll to the bottom
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Align(
                          alignment: message.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Container(
                              decoration: BoxDecoration(
                                color: message.isUser
                                    ? Colors.black
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                          Text(
                                    message.isUser?'you:':'Brzah:',
                                    style: TextStyle(
                                      color: message.isUser
                                          ? Colors.white.withOpacity(0.7)
                                          : Colors.black.withOpacity(0.6),
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    message.text,
                                    style: TextStyle(
                                      color: message.isUser
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (botProvider.sendingMessage) const Text('Loading..'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(
                          controller: botProvider.messageController,
                          decoration: InputDecoration(
                            hintText: 'Write...',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 3.0, vertical: 10.0),
                          ),
                          enabled: !botProvider.sendingMessage,
                        ),
                      ),

                      const SizedBox(width: 10),

                                            Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: IconButton(
                          icon: Image.asset(
                            'assets/icon/paper-plane-top.png',
                            color: Colors.white,
                            width: 17,
                          ),
                          onPressed: botProvider.sendingMessage
                              ? null
                              : () {
                                  if (botProvider
                                      .messageController.text.isNotEmpty) {
                                    botProvider.sendMessage(botProvider
                                        .messageController.text);
                                    botProvider.messageController.clear();
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
