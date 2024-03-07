import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_app/webtoonmodel/WebtoonDetailModel.dart';
import 'package:webtoon_app/webtoonmodel/WebtoonEpisodeModel.dart';
import 'package:webtoon_app/webtoonmodel/WebtoonModel.dart';

class Apiservice {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      List<WebtoonModel> webtoonInstances = [];
      for (Map<String, dynamic> webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromjson(webtoon));
      }
      return webtoonInstances;
    }

    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromjson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getToonEpisode(String id) async {
    final url = Uri.parse('$baseUrl/$id/episodes');
    final resposne = await http.get(url);
    if (resposne.statusCode == 200) {
      List<dynamic> webtoons = jsonDecode(resposne.body);
      List<WebtoonEpisodeModel> episodes = [];
      for (Map<String, dynamic> episode in webtoons) {
        episodes.add(WebtoonEpisodeModel.fromjson(episode));
      }
      return episodes;
    }
    throw Error();
  }
}
