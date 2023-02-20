
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/search/search_bloc.dart';
import 'package:search_app/search/search_event.dart';
import 'package:search_app/search/search_state.dart';
import 'package:search_app/ui/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:substring_highlight/substring_highlight.dart';

var _controller = TextEditingController();


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
         leading: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 27,),
         title:
         const Text('Add an Admin',
            style: TextStyle(fontSize: 24.0, fontFamily: 'avenir', fontWeight: FontWeight.w600,),),
         actions: <Widget>[
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: SizedBox(
               width: 37.0,
               child: Image.asset('IconBold.png'),),

        ),],),
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
                      style: TextStyle(color: Theme.of(context).primaryColorLight, fontFamily: 'SF Pro'),
                      onChanged: (searchQuery) => context.read<SearchBloc>().add(SearchChanged(searchQuery: searchQuery)),
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 36.0, minHeight: 36.0,),
                        prefixIcon:
                            Image.asset('Search.png', width: 22.0,),
                        prefixIconConstraints: const BoxConstraints(
                          maxWidth: 30.0,
                          minWidth: 30.0
                        ),

                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),),
                        hintText: 'Search for a user...',
                        hintStyle:  TextStyle(color: Theme.of(context).highlightColor, fontFamily: 'SF Pro'),
                        suffixIcon: IconButton(
                          onPressed: _controller.clear,
                          icon: Icon(Icons.cancel, color: Theme.of(context).highlightColor, size: 20.0,),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                            maxWidth: 33.0,
                            minWidth: 33.0,
                        ),
                      ),
                    ),
                  ),
          Padding(
                     padding: const EdgeInsets.only(left: 10.0),
                     child: InkWell(onTap: _controller.clear,child: Text('Cancel', style: TextStyle(color: AppColors.blue, fontSize: 17.0, fontFamily: 'SF Pro'),),
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
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: ListView.builder(itemCount: state.searchResults.length, itemBuilder: (context, index) {
                        final searchResult = state.searchResults[index];

                        return
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0, bottom: 3.0, left: 4.0),
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
                                          width: 3.0),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        width: 69,
                                        height: 69,
                                        imageUrl: searchResult.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 55.0, bottom: 15.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 182.0,
                                          height: 20.0,
                                          child: SubstringHighlight(
                                            text: searchResult.name,
                                            term: _controller.text,
                                            textStyle: const TextStyle(color: Colors.white, fontFamily: 'avenir', fontSize: 16.0),
                                            textStyleHighlight: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir',
                                              fontWeight: FontWeight.w900,
                                          ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 11.0),
                                          child: SizedBox(
                                            width: 182.0,
                                            height: 15.0,
                                            child: Text('Member since ${searchResult.joinDate}',
                                              style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'avenir'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0, right: 2.0),
                                    child: IconButton(
                                      onPressed: () {}, icon: const Icon(Icons.more_horiz, color: Colors.white, size: 45.0,),),
                                  ),
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

