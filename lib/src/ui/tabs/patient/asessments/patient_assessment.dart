import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/models/chip_item.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/pat_ass_bloc.dart';
import 'package:phcapp/src/widgets/my_multiple_option.dart';
import 'package:phcapp/src/widgets/my_single_option.dart';
import 'package:phcapp/src/widgets/mycard_single_option.dart';

const _disasterTriage = ["Red", "Yellow", "Green", "White"];
const _appearance = ["Oriented", "Lethargy", "Confused", "In pain"];
const _responsiveness = ["Alert", "Verbal", "Pain", "Unresponsive"];
const _airway = [
  "Adequate airway",
  "Apnea/agonal respiration",
  "Gag reflex absent",
  "Sonorous sound",
  "Injury involving airway"
];
const _respiratory = [
  "Normal",
  "Rapid",
  "Distressed",
  "Use of accessory muscles",
  "Apnoeic",
  "Weak/agonal"
];
const _airEntry = ["Normal", "Decreased", "Absent"];
const _breathSound = ["Normal", "Rhonchi", "Crepitation", "Silent"];
const _heartSound = ["Normal", "Muffled", "Murmur"];
const _skinAssment = [
  "Normal",
  "Pale",
  "Mottled",
  "Jaundice",
  "Hot",
  "Diaphoretic",
  "Cold",
  "Clammy",
  "Dry"
];
const _ecg = [
  "Sinus Rhythm",
  "Sinus tachycardia",
  "Bradycardia",
  "AF",
  "STEMI",
  "NSTEMI",
  "SVT",
  "VT with pulse"
];
const _abdomenPalpation = [
  "Soft & non-tender",
  "Tender",
  "Rebound tenderness",
  "Guarded",
  "Uterus palpable",
  "Mass"
];
const _abdomenAbnorm = [
  "Generalized",
  "Epigastric",
  "Periumbilical",
  "Left upper quadrant",
  "Left lower quadrant",
  "Right upper quadrant",
  "Right lower quadrant"
];
const _face = [
  "Normal",
  "Abnormal pre-existing",
  "Facial droop left",
  "Facial droop right",
  "Unable to perform"
];
const _speech = [
  "Normal",
  "Abrnormal pre-existing",
  "Slurring",
  "Unable to assess"
];
const _arm = [
  "Normal",
  "Abrnormal pre-existing",
  "Arm drift right",
  "Arm drift left",
  "Unable to assess"
];

const _normality = ["Normal", "Abnormal"];

class PatientAssessmentScreen extends StatefulWidget {
  final PatientAssessment patientAssessment;

  PatientAssessmentScreen({this.patientAssessment});

  _PatientAssessmentScreen createState() => _PatientAssessmentScreen();
}

