import 'package:flutter/material.dart';

class MatcherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
    Expanded(
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const ListTile(
              title: Text('Senior Software Engineer'),
              subtitle: Text('Google'),
              trailing: Icon(Icons.arrow_forward),
            ),
            const Wrap(
              spacing: 8.0,
              children: <Widget>[
                Chip(label: Text('GoLang')),
                Chip(label: Text('GCP')),
                Chip(label: Text('CI/CD')),
              ],
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.computer, color: Colors.green),
                  Text('Remote'),
                  Icon(Icons.work, color: Colors.blue),
                  Text('Full-Time'),
                  Icon(Icons.business_center, color: Colors.orange),
                  Text('B2B'),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.language, color: Colors.green), 
                      Text('English'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work, color: Colors.black),
                      Text('4+ years'),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Slider(
                min: 20000,
                max: 30000,
                divisions: 5,
                label: 'Salary range',
                value: 22500, // Example value
                secondaryTrackValue: 24000,
                onChanged: (double value) {},
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  "Google's software engineers develop the next-generation technologies that change how billions of users connect, explore, and ..."),
            ),
          ],
        ),
      ),
    ),
          ],
        );
  }
}
