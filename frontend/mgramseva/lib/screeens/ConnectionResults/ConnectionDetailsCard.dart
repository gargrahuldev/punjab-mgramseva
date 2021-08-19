import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mgramseva/model/connection/water_connections.dart';
import 'package:mgramseva/routers/Routers.dart';
import 'package:mgramseva/utils/Constants/I18KeyConstants.dart';
import 'package:mgramseva/utils/Locilization/application_localizations.dart';
import 'package:mgramseva/widgets/LabelText.dart';
import 'package:mgramseva/widgets/ShortButton.dart';
import 'package:mgramseva/widgets/SubLabel.dart';

class SearchConnectionDetailCard extends StatelessWidget {
  final WaterConnections waterconnections;
  final Map arguments;
  SearchConnectionDetailCard(this.waterconnections, this.arguments);
  _getDetailtext(label, value, context, constraints) {
    return constraints.maxWidth > 720
        ? (Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    ApplicationLocalizations.of(context).translate(label),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  padding: EdgeInsets.only(top: 18, bottom: 3),
                  child: Text(
                      value == null
                          ? ApplicationLocalizations.of(context).translate("NA")
                          : ApplicationLocalizations.of(context)
                              .translate(value),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)))
            ],
          ))
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    ApplicationLocalizations.of(context).translate(label),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  )),
              Text(
                  value == null
                      ? ApplicationLocalizations.of(context).translate("NA")
                      : ApplicationLocalizations.of(context).translate(value),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    print(arguments['Mode']);
    return LayoutBuilder(builder: (context, constraints) {
      return Column(children: [
        LabelText(waterconnections.waterConnection!.length.toString() != null
            ? waterconnections.waterConnection!.length.toString() +
                " " +
                ApplicationLocalizations.of(context)
                    .translate(i18.searchWaterConnection.CONNECTION_FOUND)
            : "0" +
                ApplicationLocalizations.of(context)
                    .translate(i18.searchWaterConnection.CONNECTION_FOUND)),
        SubLabelText(ApplicationLocalizations.of(context)
                .translate(i18.searchWaterConnection.CONNECTION_CRITERIA) +
            " " +
            arguments.keys.first.toString() +
            " as " +
            arguments.values.first.toString()),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: waterconnections.waterConnection!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getDetailtext(
                                i18.searchWaterConnection.NEW_CONNECTION_ID,
                                waterconnections
                                    .waterConnection![index].connectionNo,
                                context,
                                constraints),
                            _getDetailtext(
                                i18.searchWaterConnection.OLD_CONNECTION_ID,
                                waterconnections
                                    .waterConnection![index].oldConnectionNo,
                                context,
                                constraints),
                            _getDetailtext(
                                i18.searchWaterConnection.CONSUMER_NAME,
                                waterconnections.waterConnection![index]
                                            .connectionHolders !=
                                        null
                                    ? waterconnections.waterConnection![index]
                                        .connectionHolders!.first.name
                                    : ApplicationLocalizations.of(context)
                                        .translate("NA"),
                                context,
                                constraints),
                            _getDetailtext(
                                i18.searchWaterConnection.OWNER_MOB_NUM,
                                waterconnections.waterConnection![index]
                                            .connectionHolders !=
                                        null
                                    ? waterconnections.waterConnection![index]
                                        .connectionHolders!.first.mobileNumber
                                    : ApplicationLocalizations.of(context)
                                        .translate("NA"),
                                context,
                                constraints),
                            _getDetailtext(
                                i18.searchWaterConnection.HOUSE_ADDRESS,
                                waterconnections.waterConnection![index]
                                    .additionalDetails!.locality,
                                context,
                                constraints),
                            SizedBox(
                              height: 20,
                            ),
                            ShortButton(
                                arguments['Mode'] == 'collect'
                                    ? i18.searchWaterConnection
                                        .HOUSE_DETAILS_VIEW
                                    : i18.searchWaterConnection
                                        .HOUSE_DETAILS_EDIT,
                                () => Navigator.pushNamed(
                                    context,
                                    (arguments['Mode'] == 'collect'
                                        ? Routes.HOUSEHOLD_DETAILS
                                        : Routes.CONSUMER_UPDATE),
                                    arguments: waterconnections
                                        .waterConnection![index])),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )));
              }),
        )
      ]);
    });
  }
}