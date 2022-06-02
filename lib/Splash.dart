import 'package:flutter/material.dart';
import 'package:notesapp/Empty_home.dart';

class launch_Screen extends StatefulWidget {
  const launch_Screen({Key? key}) : super(key: key);

  @override
  State<launch_Screen> createState() => _launch_ScreenState();
}

class _launch_ScreenState extends State<launch_Screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () async {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF9FCFF),
        body: Stack(children: [
          PageView(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'images/Ynote.PNG',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.7),
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width - 100,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => home_Screen()));
                },
                child: const Text('Get Started'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 19, 33, 224)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    )),
              ),
            ),
          )
        ]));
  }
}
