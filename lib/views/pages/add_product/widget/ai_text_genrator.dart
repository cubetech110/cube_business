import 'package:cube_business/views/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:glowy_borders/glowy_borders.dart';

class productDescriptionAI extends StatefulWidget {


  final TextEditingController productDescriptionController;
  const productDescriptionAI({super.key, required this.productDescriptionController});


  @override
  State<productDescriptionAI> createState() => _productDescriptionAIState();
}

class _productDescriptionAIState extends State<productDescriptionAI> {
  bool _sendingMessage = false;
  final TextEditingController productDescriptionAIController =
      TextEditingController();

  Future<String> reWrite(String messageText) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyB1pBXJWogRiBdD_HD3g1ZxSuXtD22sqpY',
    );

    final content = [
      Content.text(
          '"$messageText". rewrite text by good and more good detils and rerwite by same lang, only give me the rewrite')
    ];

    final response = await model.generateContent(content);

    print('${response.text}--');

    // افتراض أن الـ AI سيرجع 'true' أو 'false' في النص المستجيب
    return response.text.toString();
  }

  Future<void> _sendMessage(String messageText) async {
    setState(() {
      _sendingMessage = true;
    });
widget.productDescriptionController.text =await reWrite(messageText);

    setState(() {
      _sendingMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  CustomTextField(
  label: 'Product Description',
  hintText: 'Enter a description for the product',
  controller: widget.productDescriptionController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the product description';
    }
    return null;
  },
  maxLines: 5,
  keyboardType: TextInputType.multiline,
  isLoading: _sendingMessage,
  suffixIcon: GestureDetector(
    
    onTap: () {
      _sendMessage(productDescriptionAIController.text);
    },
    
    child:SizedBox(
      width: 50,
      height: 50,
      child:_sendingMessage? const SizedBox.shrink(): const Icon(Icons.generating_tokens_rounded, size: 30,))), // Add your desired icon here
);

  }
}

// _sendMessage(productDescriptionAIController.text)