import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:winwin/data/model/job_position.dart';
import 'package:winwin/data/repository/application_repository.dart';
import 'package:winwin/data/view_model/job_position_view_model.dart';
import 'package:winwin/providers/candidate_provider.dart';
import 'package:winwin/providers/match_engine_provider.dart';

class MatcherScreen extends StatefulWidget {
  @override
  _MatcherScreenState createState() => _MatcherScreenState();
}

class _MatcherScreenState extends State<MatcherScreen> {
  List<SwipeItem> _swipeItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jobPositionViewModel =
          Provider.of<JobPositionViewModel>(context, listen: false);
      final candidateProvider =
          Provider.of<CandidateProvider>(context, listen: false);
      jobPositionViewModel
          .fetchRecommendedJobPositions(
              candidateProvider.candidate!.candidateId)
          .then((_) {
        setState(() {
          _swipeItems = jobPositionViewModel.jobPositions.map((jobPosition) {
            return SwipeItem(
                content: JobPositionCard(jobPosition),
                likeAction: () {
                  final applicationRepository =
                      Provider.of<ApplicationRepository>(context,
                          listen: false);
                  if (candidateProvider.candidate?.candidateId != null) {
                    applicationRepository.apply(
                        candidateProvider.candidate!.candidateId,
                        jobPosition.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Applied to ${jobPosition.company.name}!"),
                      duration: const Duration(milliseconds: 750),
                    ));
                  } else {
                    _showLoginDialog();
                  }
                },
                nopeAction: () {
                  // Handle nope action
                },
                superlikeAction: (jobPositionId) {
                  context.go('/position?id=$jobPositionId');
                });
          }).toList();
          Provider.of<MatchEngineProvider>(context, listen: false)
              .setSwipeItems(_swipeItems);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobPositionViewModel = Provider.of<JobPositionViewModel>(context);

    if (jobPositionViewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (jobPositionViewModel.jobPositions.isEmpty) {
      return Center(child: Text('No recommendations available'));
    }

    final matchEngine = Provider.of<MatchEngineProvider>(context).matchEngine;

    if (_swipeItems.isEmpty) {
      return Center(child: Text('No recommendations available'));
    }

    return SwipeCards(
      matchEngine: matchEngine,
      itemBuilder: (BuildContext context, int index) {
        return _swipeItems[index].content;
      },
      onStackFinished: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No more job positions available")),
        );
      },
      upSwipeAllowed: true,
      fillSpace: true,
    );
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Required"),
          content: Text("You need to login or sign up to apply for this job."),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to login screen
                context.go(
                    '/candidate/login'); // Adjust the route according to your app
              },
            ),
            TextButton(
              child: Text("Sign Up"),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to sign up screen
                context.go(
                    '/candidate/signup'); // Adjust the route according to your app
              },
            ),
          ],
        );
      },
    );
  }
}

class JobPositionCard extends StatelessWidget {
  final JobPosition jobPosition;

  JobPositionCard(this.jobPosition);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 74, 68, 88),
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title:
                Text(jobPosition.title, style: TextStyle(color: Colors.white)),
            subtitle: Text(jobPosition.company?.name ?? 'Unknown Company',
                style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.arrow_forward, color: Colors.white),
          ),
          Wrap(
            spacing: 8.0,
            children: jobPosition.skills
                .map((skill) => Chip(
                    backgroundColor: Color.fromARGB(255, 79, 55, 139),
                    label: Text(skill.getSkill() ?? '-')))
                .toList(),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.computer, color: Colors.green),
                Text('Remote'),
                Icon(Icons.work, color: Colors.blue),
                Text(jobPosition.workTime),
                Icon(Icons.business_center, color: Colors.orange),
                Text(jobPosition.contractType),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(Icons.language, color: Colors.green),
                    const SizedBox(width: 10),
                    Text(jobPosition.languages
                        .map((lang) => lang.getLanguage() ?? '-')
                        .join(', ')),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.work, color: Colors.black),
                    const SizedBox(width: 10),
                    Text('${jobPosition.experience}+ years'),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Salary Range', style: TextStyle(color: Colors.white)),
                    Text(
                      '${jobPosition.salaryStart} - ${jobPosition.salaryEnd} ${jobPosition.salaryCurrency ?? ''}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                Container(
                  width: 150,
                  child: LinearProgressIndicator(
                    value: ((jobPosition.salaryEnd - jobPosition.salaryStart) /
                        jobPosition.salaryEnd),
                    backgroundColor: Colors.white24,
                    color: Colors.lightGreen,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(jobPosition.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
