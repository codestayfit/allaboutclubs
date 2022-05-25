import 'dart:convert';
import 'dart:developer';

import 'package:allaboutclubs/club_data/club_data.dart';
import 'package:allaboutclubs/club_item/club_item.dart';
import 'package:allaboutclubs/global/global.dart';
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
  final url = Uri.parse(Global.dataUrl);
  String errText = "";

  @override
  void initState() {
    super.initState();
    http.get(url).then((itemList) {
      clubs = json.decode(utf8.decode(itemList.bodyBytes));
      setState(() {
        clubs = clubs.map((item) => ClubData.fromJson(item)).toList();
        errText = "";
      });
    });
  }

  bool filterByName = true;

  Future refresh() async {
    final response = await http.get(url);
    List newClubs = [];
    if (response.statusCode == 200) {
      newClubs = json.decode(utf8.decode(response.bodyBytes));
    } else {
      errText = AppLocalizations.of(context)!.errTextFailedUrl;
    }
    setState(() {
      clubs = newClubs.map((item) => ClubData.fromJson(item)).toList();
      errText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    filterByName
        ? clubs.sort(
            (clubA, clubB) => clubA.name.compareTo(clubB.name),
          )
        : clubs.sort((clubA, clubB) => clubB.value.compareTo(clubA.value));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => filterByName = !filterByName);
            },
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
