import 'package:flutter/material.dart';

class ApplicationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip('All', true),
                _buildFilterChip('In Process', false),
                _buildFilterChip('Closed', false),
              ],
            ),
          ),
          _buildJobCard('DevOps Specialist', 'Google', 'Wroclaw, Poland', 'Awaiting response', Colors.red),
          _buildJobCard('Senior Software Engineer', 'Apple', 'Wroclaw, Poland', 'Not matching', Colors.grey),
          _buildJobCard('Junior Accountant', 'Meta', 'Remote', 'Invited for the interview', Colors.blue),
          _buildJobCard('Junior Accountant', 'Amazon', 'Remote', 'Job offer', Colors.green),
        ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool value) {
        // Handle chip selection
      },
    );
  }

  Widget _buildJobCard(String position, String company, String location, String status, Color statusColor) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('images/company_logo.png'),
        ),
        title: Text(position),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(company),
            Text(location),
            Chip(
              label: Text(status),
              backgroundColor: statusColor,
            ),
          ],
        ),
        trailing: Icon(Icons.chat),
      ),
    );
  }
}