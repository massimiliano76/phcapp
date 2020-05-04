import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/repositories/phc_dao_client.dart';
import 'package:phcapp/src/repositories/repositories.dart';
import 'package:phcapp/src/ui/history.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'callcard_tabs.dart';

enum WhatTodo { logout, history, newCallcard }

class ListCallcards extends StatefulWidget {
  PhcDao phcDao;

  ListCallcards({this.phcDao});

  _ListCallcards createState() => _ListCallcards();
}

class _ListCallcards extends State<ListCallcards> {
  Completer<void> _refreshCompleter;
  PhcBloc phcBloc;
  LoginBloc loginBloc;
  AuthBloc authBloc;

  final PhcRepository phcRepository =
      PhcRepository(phcApiClient: PhcApiClient(httpClient: http.Client()));

  final PhcDaoClient phcDaoClient = new PhcDaoClient(phcDao: new PhcDao());
  // PhcDao phcDao;

  @override
  void didChangeDependencies() {
    phcBloc = BlocProvider.of<PhcBloc>(context);
    loginBloc = BlocProvider.of<LoginBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return
        // MultiBlocProvider(
        //     // BlocProvider(
        //     providers: [
        //       //),
        //       BlocProvider(
        //         create: (context) => CallInfoBloc(),
        //       ),
        //       BlocProvider(
        //           create: (context) => TeamBloc(phcDao: phcDaoClient.phcDao)),
        //       BlocProvider(
        //           create: (context) => StaffBloc(
        //               phcRepository: phcRepository, phcDao: phcDaoClient.phcDao)),
        //       BlocProvider(
        //           create: (context) => TimeBloc(phcDao: phcDaoClient.phcDao)),
        //       BlocProvider(
        //           create: (context) => SceneBloc(phcDao: phcDaoClient.phcDao)),

        //       BlocProvider(
        //           create: (context) => PatientBloc(phcDao: phcDaoClient.phcDao)),

        //       BlocProvider(
        //           create: (context) => VitalBloc(phcDao: phcDaoClient.phcDao)),

        //       BlocProvider(
        //           create: (context) => AuthBloc(phcRepository: phcRepository)),

        //       // BlocProvider<AuthBloc>(create: (context) {
        //       //   return AuthBloc(phcRepository: phcRepository)..add(AppStarted());
        //       // }),
        //     ],
        // child:
        Scaffold(
      appBar: AppBar(
        leading: TopOtherMenu(),
        title: Text("Call Cards"),
        actions: <Widget>[
          Padding(padding: EdgeInsets.only(right: 10), child: TopUserMenu()),
        ],
      ),
      body: Center(
        child: BlocConsumer<PhcBloc, PhcState>(
          listener: (context, state) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          },
          builder: (context, state) {
            if (state is PhcEmpty) {
              phcBloc.add(FetchPhc());
            } else if (state is PhcLoaded) {
              print("Phc loaded");
              final phc = state.phc;

              return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<PhcBloc>(context).add(
                      RefreshPhc(),
                    );
                    return _refreshCompleter.future;
                  },
                  child: _buildList(phc)
                  // ListView.builder(
                  //     itemCount: phc.callcards.length,
                  //     itemBuilder: (context, index) {
                  //       final callInfo = phc.callcards[index].call_information;
                  //       return ListTile(
                  //         title: Text(callInfo.callcard_no),
                  //         subtitle: Text(callInfo.callReceived != null
                  //             ? callInfo.callReceived.substring(
                  //                 0, callInfo.call_received.length - 2)
                  //             : callInfo.callReceived),
                  //       );
                  //     })

                  );
            }

            if (state is PhcFetched) {
              final phc = state.phc;
              print("Phc fetched");

              phcBloc.add(AddPhc(phc: phc));
              print("after loadphc");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(phc) {
    return ListView.separated(
      itemCount: phc.callcards.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
      ),
      itemBuilder: (BuildContext context, int index) {
        final callInfo = phc.callcards[index].call_information;

        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Text(
                callInfo.callcard_no,
              )),
              Text(
                DateFormat("d MMM yyyy, hh:mm aaa")
                    .format(DateTime.parse(callInfo.call_received)),
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
          subtitle:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
            Column(children: [
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(
                      Icons.person,
                      size: 16,
                    )),
                Text(phc.callcards[index].patients.length.toString() +
                    ' Patients'),
                Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(
                      Icons.person,
                      size: 16,
                    )),
                Text(phc.callcards[index].response_team.staffs.length
                        .toString() +
                    ' Teams')
              ])
            ]),
            Container(
                padding: EdgeInsets.all(5),
                decoration: new BoxDecoration(
                    // color: Colo,
                    border: Border.all(width: 1.5, color: Colors.orange),
                    borderRadius: new BorderRadius.all(Radius.circular(5.0))),
                child:
                    Text((callInfo.plate_no != null) ? callInfo.plate_no : ""))
          ]),
          leading: Container(
              // alignment: Alignment.centerLeft,
              width: 60,
              height: 60,
              decoration: new BoxDecoration(
                color: Colors.pinkAccent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.headset_mic)),
          // trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CallcardTabs(
                          callcard_no: callInfo.callcard_no,
                          call_information:
                              phc.callcards[index].call_information,
                          response_team: phc.callcards[index].response_team,
                          response_time: phc.callcards[index].response_time,
                          patients: phc.callcards[index].patients,
                          // phcDao: widget.phcDao,
                        )));
            // Navigator.pushNamed(context, "/callcarddetail");
          },
        );
      },
    );
  }

  Widget TopUserMenu() {
    Staff user = authBloc.getAuthorizedUser;
    return PopupMenuButton<WhatTodo>(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              user.userid,
              style: TextStyle(fontFamily: "Raleway"),
            )),
        Container(
            // alignment: Alignment.centerLeft,
            width: 30,
            height: 30,
            decoration: new BoxDecoration(
              color: Colors.pinkAccent,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person))
      ]),
      onSelected: (WhatTodo result) {
        if (result == WhatTodo.logout) {
          //  authBloc.add (LogoutButtonPressed());
          loginBloc.add(LogoutButtonPressed());
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhatTodo>>[
        const PopupMenuItem<WhatTodo>(
          value: WhatTodo.logout,
          child: Text("LOGOUT      "),
        ),
      ],
    );
    // ]);
  }

  Widget TopOtherMenu() {
    // Staff user = loginBloc.getAuthorizedUser;
    return PopupMenuButton<WhatTodo>(
      // child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //   Padding(padding: EdgeInsets.only(right: 10), child: Text(user.userid)),
      //   Container(
      //       // alignment: Alignment.centerLeft,
      //       width: 30,
      //       height: 30,
      //       decoration: new BoxDecoration(
      //         color: Colors.orange,
      //         shape: BoxShape.circle,
      //       ),
      //       child: Icon(Icons.person))
      // ]),
      onSelected: (WhatTodo result) {
        if (result == WhatTodo.history) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => History()));
        } else if (result == WhatTodo.newCallcard) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CallcardTabs(
                        callcard_no: "",
                        call_information: new CallInformation(),
                        response_time: new ResponseTime(),
                        response_team: new ResponseTeam(),
                        patients: List(),
                      )));
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhatTodo>>[
        const PopupMenuItem<WhatTodo>(
          value: WhatTodo.newCallcard,
          child: Text("NEW CALLCARD"),
        ),
        const PopupMenuItem<WhatTodo>(
          value: WhatTodo.history,
          child: Text("HISTORY"),
        )
      ],
    );
    // ]);
  }
}
