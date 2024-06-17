import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/data/view_model/application_view_model.dart';
import 'package:winwin/providers/candidate_provider.dart';

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final applicationViewModel =
          Provider.of<ApplicationViewModel>(context, listen: false);
      final candidateProvider =
          Provider.of<CandidateProvider>(context, listen: false);
      applicationViewModel.fetchCandidateApplications(candidateProvider.candidate!.candidateId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationViewModel = Provider.of<ApplicationViewModel>(context);

    return Container(
        child: Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
              ? const Center(child: CircularProgressIndicator())
              : applicationViewModel.applications.isEmpty
                  ? const Center(child: Text('No applications available'))
                  : ListView.builder(
                      itemCount: applicationViewModel.applications.length,
                      itemBuilder: (context, index) {
                        final application =
                            applicationViewModel.applications[index];
                        return _buildJobCard(
                          application.jobPosition?.title ?? 'Unknown Position',
                          application.jobPosition?.company.name ??
                              'Unknown Company',
                          application.jobPosition?.location ??
                              'Unknown Location',
                          application.status,
                          _getStatusColor(application.status),
                        );
                      },
                    ),
        ),
      ],
    ));
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

  Widget _buildJobCard(String position, String company, String location,
      String status, Color statusColor) {
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
