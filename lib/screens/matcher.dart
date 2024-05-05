import 'package:flutter/material.dart';

class MatcherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 100),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Senior Software Engineer'),
                subtitle: Text('Google'),
                trailing: Icon(Icons.arrow_forward),
              ),
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  Chip(label: Text('GoLang')),
                  Chip(label: Text('GCP')),
                  Chip(label: Text('CI/CD')),
                  // Add more chips
                ],
              ),
              // Other details, radio buttons, icons with text, slider, etc.
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    "Google's software engineers develop the next-generation technologies that change how billions of users connect, explore, and ..."),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
