import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper{

  postWeather(String location) async  {
    Map<String, dynamic> parameters = {'q': location};
    Uri uri = Uri.parse("http://192.168.2.13:52309/password?uid=123456&password=1111");
    http.get(uri); //can only use await in async steven is a stupid pig. lhyyw
  }
}