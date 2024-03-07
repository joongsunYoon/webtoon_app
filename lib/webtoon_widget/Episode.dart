import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../webtoonmodel/WebtoonEpisodeModel.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episode,
    required this.webtoon_id,
  }) : super(key: key);

  final WebtoonEpisodeModel episode;
  final webtoon_id;

  void goToEpisode() {
    launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoon_id&no=${episode.id}&");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goToEpisode,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.shade400,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              episode.title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
