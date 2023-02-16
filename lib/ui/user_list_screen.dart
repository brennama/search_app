
import 'package:search_app/bloc/user_list_bloc.dart';
import 'package:search_app/bloc/bloc_provider.dart';
import 'package:search_app/repository/user_model.dart';
import 'package:search_app/ui/user_list_item.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

var _controller = TextEditingController();

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserListBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: () {
        },),
        title:
        const Text('Add an Admin', style: TextStyle(fontSize: 24.0),),
        actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.handshake_outlined,
            color: Colors.white,
            size: 35.0,
          ),
          onPressed: () {
          },
        )
      ],),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controller,
                    textAlignVertical: TextAlignVertical.bottom,
                    cursorColor: Colors.grey,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(maxHeight: 37.0),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                      hintText: 'Search for a user...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: _controller.clear,
                        icon: const Icon(Icons.cancel, color: Colors.grey, size: 18.0,),
                      ),
                    ),
                    onChanged: bloc.searchQuery.add,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(onTap: _controller.clear,child: Text('Cancel', style: TextStyle(color: AppColors.blue, fontSize: 15.0,),),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: _buildResults(bloc),
          )
        ],
      ),
    );
  }

  Widget _buildResults(UserListBloc bloc) {
    // 1
    return StreamBuilder<List<User>?>(
      stream: bloc.usersStream,
      builder: (context, snapshot) {
        // 2
        final results = snapshot.data;
        if (results == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (results.isEmpty) {
          return const Center(child: Text('No Results'));
        }
        // 3
        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<User> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final user = results[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: UserListItem(user: user),
        );
      },
    );
  }
}
