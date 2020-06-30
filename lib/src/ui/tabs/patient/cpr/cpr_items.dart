// import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
// import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_timelog.dart';
import 'package:provider/provider.dart';

// import 'cpr_tabs.dart';

class CPRItems extends StatefulWidget {
  // final BuildContext context;
  // final CprSection cprSection;

  // CPRItems({this.cprSection});
  _CPRItems createState() => _CPRItems();
}

const WITNESS = ["Yes", "No"];
const RHYTHM = ["VF", "Pulseless VT"];
const INTERV = ["Defibrillation"];
const INTEROT = ["Sync-cardioversion", "Pacing"];
const DRUG = ["Adrenaline", "Amiodarone"];
const DRUOT = ["Atropine"];
const AIRWAY = ["BVM", "LMA", "ETT"];
const RHYTHMNS = ["Asystole", "PEA"];
const RHYTHMOT = ["Tachyarythmias", "Bradyarrythmias"];
const ANALYSIS = ["Shockable", "Non-Shockable", "Other"];

class _CPRItems extends State<CPRItems>
    with AutomaticKeepAliveClientMixin<CPRItems> {
  @override
  bool get wantKeepAlive => true;

// {  // String selected;
  String onShock = "Shockable";
  String onNonShock;
  String onOther;

  Analysis shockable = new Analysis();
  Analysis nonShockable = new Analysis();
  Analysis other = new Analysis();

  CPRProvider cprProvider;

  CprLog cprLog = new CprLog(witnessCpr: new Cpr());
  String selectWitness;
  String selectBystander;
  String selectCprStart;
  String selectCprStop;
  String selectRosc;
  String selectAnalysis;
  String selectRhythm;
  String selectRhythmNS;
  String selectRhythmO;
  String selectInter;
  String selectInterNS;
  String selectInterO;
  String selectDrug;
  String selectDrugNS;
  String selectDrugO;
  String selectAirway;
  String selectAirwayNS;
  String selectAirwayO;
  TextEditingController witnessController = new TextEditingController();
  TextEditingController bystanderController = new TextEditingController();
  TextEditingController cprStartController = new TextEditingController();
  TextEditingController cprStopController = new TextEditingController();
  TextEditingController roscController = new TextEditingController();
  TextEditingController rhythmController = new TextEditingController();
  TextEditingController rhythmNSController = new TextEditingController();
  TextEditingController rhythmOController = new TextEditingController();
  TextEditingController intervController = new TextEditingController();
  TextEditingController intervNSController = new TextEditingController();
  TextEditingController intervOController = new TextEditingController();
  TextEditingController drugController = new TextEditingController();
  TextEditingController drugNSController = new TextEditingController();
  TextEditingController drugOController = new TextEditingController();
  TextEditingController airwayController = new TextEditingController();
  TextEditingController airwayNSController = new TextEditingController();
  TextEditingController airwayOController = new TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  // }

  ItemModel getValue(context, id) {
    var myProvider = Provider.of<CPRProvider>(context);
    var result =
        myProvider.itemModels.firstWhere((f) => f.id == id, orElse: () => null);

    if (result == null)
      return null;
    else
      return result;
  }

  @override
  void didChangeDependencies() {
    //   if (widget.cprSection != null) {

    //     // setState(() {
    // var myProvider = Provider.of<CPRProvider>(context);

    // CprSection cprSection = new CprSection(
    //     witnessCpr: getValue(context, 'witness_cpr').value,
    //     bystanderCpr: getValue(context, 'bystander_cpr').value,
    //     cprStart: getValue(context, 'cpr_start').value,
    //     cprStop: getValue(context, 'cpr_stop').value,
    //     rosc: getValue(context, 'rosc').value,
    //     shockable: shockable,
    //     nonShockable: nonShockable,
    //     other: other,
    //     logs: myProvider.allLogs);
    // print("DID CHANGES");
    // myProvider.updateCPR(cprSection);
    // //     // });
    // // cprProvider = Provider.of<CPRProvider>(context);

    // super.didChangeDependencies();
  }

  // }

  @override
  Widget build(BuildContext context) {
    // if (widget.cprSection != null) {
    //   final cpr = widget.cprSection;
    //   witnessCpr = cpr.witnessCpr;
    //   bystanderCpr = cpr.bystanderCpr;
    //   cprStart = cpr.cprStart;
    //   cprStop = cpr.cprStop;
    //   rosc = cpr.rosc;

    //   shockable = cpr.shockable;
    //   nonShockable = cpr.nonShockable;
    //   other = cpr.other;
    // }

    // if (widget.cprSection != null) {
    // final cprProvider = Provider.of<CPRProvider>(context);
    //   cprProvider.setLogs(widget.cprSection.logs);
    // }

    // final provider = Provider.of<CPRProvider>(context);
    // var myProvider = Provider.of<CPRProvider>(context);
    // if (widget.cprSection != null) {
    //   // setState(() {

    //   // markNeedBuild() {
    //   myProvider.updateCPR(widget.cprSection);
    //   // }
    //   // setState(() {});
    //   // });
    // }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.remove_red_eye),
                  label: Text("VIEW LOG HISTORY"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                _buildChoiceChip(context, "witness_cpr", WITNESS, selectWitness,
                    witnessController,),
                _buildChoiceChip(context, "bystander_cpr", WITNESS,
                    selectBystander, bystanderController),
                _buildChoiceChip(context, "cpr_start", WITNESS, selectCprStart,
                    cprStartController),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   padding: EdgeInsets.only(left: 10),
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "Rhythm Analysis:",
                //     // textAlign: TextAlign.left,
                //   ),
                // ),
                // // _buildAnalysis(),
                _buildAddCycle(),
                _buildCounterRhythm(),
                _buildChoiceChip(
                    context, "rosc", WITNESS, selectRosc, roscController),
                _buildChoiceChip(context, "cpr_stop", WITNESS, selectCprStop,
                    cprStopController),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  onSelected(context, id, value) {
    //get cprstart button click state
    if (id == "cpr_start") {
      print("cpr pressed");
      print("what the value now " + value);
    }

    final cprProvider = Provider.of<CPRProvider>(context, listen: false);

    cprProvider.updateValue(id, value);

    var item = cprProvider.itemModels
        .firstWhere((f) => f.id == id, orElse: () => null);
    // ItemModel item = getValue(context, id);

    if (value != null) {
      String format =
          DateFormat("dd/MM/yyyy @ hh:mm aa").format(DateTime.now()) +
              " -- " +
              item.name +
              " " +
              value;

      // cprProvider.addLog(format);
      confirmAddLog(context, cprProvider, format);
    }
    // selected.value = value;
// ItemModel item = getValue(context, id);
  }

  // onSelected(labelText, value) {
  //   print("IM in ONSELECTED WHY NOT TRIGGER");
  //   final cprProvider = Provider.of<CPRProvider>(context, listen: false);

  //   if (labelText == "Witness CPR") {
  //     // setState(() {
  //     witnessCpr = value;
  //     // cprProvider.setWitnessCPR(value);
  //     // });
  //   }
  //   if (labelText == "Bystander CPR") {
  //     // setState(() {
  //     bystanderCpr = value;
  //     // provider.byStanderCPR = value;
  //     // });
  //   }
  //   if (labelText == "CPR Start") {
  //     // setState(() {
  //     cprStart = value;
  //     // });
  //   }
  //   if (labelText == "ROSC") {
  //     // setState(() {
  //     rosc = value;
  //     // });
  //   }

  //   if (labelText == "CPR Stop") {
  //     // setState(() {
  //     cprStop = value;
  //     // });
  //   }
  //   if (labelText == "Rhythm") {
  //     if (onShock != null) {
  //       // setState(() {
  //       shockable.rhythm = value;
  //       // });
  //     } else if (onNonShock != null) {
  //       // setState(() {
  //       nonShockable.rhythm = value;
  //       // });
  //     } else if (onOther != null) {
  //       // setState(() {
  //       other.rhythm = value;
  //       // });
  //     }
  //   }

  //   if (labelText == "Intervention") {
  //     if (onShock != null) {
  //       // setState(() {
  //       shockable.intervention = value;
  //       // });
  //     } else if (onNonShock != null) {
  //       // setState(() {
  //       nonShockable.intervention = value;
  //       // });
  //     } else if (onOther != null) {
  //       // setState(() {
  //       other.intervention = value;
  //       // });
  //     }
  //   }

  //   if (labelText == "Drugs") {
  //     if (onShock != null) {
  //       // setState(() {
  //       shockable.drugs = value;
  //       // });
  //     } else if (onNonShock != null) {
  //       // setState(() {
  //       nonShockable.drugs = value;
  //       // });
  //     } else if (onOther != null) {
  //       // setState(() {
  //       other.drugs = value;
  //       // });
  //     }
  //   }

  //   if (labelText == "Airway") {
  //     if (onShock != null) {
  //       // setState(() {
  //       shockable.airway = value;
  //       // });
  //     } else if (onNonShock != null) {
  //       // setState(() {
  //       nonShockable.airway = value;
  //       // });
  //     } else if (onOther != null) {
  //       // setState(() {
  //       other.airway = value;
  //       // });
  //     }
  //   }

  //   CprSection cpr = new CprSection(
  //     witnessCpr: witnessCpr,
  //   );

  //   cprProvider.updateCPR(cpr);

  //   if (value != null) {
  //     String format =
  //         DateFormat("dd/MM/yyyy @ hh:mm aa").format(DateTime.now()) +
  //             " -- " +
  //             labelText +
  //             " " +
  //             value;

  //     cprProvider.addLog(format);
  //     // confirmLog(format);
  //   }
  // }

  _buildChoiceChip(context, id, data, select, controller) {
    ItemModel item = getValue(context, id);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(item.name),
            Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Expanded(
                // child:
                Wrap(
                  // children: [
                  // Expanded(
                  children: List<Widget>.generate(data.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        pressElevation: 5.0,
                        elevation: 2.0,
                        key: UniqueKey(),
                        label: Text(data[index]),
                        selected: data[index] == select,
                        onSelected: (bool selected) {
                          print("witness cpr pressed!");
                          print(id);
                          if (id == "witness_cpr") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectWitness = data[index];
                              cprLog.witnessCpr = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          if (id == "bystander_cpr") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectBystander = data[index];
                              cprLog.bystanderCpr = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          if (id == "cpr_start") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectCprStart = data[index];
                              cprLog.cprStart = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          if (id == "rosc") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectRosc = data[index];
                              cprLog.rosc = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          if (id == "cpr_stop") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectCprStop = data[index];
                              cprLog.cprStop = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          // providerSelected.updateValue(labelText, data[index]);
                          // if (data[index] != null) {
                          //   String format = DateFormat("dd/MM/yyyy @ hh:mm aa")
                          //           .format(DateTime.now()) +
                          //       " -- " +
                          //       labelText +
                          //       " " +
                          //       data[index];

                          //   cprProvider.addLog(format);
                          //   // confirmLog(format);
                          // }
                          // onSelected(context, id, data[index]);
                        },
                        selectedColor: Colors.pink[200],
                      ),
                    );
                  }),
                ),
                // ),
                // Expanded(
                // child:
                Container(
                  width: 150,
                  child: TextField(controller: controller

                      // cprLog.witnessCpr != null
                      //   ? DateFormat("dd/MM/yyyy HH:mm")
                      //       .format(cprLog.witnessCpr.timestamp)
                      //   : "Time"),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.edit,
                      //     color: Colors.blue,
                      //   ),
                      //   onPressed: () {},
                      ),
                )
                // )
                // ])
              ],
              // )
              // ],
            ),
          ]),
    );
  }
  _buildChoiceAnalysis(context, id, data, select, controller, setState) {
    ItemModel item = getValue(context, id);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(item.name),
            Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Expanded(
                // child:
                Wrap(
                  // children: [
                  // Expanded(
                  children: List<Widget>.generate(data.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        pressElevation: 5.0,
                        elevation: 2.0,
                        key: UniqueKey(),
                        label: Text(data[index]),
                        selected: data[index] == select,
                        onSelected: (bool selected) {
                          print("witness cpr pressed!");
                          print(id);
                          if (id == "srhythm") {
                            setState(() {

    //                           ItemModel(id: "srhythm", name: "Rhythm"),
    // ItemModel(id: "sinterv", name: "Intervention"),
    // ItemModel(id: "sdrugs", name: "Drugs"),
    // ItemModel(id: "sairway", name: "Airway"),
    // ItemModel(id: "nsrhythm", name: "Rhythm"),
    // ItemModel(id: "nsinterv", name: "Intervention"),
    // ItemModel(id: "nsdrugs", name: "Drugs"),
    // ItemModel(id: "nsairway", name: "Airway"),
    // ItemModel(id: "orhythm", name: "Rhythm"),
    // ItemModel(id: "ointerv", name: "Intervention"),
    // ItemModel(id: "odrugs", name: "Drugs"),
    // ItemModel(id: "oairway", name: "Airway"),
    // ItemModel(id: "analysis", name: "Analysis"),
  
                              var temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              // print(item.value);
                              selectRhythm = data[index];
                              
                              // cprLog. = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          if (id == "bystander_cpr") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectBystander = data[index];
                              cprLog.bystanderCpr = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          if (id == "cpr_start") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectCprStart = data[index];
                              cprLog.cprStart = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          if (id == "rosc") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectRosc = data[index];
                              cprLog.rosc = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          if (id == "cpr_stop") {
                            setState(() {
                              final temp = Cpr(
                                  value: item.value,
                                  timestamp: new DateTime.now());
                              // cprLog.witnessCpr.value = item.value;
                              // cprLog.witnessCpr.timestamp = new DateTime.now();
                              print(item.value);
                              selectCprStop = data[index];
                              cprLog.cprStop = temp;

                              controller.text = DateFormat("dd/MM/yyyy HH:mm")
                                  .format(DateTime.now());
                            });
                          }
                          // providerSelected.updateValue(labelText, data[index]);
                          // if (data[index] != null) {
                          //   String format = DateFormat("dd/MM/yyyy @ hh:mm aa")
                          //           .format(DateTime.now()) +
                          //       " -- " +
                          //       labelText +
                          //       " " +
                          //       data[index];

                          //   cprProvider.addLog(format);
                          //   // confirmLog(format);
                          // }
                          // onSelected(context, id, data[index]);
                        },
                        selectedColor: Colors.pink[200],
                      ),
                    );
                  }),
                ),
                // ),
                // Expanded(
                // child:
                Container(
                  width: 150,
                  child: TextField(controller: controller

                      // cprLog.witnessCpr != null
                      //   ? DateFormat("dd/MM/yyyy HH:mm")
                      //       .format(cprLog.witnessCpr.timestamp)
                      //   : "Time"),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.edit,
                      //     color: Colors.blue,
                      //   ),
                      //   onPressed: () {},
                      ),
                )
                // )
                // ])
              ],
              // )
              // ],
            ),
          ]),
    );
  }

  addRhythmDialog() {
    showDialog(
      context: context,
      // builder: (context, <LogModel> logs, child) {
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(child: _buildAnalysis(setState)
                  // ),
                  ),
            );
          }),
        );
      },
    );
  }

  _buildCounterRhythm() {
    final provider = Provider.of<CPRProvider>(context);
    return SizedBox(
      height: 120,
      // child: Row(children: [
      //   Expanded(
      child:
          // provider.cycleCounter == 0
          //     ? Container(
          //         margin: EdgeInsets.all(5),
          //         alignment: Alignment.center,
          //         width: 60,
          //         height: 60,
          //         decoration: new BoxDecoration(
          //           color: Colors.blue,
          //           shape: BoxShape.circle,
          //         ),
          //         child: IconButton(
          //           icon: Icon(Icons.add),
          //           color: Colors.white,
          //           onPressed: () {
          //             addRhythmDialog();
          //           },
          //         ))
          // :
          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.cycleCounter,
              itemBuilder: (context, index) {
                return
                    // Row(children: [

                    Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white.withOpacity(0.8)),
                  ),
                );
                //   index + 1 == provider.cycleCounter
                //       ? Container(
                //           margin: EdgeInsets.all(5),
                //           alignment: Alignment.center,
                //           width: 60,
                //           height: 60,
                //           decoration: new BoxDecoration(
                //             color: Colors.blue,
                //             shape: BoxShape.circle,
                //           ),
                //           child: IconButton(
                //             icon: Icon(Icons.add),
                //             color: Colors.white,
                //             onPressed: () {
                //               addRhythmDialog();
                //             },
                //           ))
                //       // : Container()
                // ]);
              }),
    );
  }

  _buildAddCycle() {
    final provider = Provider.of<CPRProvider>(context);
    return Padding(
        padding: EdgeInsets.all(10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Rhythm Analysis: " + provider.cycleCounter.toString()),
          RaisedButton.icon(
            label: Text("Add Rhythm Analysis"),
            icon: Icon(Icons.add),
            onPressed: () {
              addRhythmDialog();
              // provider.resetRhythmAnalysis();
              // provider.addCycle();
              // provider.addLog(
              //     "Rhythm Analysis > " + provider.cycleCounter.toString());
            },
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              // side: BorderSide(color: Colors.red)
            ),
            // clipBehavior: Clip.hardEdge,
          )
        ]));
  }

  _buildAnalysis(Function setState) {
    final provider = Provider.of<CPRProvider>(context);
    return Container(
      // padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Wrap(
            children: List<Widget>.generate(ANALYSIS.length, (index) {
              return Padding(
                padding: EdgeInsets.only(right: 10),
                child: ChoiceChip(
                  pressElevation: 5.0,
                  elevation: 2.0,
                  key: UniqueKey(),
                  label: Text(ANALYSIS[index]),
                  selected: ANALYSIS[index] == selectAnalysis,
                  onSelected: (bool selected) {
                    setState(() {
                      selectAnalysis = ANALYSIS[index];
                    });
                  },
                  selectedColor: Colors.pink[200],
                ),
              );
            }),
          ),
          // Card(
          //   margin: EdgeInsets.all(10),
          //   elevation: 2.0,
          // child:
          // Column(
          //   children: <Widget>[
          //     SizedBox(
          //       height: 10,
          //     ),
          // Row(
          //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          // _buildChoiceChip(context, "analysis", ANALYSIS, selectAnalysis,
          //     analysisController),
          // _customButton("Shockable", onShock),
          // _customButton("Non Shockable", onNonShock),
          // _customButton("Other", onOther),
          // ],
          // ),
          _showButtonChoices(setState),
          //   ],
          // ),
          // ),
        ],
      ),
    );
  }

  onPressed(label) {
    if (label == "Shockable") {
      setState(() {
        onShock = label;
        onNonShock = null;
        onOther = null;
      });
    } else if (label == "Non Shockable") {
      setState(() {
        onShock = null;
        onNonShock = label;
        onOther = null;
      });
    } else {
      setState(() {
        onShock = null;
        onNonShock = null;
        onOther = label;
      });
    }

    if (label != null) {
      final provider = Provider.of<CPRProvider>(context, listen: false);
      String format =
          DateFormat("dd/MM/yyyy @ hh:mm aa").format(DateTime.now()) +
              " -- " +
              label +
              " start"; // +
      // " " +
      // value;

      provider.addLog(format);
    }
  }

  _customButton(label, selected) {
    return Container(
      width: 100,
      height: 50,
      // alignment: Alignment.center,
      child: RaisedButton(
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          if (label == "Shockable") {
            setState(() {
              onShock = label;
              onNonShock = null;
              onOther = null;
            });
          } else if (label == "Non Shockable") {
            setState(() {
              onShock = null;
              onNonShock = label;
              onOther = null;
            });
          } else {
            setState(() {
              onShock = null;
              onNonShock = null;
              onOther = label;
            });
          }

          // if (label != null) {
          //   final provider = Provider.of<CPRProvider>(context, listen: false);
          //   String format =
          //       DateFormat("dd/MM/yyyy @ hh:mm aa").format(DateTime.now()) +
          //           " -- " +
          //           label +
          //           " start"; // +
          //   // " " +
          //   // value;

          //   provider.addLog(format);
          // }
          // onPressed(label);
        },
        color: selected != null ? Theme.of(context).accentColor : Colors.white,
        textColor:
            selected != null ? Colors.white : Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Theme.of(context).accentColor)),
      ),
    );
  }

  _showButtonChoices(setState)
  // onShock, onNonShock, onOther)
  {
    if (selectAnalysis == "Shockable") {
      return _buildShockable(setState);
    } else if (selectAnalysis == "Non-Shockable") {
      return _buildNonShockable(setState);
    } else
      return _buildOther(setState);
    // if (onShock != null) {
    // if (onNonShock != null) {
    //   return _buildNonShockable();
    // } else if (onOther != null) {
    //   return _buildOther();
    // }
    // // return Container(
    // return _buildShockable();
    //   padding: EdgeInsets.all(10),
    //   child: Text("No analysis start"),
    // );
  }

  _buildShockable(setState) {
    // final provider = Provider.of<CPRProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          _buildChoiceAnalysis(
              context, "srhythm", RHYTHM, selectRhythm, rhythmController, setState),
          _buildChoiceAnalysis(
              context, "sinterv", INTERV, selectInter, intervController, setState),
          _buildChoiceAnalysis(context, "sdrugs", DRUG, selectDrug, drugController, setState),
          _buildChoiceAnalysis(
              context, "sairway", AIRWAY, selectAirway, airwayController, setState),
        ],
      ),
    );
  }

  _buildNonShockable(setState) {
    // final provider = Provider.of<CPRProvider>(context);

    return Container(
      child: Column(
        children: <Widget>[
          _buildChoiceAnalysis(context, "nsrhythm", RHYTHMNS, selectRhythmNS,
              rhythmNSController, setState),
          _buildChoiceAnalysis(
              context, "nsdrugs", DRUG, selectDrugNS, drugNSController, setState),
          _buildChoiceAnalysis(
              context, "nsairway", AIRWAY, selectAirwayNS, airwayNSController,setState),
        ],
      ),
    );
  }

  _buildOther(setState) {
    // final provider = Provider.of<CPRProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildChoiceAnalysis(context, "orhythm", RHYTHMOT, 
                  selectRhythmO, rhythmOController, setState)),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildChoiceAnalysis(context, "ointerv", INTEROT, selectInterO,
                  intervOController, setState)),
          _buildChoiceAnalysis(
              context, "odrugs", DRUG, selectDrugO, drugOController, setState),
          _buildChoiceAnalysis(
              context, "oairway", AIRWAY, selectAirwayO, airwayOController, setState)
        ],
      ),
    );
  }

  _buildButtonChip(labelText, data) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(labelText),
            Column(
                children: List<Widget>.generate(data.length, (index) {
              return Container(
                  // padding: EdgeInsets.only(right: 10),
                  child: RaisedButton(
                child: Text(data[index]),
                onPressed: () {},
                textColor: Colors.white,
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.pink[200])),
              ));
            }))
          ],
        ));
  }

  confirmAddLog(context, logs, value) {
    TextEditingController commentController =
        new TextEditingController(text: value);
    // final provider = Provider.of<CPRProvider>(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add log"),
            content: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Log description",
                      style: TextStyle(
                          // fontSize: 21,
                          color: Colors.grey),
                    ),
                    TextField(
                      controller: commentController,
                    )
                  ],
                )),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                // color: Colors.lightGreen,
                child: Text(
                  "CANCEL",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Colors.lightGreen,
                child: Text(
                  "ADD LOG",
                ),
                onPressed: () {
                  logs.addLog(value);

                  Navigator.pop(context);
                },
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          );
        });
  }
}
