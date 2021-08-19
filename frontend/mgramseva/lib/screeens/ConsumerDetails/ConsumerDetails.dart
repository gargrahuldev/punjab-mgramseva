import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mgramseva/model/connection/property.dart';
import 'package:mgramseva/model/connection/water_connection.dart';
import 'package:mgramseva/providers/common_provider.dart';
import 'package:mgramseva/providers/consumer_details_provider.dart';
import 'package:mgramseva/utils/Constants/I18KeyConstants.dart';
import 'package:mgramseva/utils/constants.dart';
import 'package:mgramseva/utils/global_variables.dart';
import 'package:mgramseva/utils/loaders.dart';
import 'package:mgramseva/utils/notifyers.dart';
import 'package:mgramseva/widgets/BaseAppBar.dart';
import 'package:mgramseva/widgets/BottonButtonBar.dart';
import 'package:mgramseva/widgets/DatePickerFieldBuilder.dart';
import 'package:mgramseva/widgets/DrawerWrapper.dart';
import 'package:mgramseva/widgets/FormWrapper.dart';
import 'package:mgramseva/widgets/HomeBack.dart';
import 'package:mgramseva/widgets/LabelText.dart';
import 'package:mgramseva/widgets/RadioButtonFieldBuilder.dart';
import 'package:mgramseva/widgets/SelectFieldBuilder.dart';
import 'package:mgramseva/widgets/SideBar.dart';
import 'package:mgramseva/widgets/SubLabel.dart';
import 'package:mgramseva/widgets/TableText.dart';
import 'package:mgramseva/widgets/TextFieldBuilder.dart';
import 'package:mgramseva/widgets/help.dart';
import 'package:provider/provider.dart';

class ConsumerDetails extends StatefulWidget {
  final String? id;
  final WaterConnection? waterconnection;

  const ConsumerDetails({Key? key, this.id, this.waterconnection})
      : super(key: key);
  State<StatefulWidget> createState() {
    return _ConsumerDetailsState();
  }
}

class _ConsumerDetailsState extends State<ConsumerDetails> {
  saveInput(context) async {
    print(context);
  }

