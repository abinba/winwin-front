import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:winwin/data/model/candidate.dart';
import 'package:winwin/providers/candidate_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Candidate _candidate;

  @override
  void initState() {
    super.initState();
    final candidateProvider = Provider.of<CandidateProvider>(context, listen: false);
    if (candidateProvider.candidate != null) {
      _candidate = candidateProvider.candidate!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final candidateProvider = Provider.of<CandidateProvider>(context);
    final candidate = candidateProvider.candidate;

    if (candidate == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(child: Text('No candidate data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(context, candidate),
          _buildSectionTitle('Personal Data'),
          _buildTextField('First Name', candidate.firstName, (value) => candidate.firstName = value),
          _buildTextField('Last Name', candidate.lastName, (value) => candidate.lastName = value),
          _buildTextField('Title', candidate.title ?? '', (value) => candidate.title = value),
          _buildTextField('Availability', candidate.availability ?? '', (value) => candidate.availability = value),
          _buildTextField('Salary Start', candidate.salaryStart?.toString() ?? '', (value) => candidate.salaryStart = int.tryParse(value)),
          _buildTextField('Salary End', candidate.salaryEnd?.toString() ?? '', (value) => candidate.salaryEnd = int.tryParse(value)),
          _buildTextField('Salary Currency', candidate.salaryCurrency ?? '', (value) => candidate.salaryCurrency = value),
          _buildTextField('Location', candidate.location ?? '', (value) => candidate.location = value),
          _buildTextField('Phone Number', candidate.phoneNumber ?? '', (value) => candidate.phoneNumber = value),
          _buildTextField('Birth Date', candidate.birthDate?.toIso8601String() ?? '', (value) => candidate.birthDate = DateTime.tryParse(value)),
          _buildTextField('Profile Picture URL', candidate.profilePicture ?? '', (value) => candidate.profilePicture = value),
          _buildTextField('LinkedIn Link', candidate.linkedinLink ?? '', (value) => candidate.linkedinLink = value),
          _buildTextField('GitHub Link', candidate.githubLink ?? '', (value) => candidate.githubLink = value),
          _buildTextField('Website', candidate.website ?? '', (value) => candidate.website = value),
          _buildTextField('About Me', candidate.aboutMe ?? '', (value) => candidate.aboutMe = value),
          _buildSaveButton(context),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Candidate candidate) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: candidate.profilePicture != null
            ? NetworkImage(candidate.profilePicture!)
            : AssetImage('images/user_placeholder.png') as ImageProvider,
      ),
      title: Text('${candidate.firstName} ${candidate.lastName}', style: const TextStyle(fontSize: 24.0, color: Colors.white)),
      subtitle: Text(candidate.title ?? 'No title provided'),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          // Implement edit profile functionality
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
      child: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onChanged) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              // Implement clear functionality
            },
          ),
        ),
        controller: TextEditingController(text: initialValue),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Implement save functionality
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
        ),
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          _logout(context);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
        ),
        child: const Text('Logout'),
      ),
    );
  }

  void _logout(BuildContext context) {
    final candidateProvider = Provider.of<CandidateProvider>(context, listen: false);
    candidateProvider.clearCandidate();
    context.go('/candidate/login');
  }
}
