import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper{

  postWeather(String location) async  {
    Map<String, dynamic> parameters = {'q': location};
    Uri uri = Uri.parse("http://192.168.2.13:52309/mobapp");
    http.post(uri); //can only use await in async
  }
}