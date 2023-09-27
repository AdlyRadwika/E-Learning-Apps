import 'package:final_project/common/services/face_detector_service.dart';
import 'package:final_project/common/services/ml_service.dart';
import 'package:final_project/features/presentation/pages/face_recognition/db/database_helper.dart';
import 'package:final_project/features/presentation/pages/face_recognition/face_recognitionv2_page.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  static const route = '/index';

  const IndexPage({Key? key}) : super(key: key);
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final MLService _mlService = locator<MLService>();
  final FaceDetectorService _mlKitService = locator<FaceDetectorService>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  _initializeServices() async {
    setState(() => loading = true);
    await _mlService.initialize();
    _mlKitService.initialize();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: PopupMenuButton<String>(
              child: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'Clear DB':
                    DatabaseHelper dataBaseHelper = DatabaseHelper.instance;
                    dataBaseHelper.deleteAll();
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Clear DB'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: !loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Column(
                      children: [
                        Text(
                          "FACE RECOGNITION AUTHENTICATION",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Demo application that uses Flutter and tensorflow to implement authentication with facial recognition",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () => Navigator.pushNamed(
                                  context, FaceRecognitionV2Page.route,
                                  arguments: {
                                    "isLogin": true,
                                  }),
                          child: const Text('Login')),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, FaceRecognitionV2Page.route,
                              arguments: {
                                "isLogin": false,
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF0F0BDB),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.1),
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SIGN UP',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.person_add, color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Divider(
                          thickness: 2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
