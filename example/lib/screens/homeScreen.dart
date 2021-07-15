import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:dexcom_flutter_example/database/database.dart';

import 'package:dexcom_flutter_example/utils/utils.dart';

import 'package:dexcom_flutter/dexcom_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = Strings.homeScreenRouteName;

  @override
  _HomeScreenState createState() => _HomeScreenState();
} // HomeScreen

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("${HomeScreen.routeName} built"); //for debugging

    return StreamProvider<DexcomAccount?>(
      initialData: null,
      create: (context) =>
          GetIt.instance<MyDatabase>().dexcomAccountsDao.watchDexcomAccount(),
      catchError: (_, err) => null,
      child: Scaffold(
        appBar: buildAppBar(context),
        drawer:
            Consumer<DexcomAccount?>(builder: (context, dexcomAccount, child) {
          return buildHomeDrawer(
              context,
              dexcomAccount == null
                  ? 'No user'
                  : '${dexcomAccount.displayName}');
        } // builder
                ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<DexcomAccount?>(
                    builder: (context, dexcomAccount, child) {
                  return dexcomAccount == null
                      ? Text(
                          'No user authorized. To start open the Drawer and tap "Dexcom Account"')
                      : Column(
                          children: [
                            ElevatedButton(
                                child: Text('Fetch last 3 days statistics'),
                                onPressed: () async {
                                  // Set the target range list
                                  List<TargetRange> targetRanges = [
                                    TargetRange(
                                      name: "day",
                                      startTime:
                                          DateTime.parse("2021-01-01 07:00:00"),
                                      endTime:
                                          DateTime.parse("2021-01-01 20:00:00"),
                                      egvRanges: [
                                        EGVRange(
                                          egvRangeName: EGVRangeName.URGENT_LOW,
                                          bound: 55,
                                        ),
                                        EGVRange(
                                          egvRangeName: EGVRangeName.LOW,
                                          bound: 70,
                                        ),
                                        EGVRange(
                                          egvRangeName: EGVRangeName.HIGH,
                                          bound: 180,
                                        ),
                                      ],
                                    ),
                                    TargetRange(
                                      name: "night",
                                      startTime:
                                          DateTime.parse("2021-01-01 20:00:00"),
                                      endTime:
                                          DateTime.parse("2021-01-01 07:00:00"),
                                      egvRanges: [
                                        EGVRange(
                                          egvRangeName: EGVRangeName.URGENT_LOW,
                                          bound: 55,
                                        ),
                                        EGVRange(
                                          egvRangeName: EGVRangeName.LOW,
                                          bound: 80,
                                        ),
                                        EGVRange(
                                          egvRangeName: EGVRangeName.HIGH,
                                          bound: 200,
                                        ),
                                      ],
                                    ),
                                  ];
                                  // Create the statistics request body
                                  StatisticsRequest statisticsRequest =
                                      StatisticsRequest(
                                          targetRanges: targetRanges);

                                  // Instantiate the proper data manager
                                  DexcomStatisticsDataManager
                                      dexcomStatisticsDataManager =
                                      DexcomStatisticsDataManager(
                                    clientID: Strings.dexcomClientID,
                                    clientSecret: Strings.dexcomClientSecret,
                                  );

                                  //Instantiate the proper Dexcom url
                                  final DexcomStatisticsAPIURL
                                      dexcomStatisticsAPIUrl =
                                      DexcomStatisticsAPIURL.range(
                                    startDate: DateTime.now()
                                        .subtract(Duration(days: 3)),
                                    endDate: DateTime.now(),
                                    statisticsRequest: statisticsRequest,
                                    isSandbox: true,
                                  );
                                  // Fetch data
                                  final List<DexcomStatisticsData>
                                      statisticsData =
                                      await dexcomStatisticsDataManager
                                          .fetch(dexcomStatisticsAPIUrl);

                                  // Use them as you want
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Last three day statistics are: ${statisticsData[0]}.'),
                                    duration: Duration(seconds: 10),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }),
                            ElevatedButton(
                                child: Text('Fetch yesterday EGV data'),
                                onPressed: () async {
                                  // Instantiate a proper DexcomManager
                                  DexcomEGVDataManager dexcomEGVDataManager =
                                      DexcomEGVDataManager(
                                    clientID: Strings.dexcomClientID,
                                    clientSecret: Strings.dexcomClientSecret,
                                  );

                                  //Instantiate a Dexcom url
                                  final DexcomEGVAPIURL dexcomEGVDataUrl =
                                      DexcomEGVAPIURL.range(
                                    startDate: DateTime.now()
                                        .subtract(Duration(days: 1)),
                                    endDate: DateTime.now(),
                                    isSandbox: true,
                                  );
                                  // Fetch data
                                  final List<DexcomEGVData> egvData =
                                      await dexcomEGVDataManager
                                          .fetch(dexcomEGVDataUrl);

                                  // Use them as you want
                                  final snackBar = SnackBar(
                                    content:
                                        Text('Last EGV is: ${egvData[0]}.'),
                                    duration: Duration(seconds: 10),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }),
                          ],
                        );
                } // builder
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  } // build

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 15,
      title: Text(Strings.homeScreenName),
      leading: Builder(
        builder: (context) => IconButton(
          icon: new Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  } //buildAppBar

  Widget buildHomeDrawer(BuildContext context, String title) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: DrawerHeader(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings_remote,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Dexcom Account'),
            onTap: () {
              Navigator.pop(context); //First pop the drawer
              toDexcomSettings(context);
            },
          ),
        ],
      ),
    );
  } //buildHomeDrawer

  void toDexcomSettings(BuildContext context) {
    print('------ toDexcomSettings ------');
    Navigator.of(context).pushNamed(Strings.dexcomSettingsScreenRouteName);
  } // toDexcomSettings

} // _HomeScreenState
