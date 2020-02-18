import 'package:flutter/material.dart';

class adminlogging {
  
  List<String> logList = new List<String>();
  List<Widget> logLines = new List<Widget>();
  ValueNotifier<int> counter = ValueNotifier<int>(0);

  void log(String logLevel, String text) {
    // format the log
    var timeStamp = new DateTime.now();
    String levelLabel = "Debug";
    switch (logLevel) {
      case "Debug" : { levelLabel = "Debug"; } break;
      case "Info" : { levelLabel = "Info"; } break;
      case "Warning" : { levelLabel = "Warning"; } break;
      case "Error" : { levelLabel = "Error"; } break;
      default: { levelLabel = "Debug"; } break;
    }
    String logText = "${timeStamp} - ${levelLabel} - ${text}";
    print(logText);
    logList.add(logText);
    logLines.add(Text(
      logText,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.white
      ),
    ));
    counter.value += 1;
  }

}