import "package:flutter/material.dart";

class ForumChatButton extends StatelessWidget {
  const ForumChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: 24,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => const ForumChatScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                )),
                child: child,
              );
            },
          ));
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.forum,
            size: 26,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class ForumChatScreen extends StatelessWidget {
  const ForumChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.black;
    final accentColor = const Color(0xFFFFC700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: themeColor),
        elevation: 1,
        title: const Text(
          'Forum Diskusi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMessage(
                  sender: "User A",
                  message: "Ada yang sudah nonton film ini?",
                  isMe: false,
                ),
                const SizedBox(height: 12),
                _buildMessage(
                  sender: "Saya",
                  message: "Sudah! Bagus banget plot twist-nya.",
                  isMe: true,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Ketik pesan...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: accentColor,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage({
    required String sender,
    required String message,
    required bool isMe,
  }) {
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = isMe ? const Color(0xFFFFC700) : Colors.grey.shade200;
    final textColor = isMe ? Colors.white : Colors.black87;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          sender,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
