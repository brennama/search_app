import 'package:flutter/material.dart';
import 'package:search_app/search_app.dart';

void main() => runApp(const SearchApp());


//
// import 'package:search_app/bloc/user_list_bloc.dart';
// import 'package:search_app/bloc/bloc_provider.dart';
// import 'package:search_app/ui/app_colors.dart';
// import 'package:search_app/ui/user_list_screen.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const SearchApp());
// }
//
// class SearchApp extends StatelessWidget {
//   const SearchApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider<UserListBloc>(
//         bloc: UserListBloc(),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Search App',
//           home: const UserListScreen(),

//             ),
//           ),
//         ));
//   }
// }
