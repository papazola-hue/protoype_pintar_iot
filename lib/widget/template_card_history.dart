import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class TemplateCardHistoryWidget extends StatelessWidget {
  final String title;
  final Function fn;
  final String subtitle;
  final String date;
  const TemplateCardHistoryWidget({
    Key key,
    this.title,
    this.fn,
    this.subtitle,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                  onTap: fn,
                  title: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TemplateTextWidget(
                        title: title,
                      ),
                      TemplateTextWidget(
                        title: subtitle,
                      ),
                      TemplateTextWidget(
                        title: date,
                      ),
                    ],
                  )))),
    );
  }
}
