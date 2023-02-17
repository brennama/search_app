import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/data/search_repository.dart';
import 'package:search_app/data/search_service.dart';
import 'package:search_app/search/search_bloc.dart';
import 'package:search_app/search/search_screen.dart';
import 'package:search_app/ui/app_colors.dart';

class SearchApp extends StatelessWidget {
  const SearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => SearchRepository(searchService: SearchService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => BlocProvider(
            create: (_) =>
                SearchBloc(repo: context.read<SearchRepository>()),
            child: const SearchScreen(),
          ),
        },
      ),
    );
  }
}