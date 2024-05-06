import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:winwin/main.dart';
import 'package:winwin/screens/profile.dart';

final GoRouter router_configuration = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MainScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return ProfileScreen();
          },
        ),
      ],
    ),
  ],
);