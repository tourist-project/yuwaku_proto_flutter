import 'package:flutter/material.dart';

class TutorialStepPage extends StatelessWidget {

  final String title, description, imagePath;


  TutorialStepPage(this.title, this.description, this.imagePath);

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
                  title ,
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
                  image: AssetImage(imagePath),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(description),
              )
            ],
          ),
        ),
      ),
    );
  }
}
