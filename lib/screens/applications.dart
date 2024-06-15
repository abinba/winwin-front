import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/data/view_model/application_view_model.dart';

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  @override
  Widget build(BuildContext context) {
    final applicationViewModel = Provider.of<ApplicationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Applications'),
      ),
      body: Column(
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
          Expanded(
            child: applicationViewModel.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: applicationViewModel.applications.length,
                    itemBuilder: (context, index) {
                      final application = applicationViewModel.applications[index];
                      return _buildJobCard(
                        application.jobPosition?.title ?? 'Unknown Position',
                        application.jobPosition?.company?.name ?? 'Unknown Company',
                        'Location unknown', // Update if location is available
                        application.status,
                        _getStatusColor(application.status),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final applicationViewModel = Provider.of<ApplicationViewModel>(context, listen: false);
      applicationViewModel.fetchCandidateApplications('03bbc451-57ab-4412-9700-9aab8c00396c'); // Fetch applications for candidate ID 123
    });
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Awaiting response':
        return Colors.red;
      case 'Not matching':
        return Colors.grey;
      case 'Invited for the interview':
        return Colors.blue;
      case 'Job offer':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
