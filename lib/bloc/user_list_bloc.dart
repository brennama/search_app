
import 'dart:async';

 import 'package:search_app/bloc/bloc.dart';
 import 'package:search_app/repository/user_model.dart';
 import 'package:search_app/repository/user_client.dart';
 import 'package:rxdart/rxdart.dart';

 class UserListBloc implements Bloc {
   final _client = UserClient();
   final _searchQueryController = StreamController<String?>();
   Sink<String?> get searchQuery => _searchQueryController.sink;
   late Stream<List<User>?> usersStream;

   UserListBloc() {
     usersStream = _searchQueryController.stream
         .startWith(null) // 1
         .debounceTime(const Duration(milliseconds: 100)) // 2
         .switchMap(
           // 3
           (query) =>
               _client
               .fetchUsers(query)
               .asStream() // 4
               .startWith(null), // 5
         );
   }

   @override
   void dispose() {
     _searchQueryController.close();
   }
 }
