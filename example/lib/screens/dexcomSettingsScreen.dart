import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

import 'package:dexcom_flutter/dexcom_flutter.dart';

import 'package:dexcom_flutter_example/database/database.dart';
import 'package:dexcom_flutter_example/utils/utils.dart';

class DexcomSettingsScreen extends StatefulWidget {
  static const routeName = Strings.dexcomSettingsScreenRouteName;

  @override
  _DexcomSettingsScreenState createState() => _DexcomSettingsScreenState();
} // DexcomSettingsScreen

class _DexcomSettingsScreenState extends State<DexcomSettingsScreen> {
  DexcomAccount? dexcomAccount;

  @override
  void initState() {
    super.initState();
  } // initState

  @override
  Widget build(BuildContext context) {
    print("${DexcomSettingsScreen.routeName} built"); //for debugging

    return StreamProvider<DexcomAccount?>(
      initialData: null,
      catchError: (_, err) => null,
      create: (context) =>
          GetIt.instance<MyDatabase>().dexcomAccountsDao.watchDexcomAccount(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildPage(context, dexcomAccount),
        floatingActionButton:
            Consumer<DexcomAccount?>(builder: (context, dexcomAccount, child) {
          return dexcomAccount == null
              ? _buildFloatingActionButton(false)
              : _buildFloatingActionButton(true);
        } // builder
                //Text(Strings.hello),
                ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 30,
              )
            ],
          ),
          shape: CircularNotchedRectangle(),
        ),
      ),
    );
  } // build

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: TextButton(
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () => toHomepage(context),
      ),
      title: Text(Strings.dexcomSettingsScreenName),
    );
  } //buildAppBar

  Widget _buildPage(BuildContext context, DexcomAccount? dexcomAccount) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 25, bottom: 8, left: 20, right: 20),
          child: Consumer<DexcomAccount?>(
              builder: (context, dexcomAccount, child) {
            return dexcomAccount == null
                ? Text(
                    "Tap the button below to authorize ${Strings.appName} to connect to Dexcom API services.")
                : _buildDexcomAccountInformation(context, dexcomAccount);
          } // builder
              //Text(Strings.hello),
              ),
        ),
      ),
    );
  } // buildPage

  Widget _buildFloatingActionButton(bool isConnected) {
    Widget fabDisconnect = FloatingActionButton(
      elevation: 2,
      backgroundColor: Theme.of(context).errorColor,
      child: Icon(
        Icons.cancel,
      ),
      onPressed: () async {
        // send the unauthorization request
        await DexcomConnector.unauthorize();

        // get Dexcom account
        final dexcomAccount = await GetIt.instance<MyDatabase>()
            .dexcomAccountsDao
            .getDexcomAccount();

        // remove entry from db
        await GetIt.instance<MyDatabase>()
            .dexcomAccountsDao
            .deleteDexcomAccountByID(dexcomAccount.id);
      },
    );
    Widget fabConnect = FloatingActionButton(
        elevation: 2,
        child: Icon(
          Icons.account_circle,
        ),
        onPressed: () async {

          // authorize the app using dexcom_flutter
          await DexcomConnector.authorize(
              context: context,
              clientID: Strings.dexcomClientID,
              clientSecret: Strings.dexcomClientSecret,
              redirectUri: Strings.dexcomRedirectUri,
              callbackUrlScheme: Strings.dexcomCallbackScheme,
              isSandbox: true);

          // insert a placeholder user within the database
          await GetIt.instance<MyDatabase>()
              .dexcomAccountsDao
              .insertDexcomAccount(DexcomAccount(
                id: 'Test',
                displayName: 'Test name',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                deletedAt: null,
              ));
          
        });

    return isConnected ? fabDisconnect : fabConnect;
  }

  Widget _buildDexcomAccountInformation(
      BuildContext context, DexcomAccount dexcomAccount) {
    return Column(children: [
      Expanded(
        child: ListView(
          children: [
            //Name
            ListTile(
              leading: Icon(
                Icons.face,
                color: Theme.of(context).accentColor,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Name',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(dexcomAccount.displayName),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              
              title: TextButton(child: Text('Refresh token now'), onPressed: () async{
                await DexcomConnector.refreshToken(
                  context: context,
                  clientID: Strings.dexcomClientID,
                  clientSecret: Strings.dexcomClientSecret,
                  isSandbox: true);
              },)
            ),
          ],
        ),
      ),
    ]);
  } // buildFitbitAccountInformation

  void toHomepage(BuildContext context) {
    print('------ toHomepage ------');
    Navigator.pop(context);
  } //toHomepage

} //_FitbitSettingsState
