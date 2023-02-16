
import 'package:search_app/repository/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    required this.user,
    Key? key,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
          Container(
               decoration: BoxDecoration(
                 border: Border.all(color: AppColors.green, width: 3.0),
                 borderRadius: BorderRadius.circular(50),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.white54,
                    // blurRadius: 5.0,
                    // offset: Offset(0, 10),
                     spreadRadius: 0.1,
                   ),
                 ],
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(50),
                 child: CachedNetworkImage(
                   width: 65,
                   height: 65,
                   imageUrl: user.imageUrl,
                 ),
               ),

             ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 61.0, bottom: 15.0),
              child: Column(
                children: [
      SizedBox(
        width: 170.0,
                    height: 20.0,
                    child: Text(
                      user.name ?? '',
                       style: TextStyle(color: Colors.white),
                     ),
                   ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: 170.0,
                  height: 20.0,
                  child: Text(
                              user.joinDate,
                               style: TextStyle(color: Colors.white),
                            ),
                ),
              ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {}, icon: Icon(Icons.more_horiz, color: Colors.white, size: 40.0,),),
          ],
        ),



      ),
    );
  }


 }
