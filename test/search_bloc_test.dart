import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search_app/data/search_repository.dart';
import 'package:search_app/models/search_response.dart';
import 'package:search_app/models/search_result.dart';
import 'package:search_app/search/search_bloc.dart';
import 'package:search_app/search/search_event.dart';
import 'package:search_app/search/search_state.dart';

import 'mocks.dart';

void main() {
  late SearchRepository repository;

  setUp(() {
    repository = SearchRepositoryMock();
  });

  test('Initial State', () {
    final searchBloc = SearchBloc(repo: repository);

    expect(searchBloc.state, SearchInitial());
  });

  blocTest<SearchBloc, SearchState>(
    'Loading State',
    setUp: () {
      // This creates a state where the repo never returns data, so we should see a loading state.
      when(() => repository.fetchSearchResults(
          searchQuery: any(named: 'searchQuery')))
          .thenAnswer((_) => Future.any([]));
    },
    act: (bloc) async {
      bloc.add(SearchChanged(searchQuery: 'Jane Doe'));

      await pumpEventQueue();
    },
    build: () => SearchBloc(repo: repository, searchWaitTime: 0),
    expect: () => [
      isA<SearchLoadingState>(),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'Should fire initial state when query is empty',
    setUp: () {
      when(() => repository.fetchSearchResults(
          searchQuery: any(named: 'searchQuery'))).thenAnswer(
            (_) => Future.value(
          const SearchResponse(
            success: true,
            searchResults: [
              SearchResult(
                name: 'Jane Doe',
                joinDate: '01/01/2021',
                imageUrl: 'image url',
              )
            ],
          ),
        ),
      );
    },
    act: (bloc) async {
      bloc.add(SearchChanged(searchQuery: 'Jane Doe'));
      await pumpEventQueue();

      bloc.add(SearchChanged(searchQuery: ''));
    },
    build: () => SearchBloc(repo: repository, searchWaitTime: 0),
    expect: () => [
      isA<SearchLoadingState>(),
      isA<SearchLoaded>().having((state) => state.searchResults.first.name,
          'It returns names correctly', 'Jane Doe'),
      isA<SearchInitial>(),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'Should fire error state whenever call fails',
    setUp: () {
      when(() => repository.fetchSearchResults(
          searchQuery: any(named: 'searchQuery'))).thenAnswer(
            (_) => Future.value(
          const SearchResponse(
            success: false,
            searchResults: [],
          ),
        ),
      );
    },
    act: (bloc) async {
      bloc.add(SearchChanged(searchQuery: 'Jane Doe'));
      await pumpEventQueue();
    },
    build: () => SearchBloc(repo: repository, searchWaitTime: 0),
    expect: () => [
      isA<SearchLoadingState>(),
      isA<SearchError>(),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'Should fire loaded state when proper data is returned',
    setUp: () {
      when(() => repository.fetchSearchResults(
          searchQuery: any(named: 'searchQuery'))).thenAnswer(
            (_) => Future.value(
          const SearchResponse(
            success: true,
            searchResults: [
              SearchResult(
                name: 'Jane Doe',
                joinDate: '01/01/2021',
                imageUrl: 'image url',
              )
            ],
          ),
        ),
      );
    },
    act: (bloc) async {
      bloc.add(SearchChanged(searchQuery: 'Jane Doe'));
      await pumpEventQueue();
    },
    build: () => SearchBloc(repo: repository, searchWaitTime: 0),
    expect: () => [
      isA<SearchLoadingState>(),
      isA<SearchLoaded>().having((state) => state.searchResults.first.name,
          'It returns names correctly', 'Jane Doe'),
    ],
  );
}