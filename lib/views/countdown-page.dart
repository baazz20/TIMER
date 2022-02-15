import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/round-button.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  // objet de controller d'animation
  late AnimationController controller;

  bool isPlaying = false;

  String get CountText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inHours)}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inHours)}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;
  void notify() {
    // Notification sonore après le niniteur
    if (CountText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  void initState() {
    // methode d'etat d'unité qui permet d'ajouter des valeurs au controlleur d'animation
    super.initState();
    controller = AnimationController(
      vsync: this,
      // 0 seconde est la duree au demarage du minuteur
      duration: Duration(seconds: 0),
    );
    controller.addListener(() {
      // notification sonnore a la fin du temps programmé
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/logooda.jpeg',
                    width: 70.0,
                    height: 70.0,
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/odc.png',
                    width: 70.0,
                    height: 70.0,
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    width: 300,
                    height: 300,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade300,
                      color: isPlaying == false
                          ? Colors.grey.shade300
                          : Color.fromARGB(255, 255, 115, 0),
                      value: progress,
                      strokeWidth: 12,
                    )),
                GestureDetector(
                  onTap: () {
                    if (isPlaying == false) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 300,
                          child: CupertinoTimerPicker(
                              initialTimerDuration: controller.duration!,
                              onTimerDurationChanged: (time) {
                                setState(() {
                                  controller.duration = time;
                                });
                              }),
                        ),
                      );
                    }
                  },
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      CountText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                    couleur: Colors.orange,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      controller.reset();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                    child: RoundButton(icon: Icons.stop, couleur: Colors.red)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                Text(
                  "by Yao Eloge",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
