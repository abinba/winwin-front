import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/data/model/job_position.dart';
import 'package:winwin/data/view_model/job_position_view_model.dart';
import 'package:winwin/providers/match_engine_provider.dart';

class JobPositionDetailPage extends StatefulWidget {
  final String jobPositionId;

  JobPositionDetailPage({required this.jobPositionId});

  @override
  _JobPositionDetailPageState createState() => _JobPositionDetailPageState();
}

class _JobPositionDetailPageState extends State<JobPositionDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SingleJobPositionViewModel>(context, listen: false)
          .fetchJobPosition(widget.jobPositionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SingleJobPositionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Job Description - More'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.errorMessage != null
              ? Center(child: Text(viewModel.errorMessage!))
              : viewModel.jobPosition != null
                  ? _buildJobPositionDetail(context, viewModel.jobPosition!)
                  : Center(child: Text('No data available')),
    );
  }

  Widget _buildJobPositionDetail(
      BuildContext context, JobPosition jobPosition) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage("images/company_logo.png"),
          ),
          title: Text(
            jobPosition.title,
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          subtitle: Text(jobPosition.company?.name ?? 'Unknown Company',
              style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.arrow_forward),
        ),
        Wrap(
          spacing: 8.0,
          children: jobPosition.skills
              .map((skill) => Chip(
                  backgroundColor: Color.fromARGB(255, 79, 55, 139),
                  label: Text(skill.getSkill() ?? '-')))
              .toList(),
        ),
        Divider(color: Colors.white24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.work, color: Colors.blue),
              Text(jobPosition.workTime, style: TextStyle(color: Colors.white)),
              Icon(Icons.business_center, color: Colors.orange),
              Text(jobPosition.contractType,
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Divider(color: Colors.white24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.computer, color: Colors.green),
              Text('Remote', style: TextStyle(color: Colors.white)),
              Icon(Icons.language, color: Colors.green),
              Text(jobPosition.languages
                  .map((lang) => lang.getLanguage() ?? '-')
                  .join(', ')),
              Icon(Icons.work, color: Colors.black),
              Text('${jobPosition.experience}+ years',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Divider(color: Colors.white24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Salary Range', style: TextStyle(color: Colors.white)),
              Text(
                '${jobPosition.salaryStart} - ${jobPosition.salaryEnd} ${jobPosition.salaryCurrency ?? ''}',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: ((jobPosition.salaryEnd - jobPosition.salaryStart) /
                jobPosition.salaryEnd),
            backgroundColor: Colors.white24,
            color: Colors.lightGreen,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'About Job',
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          jobPosition.description,
          style: TextStyle(color: Colors.white70),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                final matchEngine =
                    Provider.of<MatchEngineProvider>(context).matchEngine;
                matchEngine.currentItem?.like();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                minimumSize: Size(100, 50),
              ),
              child: Text('Apply', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                final matchEngine =
                    Provider.of<MatchEngineProvider>(context).matchEngine;
                matchEngine.currentItem?.nope();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                minimumSize: Size(100, 50),
              ),
              child: Text(
                'Pass',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
