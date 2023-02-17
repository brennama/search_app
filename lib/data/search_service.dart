import 'package:search_app/models/search_response.dart';
import 'package:search_app/models/search_result.dart';
import 'package:search_app/ui/app_colors.dart';

class SearchService {

  // Mocked API data set.
  List<SearchResult> get searchResults =>  [
    SearchResult(title: 'Joanne Robinson', message: '11/25/2019', imageUrl:
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyrjEuVeGE0ljpxJyXpqWxd6N1vOpS9aTG7A&usqp=CAU', color: AppColors.green),
    SearchResult(title: 'Joe Mike', message: '11/18/2019', imageUrl:
    'https://www.shutterstock.com/image-photo/portrait-happy-mid-adult-man-260nw-1812937819.jpg', color: AppColors.green),
    SearchResult(title: 'John Jameson', message: '09/19/2019', imageUrl:
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', color: AppColors.red),
    SearchResult(title: 'John Johnson', message: '10/30/2022',  imageUrl:
    'https://www.shutterstock.com/image-photo/portrait-young-handsome-asian-adult-260nw-2204416587.jpg', color: AppColors.green),
    SearchResult(title: 'Joseph Smith', message: '01/15/2018', imageUrl: 'https://mochamanstyle.com/wp-content/uploads/2015/01/black-man-scarf.jpg', color: AppColors.green
   ),
    SearchResult(title: 'Alice Brown', message: '2/16/2020', imageUrl: 'https://t3.ftcdn.net/jpg/03/58/93/04/360_F_358930412_rodvr4vvY4LG0bUG8MKC3wwCZhWGozcW.jpg', color: AppColors.green),
  ];








  Future<SearchResponse> fetchSearchItems({required String searchQuery}) async {
    // Make both lower cased so it's not case-sensitive to search items.
    final matchedItems = searchResults.where((result) => result.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Future.value(SearchResponse(success: true, searchResults: matchedItems));
  }
}