class _PatientAssessmentScreen extends State<PatientAssessmentScreen>
    with AutomaticKeepAliveClientMixin<PatientAssessmentScreen> {
  @override
  bool get wantKeepAlive => true;
// {
  List<String> listTriage = new List<String>();
  List<String> listAppearance = new List<String>();
  List<String> listLevelResponsiveness = new List<String>();
  List<String> listAirway = new List<String>();
  List<String> listRespiratory = new List<String>();
  List<String> listAirEntryL = new List<String>();
  List<String> listAirEntryR = new List<String>();
  List<String> listBreathSoundL = new List<String>();
  List<String> listBreathSoundR = new List<String>();
  List<String> listHeartSound = new List<String>();
  List<String> listSkin = new List<String>();
  List<String> listECG = new List<String>();
  List<String> listAbdomenPalpation = new List<String>();
  List<String> listAbdomenAbnPalpation = new List<String>();
  List<String> listStrokeFace = new List<String>();
  List<String> listStrokeSpeech = new List<String>();
  List<String> listStrokeArm = new List<String>();
  List<String> listStrokeBalance = new List<String>();
  List<String> listStrokeEyeSight = new List<String>();

  TextEditingController abnormalTextController = new TextEditingController();
  TextEditingController otherController = new TextEditingController();

  List<ChipItem> prepareData = [
    // ChipItem(
    //     id: "disaster_triage",
    //     name: "Disaster Triage",
    //     listData: _disasterTriage,
    //     value: ""),
    ChipItem(
        id: "appearance",
        name: "Appearance",
        listData: _appearance,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "level_responsive",
        name: "Level of Responsiveness",
        listData: _responsiveness,
        value: ""),
    ChipItem(
        id: "airway_patency",
        name: "Airway Patency",
        listData: _airway,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "respiratory_effort",
        name: "Respiratory Effort",
        listData: _respiratory,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "airentry_left",
        name: "Air Entry: Left Lung",
        listData: _airEntry,
        value: ""),
    ChipItem(
        id: "airentry_right",
        name: "Air Entry: Right Lung",
        listData: _airEntry,
        value: ""),
    ChipItem(
        id: "breath_left",
        name: "Breath Sound: Left Lung",
        listData: _breathSound,
        value: ""),
    ChipItem(
        id: "breath_right",
        name: "Breath Sound: Right Lung",
        listData: _breathSound,
        value: ""),
    ChipItem(
        id: "heart_sound",
        name: "Heart Sound",
        listData: _heartSound,
        value: ""),
    ChipItem(
        id: "skin",
        name: "Skin Assessment",
        listData: _skinAssment,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "ecg",
        name: "ECG",
        listData: _ecg,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "abdomen_palpation",
        name: "Abdomen Palpation",
        listData: _abdomenPalpation,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "abdomen_abnormal_location",
        name: "Abdomen Abnormality Location",
        listData: _abdomenAbnorm,
        value: "",),
    ChipItem(
        id: "stroke_face",
        name: "Stroke Scale: Face",
        listData: _face,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "stroke_speech",
        name: "Stroke Scale: Speech",
        listData: _speech,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "stroke_arm",
        name: "Stroke Scale: Arm",
        listData: _arm,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "stroke_balance",
        name: "Stroke Scale: Balance",
        listData: _normality,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "stroke_eyesight",
        name: "Stroke Scale: Eye Sight",
        listData: _normality,
        value: List<String>(),
        multiple: true),
  ];

  mycallback(id, List<String> dataReturn) {
    if (id == "disaster_triage") {
      setState(() {
        listTriage = dataReturn;
      });
    }

    if (id == "appearance") {
      setState(() {
        listAppearance = dataReturn;
        // otherController.clear();
      });
    }

    if (id == "level_responsive") {
      setState(() {
        listLevelResponsiveness = dataReturn;
      });
    }

    if (id == "airway_patency") {
      setState(() {
        listAirway = dataReturn;
      });
    }

    if (id == "respiratory_effort") {
      setState(() {
        listRespiratory = dataReturn;
      });
    }

    if (id == "airentry_left") {
      setState(() {
        listAirEntryL = dataReturn;
      });
    }

    if (id == "airentry_right") {
      setState(() {
        listAirEntryR = dataReturn;
      });
    }

    if (id == "breath_left") {
      setState(() {
        listBreathSoundL = dataReturn;
      });
    }

    if (id == "breath_right") {
      setState(() {
        listBreathSoundR = dataReturn;
      });
    }

    if (id == "heart_sound") {
      setState(() {
        listHeartSound = dataReturn;
      });
    }

    if (id == "skin") {
      setState(() {
        listSkin = dataReturn;
      });
    }

    if (id == "ecg") {
      setState(() {
        listECG = dataReturn;
      });
    }

    if (id == "abdomen_palpation") {
      setState(() {
        listAbdomenPalpation = dataReturn;
      });
    }
    if (id == "abdomen_abnormal_location") {
      setState(() {
        listAbdomenAbnPalpation = dataReturn;
      });
    }
    if (id == "stroke_face") {
      setState(() {
        listStrokeFace = dataReturn;
      });
    }
    if (id == "stroke_speech") {
      setState(() {
        listStrokeSpeech = dataReturn;
      });
    }
    if (id == "stroke_arm") {
      setState(() {
        listStrokeArm = dataReturn;
      });
    }
    if (id == "stroke_balance") {
      setState(() {
        listStrokeBalance = dataReturn;
      });
    }
    if (id == "stroke_eyesight") {
      setState(() {
        listStrokeEyeSight = dataReturn;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.patientAssessment != null) {
      prepareData.map((f) {
        if (f.id == "disaster_triage") {
          f.value = widget.patientAssessment.disasterTriage;
          listTriage.add(widget.patientAssessment.disasterTriage);
          if (listTriage.length > 1) {
            listTriage.removeLast();
          }
        }
        if (f.id == "appearance") {
          f.value = widget.patientAssessment.appearance;
          listAppearance = widget.patientAssessment.appearance;
        }
        if (f.id == "level_responsive") {
          f.value = widget.patientAssessment.levelResponsive;
          listLevelResponsiveness.add(widget.patientAssessment.levelResponsive);
          if (listLevelResponsiveness.length > 1) {
            listLevelResponsiveness.removeLast();
          }
        }
        if (f.id == "airway_patency") {
          f.value = widget.patientAssessment.airwayPatency;
          listAirway = widget.patientAssessment.airwayPatency;
        }
        if (f.id == "respiratory_effort") {
          f.value = widget.patientAssessment.respiratoryEffort;
          listRespiratory = widget.patientAssessment.respiratoryEffort;
        }
        if (f.id == "airentry_left") {
          f.value = widget.patientAssessment.airEntry.leftLung;
          listAirEntryL.add(widget.patientAssessment.airEntry.leftLung);
          if (listAirEntryL.length > 1) {
            listAirEntryL.removeLast();
          }
        }
        if (f.id == "airentry_right") {
          f.value = widget.patientAssessment.airEntry.rightLung;
          listAirEntryR.add(widget.patientAssessment.airEntry.rightLung);
          if (listAirEntryR.length > 1) {
            listAirEntryR.removeLast();
          }
        }
        if (f.id == "breath_left") {
          f.value = widget.patientAssessment.breathSound.leftLung;
          listBreathSoundL.add(widget.patientAssessment.breathSound.leftLung);
          if (listBreathSoundL.length > 1) {
            listBreathSoundL.removeLast();
          }
        }
        if (f.id == "breath_right") {
          f.value = widget.patientAssessment.breathSound.rightLung;
          listBreathSoundR.add(widget.patientAssessment.breathSound.rightLung);
          if (listBreathSoundR.length > 1) {
            listBreathSoundR.removeLast();
          }
        }
        if (f.id == "heart_sound") {
          f.value = widget.patientAssessment.heartSound;
          listHeartSound.add(widget.patientAssessment.heartSound);
          if (listHeartSound.length > 1) {
            listHeartSound.removeLast();
          }
        }
        if (f.id == "skin") {
          f.value = widget.patientAssessment.skin;
          listSkin = widget.patientAssessment.skin;
        }
        if (f.id == "ecg") {
          f.value = widget.patientAssessment.ecg;
          listECG = widget.patientAssessment.ecg;
        }
        if (f.id == "abdomen_palpation") {
          f.value = widget.patientAssessment.abdomenPalpation;
          listAbdomenPalpation = widget.patientAssessment.abdomenPalpation;
        }
        if (f.id == "abdomen_abnormal_location") {
          f.value = widget.patientAssessment.abdomenAbnormalityLocation;
          listAbdomenAbnPalpation.add(widget.patientAssessment.abdomenAbnormalityLocation);
          if (listAbdomenAbnPalpation.length > 1) {
            listAbdomenAbnPalpation.removeLast();
          }
        }
        if (f.id == "stroke_face") {
          f.value = widget.patientAssessment.strokeScale.face;
          listStrokeFace = widget.patientAssessment.strokeScale.face;
        }
        if (f.id == "stroke_speech") {
          f.value = widget.patientAssessment.strokeScale.speech;
          listStrokeSpeech = widget.patientAssessment.strokeScale.speech;
          if (listStrokeSpeech.length > 1) {
            listStrokeSpeech.removeLast();
          }
        }
        if (f.id == "stroke_arm") {
          f.value = widget.patientAssessment.strokeScale.arm;
          listStrokeArm = widget.patientAssessment.strokeScale.arm;
        }
        if (f.id == "stroke_balance") {
          f.value = widget.patientAssessment.strokeScale.balance;
          listStrokeBalance = widget.patientAssessment.strokeScale.balance;
        }
        if (f.id == "stroke_eyesight") {
          f.value = widget.patientAssessment.strokeScale.eyesight;
          listStrokeEyeSight = widget.patientAssessment.strokeScale.eyesight;
        }

        // f.value = widget.patientAssessment.abdomenAbnormalityLocation;
        return f;
      }).toList();

      // clear textfield others
      widget.patientAssessment != null
            ? otherController.text = widget.patientAssessment.appearanceOthers
            : otherController.clear();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        // appBar: AppBar(
        //   title: Text("Patient Assessment"),
        //   actions: <Widget>[
        //     FlatButton.icon(
        //       icon: Icon(Icons.save, color: Colors.white),
        //       label: Text(
        //         "SAVE",
        //         style: TextStyle(color: Colors.white),
        //       ),
        //       onPressed: () {
        //         PatientAssessment patientAssessment = new PatientAssessment(
        //             timestamp: new DateTime.now(),
        //             disasterTriage: listTriage.length > 0 ? listTriage[0] : "",
        //             appearance:
        //                 listAppearance.length > 0 && listAppearance[0] == "Other"
        //                     ? otherController.text
        //                     : listAppearance[0],
        //             levelResponsive: listLevelResponsiveness.length > 0
        //                 ? listLevelResponsiveness[0]
        //                 : "",
        //             airwayPatency: listAirway.length > 0 ? listAirway[0] : "",
        //             respiratoryEffort:
        //                 listRespiratory.length > 0 ? listRespiratory[0] : "",
        //             airEntry: AirEntry(
        //                 leftLung:
        //                     listAirEntryL.length > 0 ? listAirEntryL[0] : "",
        //                 rightLung:
        //                     listAirEntryR.length > 0 ? listAirEntryR[0] : ""),
        //             breathSound: BreathSound(
        //                 leftLung: listBreathSoundL.length > 0
        //                     ? listBreathSoundL[0]
        //                     : "",
        //                 rightLung: listBreathSoundR.length > 0
        //                     ? listBreathSoundR[0]
        //                     : ""),
        //             heartSound:
        //                 listHeartSound.length > 0 ? listHeartSound[0] : "",
        //             skin: listSkin,
        //             ecg: listECG.length > 0 ? listECG[0] : "",
        //             abdomenPalpation: listAbdomenPalpation.length > 0
        //                 ? listAbdomenPalpation[0]
        //                 : "",
        //             abdomenAbnormalityLocation: abnormalTextController.text,
        //             strokeScale: StrokeScale(
        //               arm: listStrokeArm.length > 0 ? listStrokeArm[0] : "",
        //               face: listStrokeFace.length > 0 ? listStrokeFace[0] : "",
        //               speech:
        //                   listStrokeSpeech.length > 0 ? listStrokeSpeech[0] : "",
        //             ));

        //         BlocProvider.of<AssPatientBloc>(context)
        //             .add(UpdateAssPatient(patientAssessment: patientAssessment));

        //         Navigator.pop(context);
        //       },
        //     )
        //   ],
        // ),
        body: Card(
          margin: EdgeInsets.all(12),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                HeaderSection("Patient Assessment"),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    PatientAssessment patientAssessment = new PatientAssessment(
                        timestamp: new DateTime.now(),
                        disasterTriage:
                            listTriage.length > 0 ? listTriage[0] : "",
                        appearance: listAppearance.length > 0 ? listAppearance : List<String>(),
                        appearanceOthers: otherController.text,
                        levelResponsive: listLevelResponsiveness.length > 0
                            ? listLevelResponsiveness[0]
                            : "",
                        airwayPatency:
                            listAirway.length > 0 ? listAirway : List<String>(),
                        respiratoryEffort: listRespiratory.length > 0
                            ? listRespiratory
                            : List<String>(),
                        airEntry: AirEntry(
                            leftLung: listAirEntryL.length > 0
                                ? listAirEntryL[0]
                                : "",
                            rightLung: listAirEntryR.length > 0
                                ? listAirEntryR[0]
                                : ""),
                        breathSound: BreathSound(
                            leftLung: listBreathSoundL.length > 0
                                ? listBreathSoundL[0]
                                : "",
                            rightLung: listBreathSoundR.length > 0
                                ? listBreathSoundR[0]
                                : ""),
                        heartSound:
                            listHeartSound.length > 0 ? listHeartSound[0] : "",
                        skin: listSkin,
                        ecg: listECG.length > 0 ? listECG : List<String>(),
                        abdomenPalpation: listAbdomenPalpation.length > 0
                            ? listAbdomenPalpation
                            : List<String>(),
                        abdomenAbnormalityLocation: listAbdomenAbnPalpation.length > 0
                                                    ? listAbdomenAbnPalpation.last
                                                    : "",
                        strokeScale: StrokeScale(
                          arm: listStrokeArm.length > 0
                              ? listStrokeArm
                              : List<String>(),
                          face: listStrokeFace.length > 0
                              ? listStrokeFace
                              : List<String>(),
                          speech: listStrokeSpeech.length > 0
                              ? listStrokeSpeech
                              : List<String>(),
                          balance: listStrokeBalance.length > 0
                              ? listStrokeBalance
                              : List<String>(),
                          eyesight: listStrokeEyeSight.length > 0
                              ? listStrokeEyeSight
                              : List<String>(),
                        ));

                    BlocProvider.of<AssPatientBloc>(context).add(
                        UpdateAssPatient(patientAssessment: patientAssessment));

                    Navigator.pop(context);
                  },
                )
              ],
            ),
            _buildBody()
          ]),
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      // margin: EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: prepareData.length,
          itemBuilder: (context, index) {
            if (prepareData[index].multiple == true) {
              return _buildCardMultiple(prepareData[index]);
            }
            String initialData;
            !_appearance.contains(prepareData[index].value)
                ? initialData = "Other"
                : initialData = prepareData[index].value;
            return  MyCardSingleOption(
                    id: prepareData[index].id,
                    name: prepareData[index].name,
                    listData: prepareData[index].listData,
                    mycallback: mycallback,
                    value: prepareData[index].value,
                  );

            // );
          }),
    );
  }

  _buildCardMultiple(mystate) {
    var id = mystate.id;
    var name = mystate.name;
    var listData = mystate.listData;
    List<String> value = mystate.value;
    return Card(
      child: Container(
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            MyMultipleOptions(
              id: id,
              listDataset: listData,
              initialData: value,
              callback: mycallback,
            ),
            id == "appearance"
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      controller: otherController,
                      decoration: InputDecoration(
                          labelText: "Other"),
                    ),
                  )
                : Container(),

            // ],
            // ),
          ],
        ),
      ),
    );
  }
// }
}

class MyAppearanceOption extends StatelessWidget {
  final id;
  final name;
  final listData;
  final value;
  final controller;
  final Function mycallback;

  MyAppearanceOption(
      {this.id,
      this.controller,
      this.name,
      this.listData,
      this.value,
      this.mycallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                name,

                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                // style: TextStyle(fontSize: 20),
              ),
            ),
            MySingleOptions(
              id: id,
              listDataset: listData,
              initialData: value,
              callback: mycallback,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.5,
            //       child: TextField(
            //       style: TextStyle(fontSize: 18),
            //       controller: controller,
            //       decoration: InputDecoration(labelText: "Other"),
            //     ),
            // )
            
          ],
        ),
      ),
    );
  }
}
