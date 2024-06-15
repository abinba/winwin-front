import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:winwin/data/model/job_position.dart';
import 'package:winwin/data/view_model/job_position_view_model.dart';

class MatcherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JobPositionViewModel(
        jobPositionRepository: Provider.of(context, listen: false),
      )..fetchRecommendedJobPositions("123"),  // TODO: add actual candidate ID
      child: Scaffold(
        body: Consumer<JobPositionViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            } else if (viewModel.jobPositions.isEmpty) {
              return const Center(child: Text('No recommendations available.'));
            } else {
              final swipeItems = viewModel.jobPositions.map((jobPosition) {
                return SwipeItem(
                  content: JobPositionCard(jobPosition),
                );
              }).toList();

              final matchEngine = MatchEngine(swipeItems: swipeItems);

              return SwipeCards(
                matchEngine: matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return swipeItems[index].content;
                },
                onStackFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No more job positions available")),
                  );
                },
                upSwipeAllowed: true,
                fillSpace: true,
              );
            }
          },
        ),
      ),
    );
  }
}

class JobPositionCard extends StatelessWidget {
  final JobPosition jobPosition;

  const JobPositionCard(this.jobPosition, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(jobPosition.title),
            subtitle: Text(jobPosition.company?.name ?? 'Unknown Company'),
            trailing: const Icon(Icons.arrow_forward),
          ),
          Wrap(
            spacing: 8.0,
            children: jobPosition.skills.map((skill) => Chip(label: Text(skill.getSkill() ?? '-'))).toList(),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.computer, color: Colors.green),
                const Text('Remote'),
                const Icon(Icons.work, color: Colors.blue),
                Text(jobPosition.workTime),
                const Icon(Icons.business_center, color: Colors.orange),
                Text(jobPosition.contractType),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(Icons.language, color: Colors.green),
                    Text(jobPosition.languages.map((lang) => lang.getLanguage() ?? '-').join(', ')),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.work, color: Colors.black),
                    Text('${jobPosition.experience}+ years'),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Slider(
              min: jobPosition.salaryStart.toDouble(),
              max: jobPosition.salaryEnd.toDouble(),
              divisions: 5,
              label: 'Salary range',
              value: ((jobPosition.salaryStart + jobPosition.salaryEnd) / 2).toDouble(),
              onChanged: (double value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(jobPosition.description),
          ),
        ],
      ),
    );
  }
}
