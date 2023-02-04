
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'VideoPage.dart';

class CameraPage extends StatefulWidget {
  final int number;

  const CameraPage({Key? key, required this.number}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  bool isLoading = true;
  bool isRecording = false;
  late CameraController cameraController;


  @override
  void initState() {
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void initCamera() async{

    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    cameraController = CameraController(front, ResolutionPreset.max);
    await cameraController.initialize();
    setState(() => isLoading = false);


  }

  recordVideo() async {

    //So rn we saving in 2 spots

    if (isRecording) {
      final file = await cameraController.stopVideoRecording();
      setState(() => isRecording = false);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPage(filePath: file.path, number: widget.number,),// make list take a parameter for the folder
        ),
      );



    }
    else {

      await cameraController.prepareForVideoRecording();
      await cameraController.startVideoRecording();

      setState(() => isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(

        color: Colors.white,
        child: const Center(

          child: CircularProgressIndicator(),

        )

      );
    }
    else {
      return Center(

        child: Stack(

          alignment: Alignment.bottomCenter,

          children: [

            CameraPreview(cameraController),
            Padding(
              padding: const EdgeInsets.all(25),

              child: FloatingActionButton(


                backgroundColor: Colors.red[850],
                child: Icon(isRecording ? Icons.stop : Icons.circle),

                onPressed: () => recordVideo(),

              ),


            ),
          ],
        ),
      );

    }

  }

}
