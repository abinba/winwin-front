import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/config/theme_data.dart';
import 'package:winwin/data/datasource/application_remote_data_source.dart';
import 'package:winwin/data/datasource/job_position_remote_data_source.dart';
import 'package:winwin/data/repository/application_repository.dart';
import 'package:winwin/data/repository/job_position_repository.dart';
import 'package:winwin/data/view_model/application_view_model.dart';
import 'package:winwin/data/view_model/job_position_view_model.dart';
import 'package:winwin/providers/candidate_provider.dart';
import 'package:winwin/providers/match_engine_provider.dart';
import 'package:winwin/routes.dart';
import 'package:winwin/services/network_info.dart';
import 'package:winwin/services/restclient.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => RestClient(env: "development")),
        Provider(create: (_) => NetworkInfoImpl()),
        Provider(
          create: (context) => JobPositionRemoteDataSourceImpl(
            client: Provider.of(context, listen: false)
          ),
        ),
        Provider(
          create: (context) => ApplicationRemoteDataSourceImpl(
            client: Provider.of(context, listen: false)
          ),
        ),
        Provider(
          create: (context) => JobPositionRepository(
            jobPositionRemoteDataSource: Provider.of(context, listen: false),
            networkInfo: Provider.of(context, listen: false),
          ),
        ),
        Provider(
          create: (context) => ApplicationRepository(
            applicationRemoteDataSource: Provider.of(context, listen: false),
            networkInfo: Provider.of(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ApplicationViewModel(
            applicationRepository: Provider.of(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => JobPositionViewModel(
            jobPositionRepository: Provider.of(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(create: (context) => SingleJobPositionViewModel
          (jobPositionRepository: Provider.of(context, listen: false)),
        ),
        ChangeNotifierProvider(
          create: (context) => MatchEngineProvider(),
        ),
        ChangeNotifierProvider(create: (context) => CandidateProvider()),
      ],
      child: MaterialApp.router(
        title: 'WinWin',
        theme: getThemeData(),
        routerConfig: router_configuration,
      ),
    );
  }
}
