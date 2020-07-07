import 'package:bootcamp_feedback_app/ApiResponse.dart';
import 'package:flutter/material.dart';

class ExcelData extends StatelessWidget {
  final List<ApiResponse>feedbackItems;

  const ExcelData({Key key, this.feedbackItems}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("EXCEL DATA"),
      ),
      body: ListView.builder(
        itemCount: feedbackItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.person),
                Expanded(
                  child: Text(
                      "${feedbackItems[index].name} (${feedbackItems[index].email})"),
                )
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.message),
                Expanded(
                  child: Text(feedbackItems[index].feedback),
                )
              ],
            ),
          );
        },
      ),

    );
  }
}
