import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Celsius to Fahrenheit converter and vice versa
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ConvertApp(),
    );
  }
}

class ConvertApp extends StatefulWidget {
  @override
  _ConvertAppState createState() => _ConvertAppState();
}

class _ConvertAppState extends State<ConvertApp> {
  double input = 0;
  double output = 0;
  bool isCelsius = true;
  final TextEditingController _outputController = TextEditingController();
  
  // History (store all conversions)
  List<String> history = [];

  void _convert() {
    setState(() {
      if (isCelsius) {
        output = (input * 9 / 5) + 32; // Celsius to Fahrenheit
      } else {
        output = (input - 32) * 5 / 9; // Fahrenheit to Celsius
      }
      
      // Update the output
      _outputController.text = output.toStringAsFixed(2);
      
      // Add conversion to history
      String conversion = isCelsius
          ? "$input °C = ${output.toStringAsFixed(2)} °F"
          : "$input °F = ${output.toStringAsFixed(2)} °C";
      history.add(conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Container(
        color: Colors.lightBlueAccent, // background color
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    input = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: InputDecoration(
                  labelText: isCelsius ? 'Celsius' : 'Fahrenheit',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convert,
                child: Text('Convert to ${isCelsius ? 'Fahrenheit' : 'Celsius'}'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _outputController,
                decoration: InputDecoration(
                  labelText: isCelsius ? 'Fahrenheit' : 'Celsius',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isCelsius = !isCelsius;
                  });
                },
                child: Text('Switch to ${isCelsius ? 'Fahrenheit' : 'Celsius'}'),
              ),
              const SizedBox(height: 20),
              // Display the conversion history
              Expanded(
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(history[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

