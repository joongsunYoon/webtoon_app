import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoon_app/api_service/Apiservice.dart';
import 'package:webtoon_app/webtoonmodel/WebtoonDetailModel.dart';
import 'package:webtoon_app/webtoonmodel/WebtoonEpisodeModel.dart';

import '../webtoon_widget/Episode.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoons;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool favorite = false;

  Future initpref() async {
    prefs = await SharedPreferences.getInstance();
    final LikeEpisode = prefs.getStringList('LikeEpisode');
    if (LikeEpisode != null) {
      setState(() {
        if (LikeEpisode.contains(widget.id)) {
          favorite = true;
        }
      });
    } else {
      prefs.setStringList('LikeEpisode', []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoons = Apiservice.getToonById(widget.id);
    episodes = Apiservice.getToonEpisode(widget.id);
    initpref();
  }

  Like() async {
    final LikeEpisode = prefs.getStringList('LikeEpisode');
    if (LikeEpisode != null) {
      if (favorite) {
        LikeEpisode.remove(widget.id);
      } else {
        LikeEpisode.add(widget.id);
      }
    }
    await prefs.setStringList('LikeEpisode', LikeEpisode!);
    setState(() {
      favorite = !favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: Like,
            icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
        title: Text(
          widget.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(10, 15),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Image.network(
                    widget.thumb,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: webtoons,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!.about),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                        ),
                      ],
                    );
                  }
                  return const Text('...');
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: episodes,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(
                            episode: episode,
                            webtoon_id: widget.id,
                          ),
                      ],
                    );
                  }
                  return Container();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
