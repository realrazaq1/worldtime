import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  var location; //location name for the UI
  var time; //time in that location
  var flag; //url to to an asset flag icon
  var url; //location url for API endpoint
  var isDayTime; //true or false if daytime or not

  //create the constructor

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make the request
      var response = await get('http://worldtimeapi.org/api/timezone/$url');
      var data = jsonDecode(response.body);

      //get properties from data
      var datetime = data['datetime'];
      var offset = data['utc_offset'].substring(1, 3);

      //create a DateTime object
      var now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
