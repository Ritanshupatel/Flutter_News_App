import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newser/models/slider_model.dart';

class SliderService {
  List<SliderModel> slider = [];

  Future<void> getSlider() async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=ea059ca5b0f2462e848ba65cec407414';
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          SliderModel sliderModel = SliderModel(
            title: element['title'],
            descrption: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          slider.add(sliderModel);
        }
      });
    }
  }
}
