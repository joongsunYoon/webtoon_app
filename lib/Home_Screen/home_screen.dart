import 'package:flutter/material.dart';
import 'package:webtoon_app/api_service/Apiservice.dart';
import 'package:webtoon_app/webtoon_widget/Webtoon.dart';
import 'package:webtoon_app/webtoonmodel/WebtoonModel.dart';

class home_screen extends StatelessWidget {
  home_screen({super.key});

  Future<List<WebtoonModel>> webtoons = Apiservice.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
        title: const Center(
          child: Text(
            'Today\'s toon',
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return makeList(snapshot);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 20,
        );
      },
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
    );
  }
}
