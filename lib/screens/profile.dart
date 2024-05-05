import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(context),
          _buildImportButton(),
          _buildSectionTitle('Personal Data'),
          _buildTextField('First Name', 'Rick'),
          _buildTextField('Last Name', 'Morty'),
          _buildTextField('Title', 'Senior Data Engineer'),
          _buildTextField('Email', 'rick.morty@gmail.com'),
          _buildTextField('Phone', '+48 123 234 231'),
          // _buildSectionTitle('Education'),
        ],
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return ListTile(
    contentPadding: const EdgeInsets.all(16.0),
    leading: const CircleAvatar(
      radius: 30.0,
      // Placeholder for user image, use NetworkImage for actual images
      backgroundImage: AssetImage('assets/user_placeholder.png'),
    ),
    title: const Text('Rick Morty', style: TextStyle(fontSize: 24.0)),
    subtitle: const Text('Senior Data Engineer'),
    trailing: IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        // Implement edit profile functionality
      },
    ),
  );
}

Widget _buildImportButton() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: OutlinedButton.icon(
      icon: Icon(Icons.import_contacts),
      label: Text('Import from LinkedIn'),
      onPressed: () {
        // Implement import functionality
      },
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
    child: Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
  );
}

Widget _buildTextField(String label, String placeholder) {
  return ListTile(
    title: TextField(
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            // Implement clear functionality
          },
        ),
      ),
      controller: TextEditingController(text: placeholder),
    ),
  );
}

