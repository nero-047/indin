import 'package:flutter/material.dart';

class Jatin extends StatefulWidget {
  @override
  State<Jatin> createState() => _Chi();
}

class _Chi extends State<Jatin> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
      });
      _controller.clear(); // Clear the input after sending
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat Page"),
          backgroundColor: Color(0xFF3498DB), // Use hex color
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment
                        .centerRight, // Aligns the message to the right
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 80,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF3498DB), // Message bubble color
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        _messages[index][1],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type your message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Color(0xFF3498DB)),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
