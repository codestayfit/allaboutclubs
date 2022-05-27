import 'package:allaboutclubs/club_data/club_data.dart';
import 'package:allaboutclubs/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

TextStyle normal = const TextStyle(
  color: Colors.black,
  fontSize: 17,
  fontWeight: FontWeight.normal,
);
TextStyle bold = const TextStyle(
  color: Colors.black,
  fontSize: 17,
  fontWeight: FontWeight.bold,
);
TextStyle italic = const TextStyle(
  color: Colors.black,
  fontSize: 17,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
);

class ClubDetail extends StatefulWidget {
  final ClubData clubData;
  const ClubDetail({Key? key, required this.clubData}) : super(key: key);

  @override
  State<ClubDetail> createState() => _ClubDetailState();
}

class _ClubDetailState extends State<ClubDetail> {
  final url = Uri.parse(Global.dataUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clubData.name),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey[800],
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.network(widget.clubData.image),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      widget.clubData.country,
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.theClub + " ",
                  style: normal,
                  children: [
                    TextSpan(
                      text: widget.clubData.name + " ",
                      style: bold,
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.from + " ",
                      style: normal,
                    ),
                    TextSpan(
                      text: widget.clubData.country + " ",
                      style: normal,
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.hasAValueOf + " ",
                      style: normal,
                    ),
                    TextSpan(
                      text: widget.clubData.value.toString() + " ",
                      style: normal,
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.million +
                          " " +
                          AppLocalizations.of(context)!.euro +
                          ".\n\n",
                      style: normal,
                    ),
                    TextSpan(
                      text: widget.clubData.name +
                          " " +
                          AppLocalizations.of(context)!.hasManagedToAchieve +
                          " " +
                          widget.clubData.europeanTitles.toString() +
                          " " +
                          AppLocalizations.of(context)!
                              .victoriesAtEuropeanLevelSoFar +
                          ".",
                      style: italic,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
