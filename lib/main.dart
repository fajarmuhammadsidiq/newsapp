import 'package:flutter/material.dart';
import 'package:news/bloc/api/api_bloc.dart';
import 'package:news/bloc/sourceNews/source_news_bloc.dart';
import 'package:news/bloc/travel/travel_news_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/router/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ApiBloc>(
        create: (context) => ApiBloc(),
      ),
      BlocProvider<TravelNewsBloc>(
        create: (context) => TravelNewsBloc(),
      ),
      BlocProvider<SourceNewsBloc>(
        create: (context) => SourceNewsBloc(),
      ),
    ], child: MaterialApp(routes: Routes.getRoutes()));
  }
}
