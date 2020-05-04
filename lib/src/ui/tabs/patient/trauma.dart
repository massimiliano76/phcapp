import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/trauma_provider.dart';
import 'package:provider/provider.dart';

// _head_face_neck_back_chest_abdomen

class Trauma extends StatefulWidget {
  @override
  _PatientTraumaState createState() => _PatientTraumaState();
}

const _head = [
  "normal",
  "abrasion",
  "burn",
  "deformity",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness"
];
const _neck_abnormal = [
  "anterior right",
  "anteriror left",
  "posterior right",
  "posterior left"
];
const _back_abnormal = [
  "thoracic right",
  "thoracic left",
  "lumbar right",
  "lumbar left",
  "sacral right",
  "sacral left"
];

const _spine = ["normal", "tender", "deformity"];
const _spine_abnormal = ["cervical", "thoracic", "lumbar", "sacral"];
const _limb = [
  "normal",
  "abrasion",
  "amputation above elbow",
  "burn",
  "crush",
  "deformity",
  "dislocation shoulder",
  "mangled",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness",
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
  "Sinus rhythm",
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

class _PatientTraumaState extends State<Trauma> with TickerProviderStateMixin {
  var checked = false;
  final Duration animationDuration = Duration(seconds: 5);
  double transitionIconSize = 16.0;

  Animation _checkAnimation;
  AnimationController _checkAnimationController;

  // TraumaProvider traumaProvider;

  // TraumaProvider traumaProvider;
  List<String> _listHead;

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: 'Head',
        icon: Icons.sync_problem,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Face',
        icon: Icons.accessibility,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Neck',
        icon: Icons.directions_walk,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Neck abnormality location',
        icon: Icons.accessible_forward,
        multiple: true,
        bodyModel: BodyModel(list: _neck_abnormal)),
    ItemModel(
        header: 'Back',
        icon: Icons.account_balance,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Back abnormality location',
        icon: Icons.add_to_photos,
        multiple: true,
        bodyModel: BodyModel(list: _back_abnormal)),
    ItemModel(
        header: 'Spine',
        icon: Icons.surround_sound,
        multiple: true,
        bodyModel: BodyModel(list: _spine)),
    ItemModel(
        header: 'Spine abnormality',
        icon: Icons.tag_faces,
        multiple: true,
        bodyModel: BodyModel(list: _spine_abnormal)),
    ItemModel(
        header: 'Rigth chest',
        icon: Icons.drag_handle,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Left chest',
        icon: Icons.dashboard,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Abdomen - right upper quadrant',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Abdomen - left upper quadrant',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Abdomen - right lower quadrant',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Abdomen - left lower quadrant',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Limb - right arm',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Limb - left arm',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Limb - right forearm',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Right hand',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Left hand',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Right femur',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Left femur',
        icon: Icons.accessible_forward,
        multiple: true,
        bodyModel: BodyModel(list: _abdomenAbnorm)),
    ItemModel(
        header: 'Right leg',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
    ItemModel(
        header: 'Left leg',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
    ItemModel(
        header: 'Right feet',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
    ItemModel(
        header: 'Left feet',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
  ];
// }
// }

  @override
  void initState() {
    // TraumaProvider
    // traumaProvider = Provider.of<TraumaProvider>(context);
    super.initState();

    _checkAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _checkAnimation = Tween(begin: 20.0, end: 25.0).animate(CurvedAnimation(
        curve: Curves.elasticInOut, parent: _checkAnimationController));
  }

  void callback(String header, List<String> selectedItems) {
    print(header);
    print(selectedItems);

    if (header == "Head") {
      setState(() {
        _listHead = selectedItems;
      });
    }

    // traumaProvider.traumaAssessment.head = selectedItems;
    //   setState(() {
    //     traumaProvider.prepareData.forEach((f) {
    //       if (f.header == header) {
    //         print(header);
    //         if (selectedItems.length != 0) {
    //           f.isChecked = true;
    //           _checkAnimationController.forward().orCancel;
    //           // transitionIconSize = 25.0;
    //         } else {
    //           f.isChecked = false;
    //         }
    //       }
    //     });
    //   });
  }

  TraumaBloc traumaBloc;

  @override
  void didChangeDependencies() {
    // traumaBloc = BlocProvider.of<TraumaBloc>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final traumaBloc = BlocProvider.of<TraumaBloc>(context);

    return BlocProvider(
        create: (context) => TraumaBloc(),
        // value: BlocProvider.of<TraumaBloc>(context),
        child: Scaffold(
            appBar: AppBar(
              //  textTheme: themeProvider.getThemeData,
              title: Text(
                'Trauma Assessment',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    traumaBloc.add(AddTrauma(
                        traumaAssessment: new TraumaAssessment(head: _head)));

                    Navigator.pop(context);
                  },
                )
              ],
            ),
            // body: Icon(Icons.toys),
            body: _buildBody(context)));
    // },
    // );

    // ));
  }

  _buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: prepareData.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCard(prepareData, index);
            }));
    //   },
    // );
  }

  _buildCard(prepareData, index) {
    return Card(
        child: ListTile(
      title: Padding(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(prepareData[index].header),
                _buildAnimatedBuilder(prepareData, index)
              ]),
          padding: EdgeInsets.symmetric(vertical: 10.0)),
      subtitle: SingleOption(
        header: prepareData[index].header,
        stateList: prepareData[index].bodyModel.list,
        callback: callback,
        multiple: prepareData[index].multiple,
      ),
    ));
  }

  _buildAnimatedBuilder(data, index) {
    return AnimatedBuilder(
        animation: _checkAnimationController,
        builder: (context, child) {
          return Center(
              child: Container(
                  // padding: EdgeInsets.all(10.0),
                  child: Center(
                      child: Icon(
                          data[index].isChecked
                              ? Icons.check_circle //,
                              : Icons.check_circle_outline,
                          color: data[index].isChecked
                              ? Colors.green
                              : Colors.grey,
                          size: data[index].isChecked
                              ? _checkAnimation.value
                              : 20.0))));
        });
  }
}

class ItemModel {
  bool isChecked;
  bool multiple;
  String header;
  BodyModel bodyModel;
  IconData icon;

  ItemModel(
      {this.isChecked: false,
      this.header,
      this.icon,
      this.bodyModel,
      this.multiple});
}

class BodyModel {
  List<String> list;
  IconData icon;
  // int quantity;

  BodyModel({this.list});
}
