import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Popsi Alarm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Popsi Alarm'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool show = false;
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
      Center(
          child: Column(children: <Widget>[
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(11)),
                  child: Center(
                    child: TextField(
                      controller: hourController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(11)),
                  child: Center(
                    child: TextField(
                      controller: minuteController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: TextButton(
                child: const Text(
                  'Create alarm',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  int hour;
                  int minutes;
                  hour = int.parse(hourController.text);
                  minutes = int.parse(minuteController.text);

                  // creating alarm after converting hour
                  // and minute into integer
                  FlutterAlarmClock.createAlarm(hour, minutes);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {

                // show alarm
                FlutterAlarmClock.showAlarms();
              },
              child: const Text(
                'Show Alarms',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: TextButton(
                  child: const Text(
                    'Create timer',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    int minutes;
                    minutes = int.parse(minuteController.text);

                    // create timer
                    FlutterAlarmClock.createTimer(minutes);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AboutDialog(
                            children: [
                              Center(
                                child: Text("Timer is set",
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold)),
                              )
                            ],
                          );
                        });
                  }),
            ),
            ElevatedButton(
              onPressed: () {

                // show timers
                FlutterAlarmClock.showTimers();
              },
              child: Text(
                "Show Timers",
                style: TextStyle(fontSize: 17),
              ),
            )
          ])),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'hye',
      //       ),
      //       Text(
      //         'Welcome!',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            if(show) {
              show = false;
            } else {
              show = true;
            }
          });
        },
        tooltip: 'Show/hide',
        child: show?const Icon(Icons.man_4_rounded):const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
