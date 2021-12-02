import 'package:flutter/material.dart';
import 'package:yuwaku_proto/tutorial_page.dart';

class TutorialStepPage extends StatelessWidget {

  final PageData data;

  TutorialStepPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(240, 233, 208, 100),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  data.typeName['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(186, 66, 43, 100),
                    ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  height: 400,
                  image: AssetImage(data.typeName['imagePath']!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text( data.typeName['description']!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
