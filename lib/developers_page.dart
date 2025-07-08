import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DevelopersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/purple5.jpg'), // Replace with the path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Meet the Developers',
                  style: GoogleFonts.bebasNeue(
                  textStyle: TextStyle(fontSize: 32.0, color: Colors.white),),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/devs/nervin_malaluan.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Leader: Nervin C. Malaluan',
                style: TextStyle(fontSize: 20,
                color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/devs/john_paolo_panganiban.png'),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'John Paolo Panganiban',
                style: TextStyle(fontSize: 20.0,
                color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/devs/iris_heart_prado.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Iris Heart Prado',
                style: TextStyle(fontSize: 20.0,
                color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/devs/john_rick_cantos.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'John Rick Cantos',
                style: TextStyle(fontSize: 20.0,
                color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/devs/ansthrea_carange.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Ansthrea Carange',
                style: TextStyle(fontSize: 20.0,
                color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.0),
              Text(
                  'FROM BSCS-3C',
                  style: GoogleFonts.bebasNeue(
                  textStyle: TextStyle(fontSize: 32.0, color: Colors.white),),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50.0),
              
            ],
          ),
        ),
      ),
    );
  }
}
