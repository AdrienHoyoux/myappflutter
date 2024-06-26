import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myappflutter/widgets/map_component.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isCounting = false;
  int _secondsElapsed = 0;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 320,
              child: map_component(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildInfoCard('Distance', '0.0 KM'),
                _buildInfoCard('Temps', '${_secondsElapsed ~/ 60}:${_secondsElapsed % 60} min'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildInfoCard('Vitesse', '0.0 KM/H'),
                _buildInfoCard('Calories', '0.0 Kcal'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(height: 10),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_isCounting) {
                            _stopTimer();
                          } else {
                            _startTimer();
                          }
                          _isCounting = !_isCounting;
                        });
                      },
                      icon: Icon(_isCounting ? Icons.stop : Icons.play_arrow, size: 50, color: Colors.white),
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: _isCounting ? Colors.red : Colors.blue,
                      ),
                    ),
                    Text(_isCounting ? 'Arrêter' : 'Commencer', style: TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _secondsElapsed = 0;
                        });
                      },
                      icon: Icon(Icons.refresh, size: 50, color: Colors.white),
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.black54,
                      ),
                    ),
                    Text('Réinitialisé', style: TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 10),
                    IconButton(
                      onPressed: () {
                      },
                      icon: Icon(Icons.save, size: 50, color: Colors.white),
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    ),
                    Text('Sauvegarder', style: TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
