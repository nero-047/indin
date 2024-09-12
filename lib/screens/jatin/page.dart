import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Jatin extends StatefulWidget {
  const Jatin({super.key});

  @override
  State<Jatin> createState() => _ChatBotState();
}

class _ChatBotState extends State<Jatin> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false; // Add this line to track loading state

  Future<void> sendMessage(String messageText) async {
    setState(() {
      messages.add({'sender': 'Jessica', 'text': messageText, 'time': _getCurrentTime()});
      _isLoading = true; // Set loading state to true
    });
    
    final url = Uri.parse('http://localhost:11434/api/v1/generate'); // Update with your local IP
    final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
  'model': 'sih',  // Your model
  'prompt': messageText,  // Message input
});

    

    try {
       final response = await http.post(url, headers: headers, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final botMessage = responseData['response'] ?? 'No response from bot';
        setState(() {
          messages.add({'sender': 'NOVA', 'text': botMessage, 'time': _getCurrentTime()});
        });
      } else {
        // Handle error
        setState(() {
          messages.add({'sender': 'NOVA', 'text': 'Error: Could not get a response.', 'time': _getCurrentTime()});
        });
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
      setState(() {
        messages.add({'sender': 'NOVA', 'text': 'Exception: Could not get a response.', 'time': _getCurrentTime()});
      });
    } finally {
      setState(() {
        _isLoading = false; // Set loading state to false
      });
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: const Color(0xFF614a38),
        title: const Text(
          'Jatin (Explorer)', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFf7e1d3), Color(0xFFebd6b4)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: messages.length + (_isLoading ? 1 : 0), // Add an extra item for loading
                itemBuilder: (context, index) {
                  if (index >= messages.length) {
                    // Show loading indicator if we're at the end of messages list
                    return Center(child: CircularProgressIndicator(color: Colors.white,));
                  }
                  final message = messages[index];
                  final bool isUser = message['sender'] == 'Jessica';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                        color: isUser
                            ? const Color(0xFF614a38) // User message color
                            : const Color(0xFFebd6b4), // Bot message color
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: isUser ? const Radius.circular(12) : const Radius.circular(0),
                          bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2), // Changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'] ?? '',
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            message['time'] ?? '',
                            style: TextStyle(
                              color: isUser ? Colors.white60 : Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.attach_file, color: Color(0xFF614a38)),
                          onPressed: () {
                            // Attach file logic
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: () {
                      final messageText = _messageController.text.trim();
                      if (messageText.isNotEmpty) {
                        sendMessage(messageText);
                        _messageController.clear();
                      }
                    },
                    child: const Icon(Icons.send),
                    backgroundColor: const Color(0xFF614a38),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

