import 'package:flutter/material.dart';
import 'package:fooderfetch/models/explore_data.dart';
import '../api/mock_fooder_fetch_service.dart';
import '../components/components.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderFetchService();

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExploreData>(
        future: mockService.getExploreData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(scrollDirection: Axis.vertical, children: [
              TodayRecipeListView(recipes: snapshot.data!.todayRecipes),
              const SizedBox(height: 16),
              FriendPostListView(friendPosts: snapshot.data!.friendPosts)
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
