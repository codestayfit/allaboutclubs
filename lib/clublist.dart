import 'dart:convert';

import 'package:allaboutclubs/club_data/club_data.dart';
import 'package:allaboutclubs/club_item/club_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class ClubList extends StatefulWidget {
  const ClubList({Key? key}) : super(key: key);

  @override
  State<ClubList> createState() => _ClubListState();
}

class _ClubListState extends State<ClubList> {
  List clubs = [];
  Future refresh() async {
    final url = Uri.parse("https://public.allaboutapps.at/hiring/clubs.json");
    final response = await http.get(url);
    List newClubs = [];
    if (response.statusCode == 200) {
      newClubs = json.decode(utf8.decode(response.bodyBytes));
    }
    setState(() {
      clubs = newClubs.map((item) => ClubData.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list, key: UniqueKey()),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          itemCount: clubs.length,
          itemBuilder: (context, index) {
            final club = clubs[index];
            return ClubItem(clubData: club);
          },
        ),
      ),
    );
  }
}
