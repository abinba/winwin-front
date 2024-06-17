import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:winwin/providers/candidate_provider.dart';
import 'package:winwin/screens/candidate/login.dart';
import 'package:winwin/screens/candidate/main_screen.dart';
import 'package:winwin/screens/candidate/profile.dart';
import 'package:winwin/screens/candidate/signup.dart';
import 'package:winwin/screens/welcome_page.dart';

final GoRouter router_configuration = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        final candidateProvider = Provider.of<CandidateProvider>(context, listen: false);
        return candidateProvider.candidate != null ? MainScreen() : WelcomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return ProfileScreen();
          },
        ),
        GoRoute(
          path: 'candidate/home', 
          builder: (BuildContext context, GoRouterState state) {
            return MainScreen();
          },
        ),
        GoRoute(
          path: 'candidate/login',
          builder: (BuildContext context, GoRouterState state) {
            return CandidateLoginPage();
          },
        ),
        GoRoute(
          path: 'candidate/signup',
          builder: (BuildContext context, GoRouterState state) {
            return CandidateSignupPage();
          },
        ),
      ],
    ),
  ],
);