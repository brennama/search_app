import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/search/search_bloc.dart';
import 'package:search_app/search/search_event.dart';
import 'package:search_app/search/search_state.dart';
import 'package:search_app/ui/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

var _controller = TextEditingController();


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
         leading: Icon(Icons.arrow_back_ios, color: Colors.white,),
         title:
         const Text('Add an Admin', style: TextStyle(fontSize: 24.0),),
         actions: <Widget>[
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Icon(
               Icons.handshake_outlined,
               color: Theme.of(context).primaryColorLight,
               size: 35.0,
             ),
         ),
       ],),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      textAlignVertical: TextAlignVertical.bottom,
                      cursorColor: Theme.of(context).highlightColor,
                      style: TextStyle(color: Theme.of(context).primaryColorLight,),
                      onChanged: (searchQuery) => context.read<SearchBloc>().add(SearchChanged(searchQuery: searchQuery)),
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 33.0),
                        prefixIcon: Icon(Icons.search, color: Theme.of(context).highlightColor, size: 22.0,),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),),
                        hintText: 'Search for a user...',
                        hintStyle:  TextStyle(color: Theme.of(context).highlightColor,),
                        suffixIcon: IconButton(
                          onPressed: _controller.clear,
                          icon: Icon(Icons.cancel, color: Theme.of(context).highlightColor, size: 18.0,),
                        ),
                      ),
                    ),
                  ),
          Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: InkWell(onTap: _controller.clear,child: Text('Cancel', style: TextStyle(color: AppColors.blue, fontSize: 15.0,),),
                     ),
                   )
                ],
              ),
              Builder(builder: (_) {
                if (state is SearchLoadingState) {
                  return const CircularProgressIndicator();
                }

                if (state is SearchInitial) {
                  return const Text('');
                }

                if (state is SearchNoItems) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Sorry, that search returned zero results'),
                  );
                }

                if (state is SearchError) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('An error has occurred, please try again'),
                  );
                }

                if (state is SearchLoaded) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListView.builder(itemCount: state.searchResults.length, itemBuilder: (context, index) {
                        final searchResult = state.searchResults[index];

                        return
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Card(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: searchResult.color,
                                          width: 3.5),
                                      borderRadius: BorderRadius.circular(50),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.white54,
                                      //     spreadRadius: 0.1,
                                      //   ),
                                      // ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        width: 65,
                                        height: 65,
                                        imageUrl: searchResult.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 61.0, bottom: 15.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 160.0,
                                          height: 20.0,
                                          child: Text(
                                            searchResult.name,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            width: 160.0,
                                            height: 20.0,
                                            child: Text('Member since ${searchResult.joinDate}',
                                              style: const TextStyle(color: Colors.white, fontSize: 12.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {}, icon: const Icon(Icons.more_horiz, color: Colors.white, size: 40.0,),),
                                ],
                              ),


                            ),
                          );
                      }),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },)
            ],
          ),
        ),
      );
    });
  }
}

