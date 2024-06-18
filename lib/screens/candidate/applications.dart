import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/data/view_model/application_view_model.dart';
import 'package:winwin/providers/candidate_provider.dart';

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  List<bool> _filterChips = [true, false, false, false, false];

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final applicationViewModel =
          Provider.of<ApplicationViewModel>(context, listen: false);
      final candidateProvider =
          Provider.of<CandidateProvider>(context, listen: false);
      applicationViewModel.fetchCandidateApplications(
          candidateProvider.candidate!.candidateId, null);
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFilterChip('All', null, 0),
                  _buildFilterChip('Awaiting response', 'awaiting_response', 1),
                  _buildFilterChip('Not matching', 'not_matching', 2),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFilterChip(
                      'Invited to interview', 'invited_to_interview', 3),
                  _buildFilterChip('Offered', 'offered', 4),
                ],
              )
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

  Widget _buildFilterChip(String label, String? statusId, int index) {
    return FilterChip(
      backgroundColor: Color.fromARGB(175, 79, 55, 139),
      selectedColor: Color.fromARGB(255, 79, 55, 139),
      label: Text(label),
      selected: _filterChips[index],
      onSelected: (bool value) {
        final applicationViewModel =
            Provider.of<ApplicationViewModel>(context, listen: false);
        final candidateProvider =
            Provider.of<CandidateProvider>(context, listen: false);
        applicationViewModel.filterApplications(
            candidateProvider.candidate!.candidateId, statusId);
        setState(() {
          for (var i = 0; i < _filterChips.length; i++) {
            _filterChips[i] = false;
          }
          _filterChips[index] = true;
        });
      },
    );
  }

  Widget _buildJobCard(String position, String company, String location,
      String status, Color statusColor) {
    final statusMapping = {
      'awaiting_response': 'Awaiting response',
      'not_matching': 'Not matching',
      'invited_to_interview': 'Invited for the interview',
      'offered': 'Job offer',
    };
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
        side: BorderSide(
          color: Color.fromARGB(175, 79, 55, 139),
          width: 1.0,
        ),
      ),
      color: const Color.fromARGB(255, 29, 27, 32),
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('images/company_logo.png'),
        ),
        title: Text(position, style: TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(location, style: TextStyle(color: const Color.fromARGB(104, 255, 255, 255))),
            Text(company, style: TextStyle(color: Colors.white)),
            SizedBox(height: 5),
            Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(statusMapping[status] ?? 'Unknown status',
                  style: TextStyle(color: statusColor)),
              backgroundColor: Color.fromARGB(255, 74, 68, 88),
            ),
          ],
        ),
        trailing: Icon(Icons.chat),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'awaiting_response':
        return Color.fromARGB(255, 174, 169, 177);
      case 'not_matching':
        return Color.fromARGB(255, 255, 216, 228);
      case 'invited_to_interview':
        return Colors.lightGreen;
      case 'job_offer':
        return Colors.lightGreen;
      default:
        return Colors.black;
    }
  }
}
