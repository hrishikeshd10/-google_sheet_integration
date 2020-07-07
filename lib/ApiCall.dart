import 'dart:convert' as convert;
import 'package:bootcamp_feedback_app/ApiResponse.dart';
import 'package:http/http.dart' as http;


/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class ApiCall {

  // Google App Script Web URL.
  static const String URL =
"https://script.google.com/d/1af_P7XrSaKnG4NOobKP_r8IGkAxwIdaIF3mFUM0T0r8ibjc1K-SByBqn/edit?mid=ACjPJvHNZTIo6eeRzd6Kkhcuk4kV210DIAqOd2v6CBBdAwQkMhVW54uLXa88b23eRP8voZktmGg2jD0dAetr1KBy-O_MslRq-9g3AHy-Nx4DQyVygG6J4ECtsal_lsY2qKNGzDxSL38IVkc&uiv=2";
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      ApiResponse feedbackForm, void Function(String) callback) async {
    try {
      await http.post(URL, body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }



  Future<List<ApiResponse>> getFeedbackList() async {
    return await http.get("https://script.googleusercontent.com/macros/echo?user_content_key=Ut9Zt-IsfVbvT7FY8R4gs_GHib4eieUe9419KYYh5yBj6SYJpSFZvdYJE4m-5tPJKU5ikhaki99iVw2b7FySMi7V0Sas6bwLm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnGxGV3TXim5TuPNOVHzHwhk5R5flZdbIiSGEh7WvrBctpHLK3YPBBRLRBUS_O_az3mzJzoL0bsfS&lib=MZ3lFqjgccTXnuYznpxg8E1gVvnRlNeaU").then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => ApiResponse.fromJson(json)).toList();
    });
  }
}