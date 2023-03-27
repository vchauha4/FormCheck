
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart';

import 'FeedBack.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  final int number;


  const VideoPage({Key? key, required this.filePath, required this.number}) : super(key: key);
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {


    //videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    videoPlayerController = VideoPlayerController.file(File("/storage/emulated/0/Android/data/com.example.gym_app/Files/bench.mp4"));

    await videoPlayerController.initialize();
    await videoPlayerController.setLooping(false);

    return await videoPlayerController.play();

  }
  _saveImageToGallery(String path) async {

    Directory path2 = await getApplicationDocumentsDirectory(); // to get directory path
    final fileName = basename(path); // will return you the name of your file like REC9113430186235591563.mp4

    // /storage/emulated/0/Android/data/com.example.gym_app/Videos/', currentPosition: time,),

    String pathToSave= '/storage/emulated/0/Android/data/com.example.gym_app/Files/';  //'/storage/emulated/0/AudioFiles/';

    File imageFile= File(path);
    imageFile.copySync('/storage/emulated/0/Android/data/com.example.gym_app/Files/$fileName');

    await GallerySaver.saveVideo(pathToSave+fileName);
    await imageFile.delete();//delete previousVid


    print("PATH SAVED TO::::::::::::::::::::::::::::"+path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,

        actions: [
          IconButton(

            icon: const Icon(Icons.check),
            onPressed: () {
              print("SAVING");
              _saveImageToGallery(widget.filePath);


              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedBack(number: widget.number, path: basename(widget.filePath),), //CameraPage(number: widget.number,),// make list take a parameter for the folder
                ),
              );


            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,

      body: FutureBuilder(

        future: _initVideoPlayer(),
        builder: (context, state) {

          if (state.connectionState == ConnectionState.waiting) {

            return const Center(child: CircularProgressIndicator());

          }
          else {

            return VideoPlayer(videoPlayerController);

          }
        },
      ),
    );
  }
}