  @override
  void initState() {
    if (widget.waterconnection != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        var commonProvider = Provider.of<CommonProvider>(
            navigatorKey.currentContext!,
            listen: false);
        Provider.of<ConsumerProvider>(context, listen: false)
          ..setModel()
          ..setWaterConnection(widget.waterconnection)
          ..getConnectionTypePropertyTypeTaxPeriod()
          ..getProperty({
            "tenantId": commonProvider.userDetails!.selectedtenant!.code,
            "propertyIds": widget.waterconnection!.propertyId
          })
          ..fetchBoundary()
          ..autoValidation = false
          ..formKey = GlobalKey<FormState>();
      });
    } else if (widget.id != null) {
    } else {
      WidgetsBinding.instance?.addPostFrameCallback((_) => afterViewBuild());
    }

    super.initState();
  }

  afterViewBuild() {
    Provider.of<ConsumerProvider>(context, listen: false)
      ..setModel()
      ..getConnectionTypePropertyTypeTaxPeriod()
      ..getConsumerDetails()
      ..fetchBoundary()
      ..autoValidation = false
      ..formKey = GlobalKey<FormState>();
  }

  Widget buildconsumerView(Property property) {
    return Column(
      children: [
        FormWrapper(Consumer<ConsumerProvider>(
            builder: (_, consumerProvider, child) => Form(
                key: consumerProvider.formKey,
                autovalidateMode: consumerProvider.autoValidation
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeBack(widget: Help()),
                      Card(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                            //Heading
                            LabelText(consumerProvider.isEdit
                                ? i18.consumer.CONSUMER_EDIT_DETAILS_LABEL
                                : i18.consumer.CONSUMER_DETAILS_LABEL),
                            //Sub Heading
                            SubLabelText(consumerProvider.isEdit
                                ? i18.consumer.CONSUMER_EDIT_DETAILS_SUB_LABEL
                                : i18.consumer.CONSUMER_DETAILS_SUB_LABEL),
                            //Conniction ID displayed based in Edit Mode
                            consumerProvider.isEdit
                                ? BuildTableText(
                                    i18.consumer.CONSUMER_CONNECTION_ID,
                                    consumerProvider
                                        .waterconnection.connectionNo
                                        .toString())
                                : Container(child: Text("")),
                            //Consumer Name Field
                            BuildTextField(
                              i18.consumer.CONSUMER_NAME,
                              property.owners!.first.consumerNameCtrl,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[A-Za-z ]"))
                              ],
                              isRequired: true,
                            ),
                            //Consumer Gender Field
                            Consumer<ConsumerProvider>(
                                builder: (_, consumerProvider, child) =>
                                    RadioButtonFieldBuilder(
                                      context,
                                      i18.common.GENDER,
                                      property.owners!.first.gender,
                                      '',
                                      '',
                                      true,
                                      Constants.GENDER,
                                      (val) =>
                                          consumerProvider.onChangeOfGender(
                                              val, property.owners!.first),
                                    )),
                            //Consumer Father or Spouse Field
                            BuildTextField(
                              i18.consumer.FATHER_SPOUSE_NAME,
                              property.owners!.first.fatherOrSpouseCtrl,
                              isRequired: true,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[A-Za-z ]"))
                              ],
                            ),
                            //Consumer Phone Number Field
                            BuildTextField(
                              i18.common.PHONE_NUMBER,
                              property.owners!.first.phoneNumberCtrl,
                              prefixText: '+91-',
                              isRequired: true,
                              textInputType: TextInputType.number,
                              maxLength: 10,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                            ),
                            //Consumer Old Connection Field
                            Consumer<ConsumerProvider>(
                                builder: (_, consumerProvider, child) =>
                                    BuildTextField(
                                      i18.consumer.OLD_CONNECTION_ID,
                                      consumerProvider
                                          .waterconnection.OldConnectionCtrl,
                                      isRequired: true,
                                    )),
                            //Consumer Door Number Field
                            BuildTextField(
                              i18.consumer.DOOR_NO,
                              property.address.doorNumberCtrl,
                            ),
                            //Consumer Street Field
                            BuildTextField(
                              i18.consumer.STREET_NUM_NAME,
                              property.address.streetNameOrNumberCtrl,
                              isRequired: true,
                            ),
                            // BuildTextField(
                            //   'Gram Panchayat Name',
                            //   name,
                            //   isRequired: true,
                            // ),

                            //Consumer Ward Field
                            Consumer<ConsumerProvider>(
                                builder: (_, consumerProvider, child) =>
                                    consumerProvider.boundaryList.length > 0
                                        ? SelectFieldBuilder(
                                            i18.consumer.WARD,
                                            property.address.localityCtrl,
                                            '',
                                            '',
                                            consumerProvider.onChangeOflocaity,
                                            consumerProvider.getBoundaryList(),
                                            true)
                                        : Text("")),
                            //Consumer Property Type Field
                            Consumer<ConsumerProvider>(
                                builder: (_, consumerProvider, child) =>
                                    SelectFieldBuilder(
                                        i18.consumer.PROPERTY_TYPE,
                                        property.propertyType,
                                        '',
                                        '',
                                        consumerProvider.onChangeOfPropertyType,
                                        consumerProvider.getPropertTypeList(),
                                        true)),
                            //Consumer Service Type Field
                            Consumer<ConsumerProvider>(
                                builder: (_, consumerProvider, child) => Column(
                                      children: [
                                        SelectFieldBuilder(
                                            i18.consumer.SERVICE_TYPE,
                                            consumerProvider
                                                .waterconnection.connectionType,
                                            '',
                                            '',
                                            consumerProvider
                                                .onChangeOfConnectionType,
                                            consumerProvider
                                                .getConnectionTypeList(),
                                            true),
                                        consumerProvider.waterconnection
                                                    .connectionType ==
                                                'Metered'
                                            ? Column(
                                                children: [
                                                  //Consumer Previous MeterReading Date Picker Field
                                                  BasicDateField(
                                                      i18.consumer
                                                          .PREV_METER_READING_DATE,
                                                      true,
                                                      consumerProvider
                                                          .waterconnection
                                                          .previousReadingDateCtrl,
                                                      lastDate: DateTime.now(),
                                                      onChangeOfDate:
                                                          consumerProvider
                                                              .onChangeOfDate),
                                                  BuildTextField(
                                                    i18.consumer.METER_NUMBER,
                                                    consumerProvider
                                                        .waterconnection
                                                        .meterIdCtrl,
                                                    isRequired: true,
                                                    textInputType:
                                                        TextInputType.number,
                                                    inputFormatter: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp("[0-9.]"))
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Consumer<
                                                    ConsumerProvider>(
                                                builder: (_, consumerProvider,
                                                        child) =>
                                                    SelectFieldBuilder(
                                                        i18.consumer
                                                            .CONSUMER_BILLING_CYCLE,
                                                        consumerProvider
                                                            .selectedcycle,
                                                        '',
                                                        '',
                                                        consumerProvider
                                                            .onChangeBillingcycle,
                                                        consumerProvider
                                                            .getBillingCycle(),
                                                        true)),
                                        BuildTextField(
                                          i18.consumer.ARREARS,
                                          consumerProvider
                                              .waterconnection.arrearsCtrl,
                                          textInputType: TextInputType.number,
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp("[0-9.]"))
                                          ],
                                          isRequired: true,
                                        )
                                      ],
                                    )),
                            SizedBox(
                              height: 20,
                            ),
                          ])),
                    ])))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<ConsumerProvider>(context, listen: false);

    return Scaffold(
        appBar: BaseAppBar(
          Text(i18.common.MGRAM_SEVA),
          AppBar(),
          <Widget>[Icon(Icons.more_vert)],
        ),
        drawer: DrawerWrapper(
          Drawer(child: SideBar()),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: StreamBuilder(
                    stream: userProvider.streamController.stream,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return buildconsumerView(snapshot.data);
                      } else if (snapshot.hasError) {
                        return Notifiers.networkErrorPage(context, () {});
                      } else {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Loaders.CircularLoader();
                          case ConnectionState.active:
                            return Loaders.CircularLoader();
                          default:
                            return Container();
                        }
                      }
                    }))),
        bottomNavigationBar: BottomButtonBar(i18.common.SUBMIT,
            () => {userProvider.validateExpensesDetails(context)}));
  }
}