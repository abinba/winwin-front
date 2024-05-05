import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder widget for ChatsScreen
    return ListView(
      children: <Widget>[
        _buildChatItem(
          companyLogo: Icons.account_circle,
          companyName: 'Meta',
          position: 'Junior Accountant',
          recentMessage: 'You: What is the next step in recruiting process?',
        ),
        _buildChatItem(
          companyLogo: Icons.account_circle,
          companyName: 'Amazon',
          position: 'Junior Accountant',
          recentMessage: 'Kyle H.: You will get our response very soon. I promise...',
        ),
        // Add more chat items here
      ],
    );
  }
}

Widget _buildChatItem(
  {required IconData companyLogo, 
  required String companyName, 
  required String position, 
  required String recentMessage}
) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(companyLogo),
        backgroundColor: Colors.grey,
      ),
      title: Text(companyName),
      subtitle: Text(position),
      trailing: IconButton(
        icon: Icon(Icons.chat),
        onPressed: () {
          // Show options menu
        },
      ),
      isThreeLine: true,
      onTap: () {
        // Navigate to chat detail screen
      },
    );
  }