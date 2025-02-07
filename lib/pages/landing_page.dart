import 'package:flutter/material.dart';
import 'package:newser/pages/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(30),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("images/l.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('News from around the\n          world for you', style: TextStyle(color:Colors.black,
                fontSize: 26,fontWeight: FontWeight.bold
            ),
              ),
            SizedBox(height: 20.0,),
            Text('Best time to read, take your time to read\n              a little more of this world', style: TextStyle(color:Colors.black45,
                fontSize: 18,fontWeight: FontWeight.w500
            ),
            ),
            SizedBox(height: 40.0,),
            Container(
              width: MediaQuery.of(context).size.width/1.2,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 5.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0, ),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Get Started', style: TextStyle(
                      color: Colors.white,
                      fontSize: 17, fontWeight: FontWeight.w500,
                    ),
                    ),
                  ),
                ),
              ),
            ),

            ),
          ],
        ),
      ),
    );
  }
}
