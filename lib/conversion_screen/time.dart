import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  @override
  _TimeConversionScreenState createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _inputUnit = 'Days';
  String _outputUnit = 'Hours';
  String _result = '';
  int _selectedIndex = 0;

  final List<String> timeUnits = [
    'Seconds',
    'Minutes',
    'Hours',
    'Days',
    'Weeks',
    'Months',
    'Years',
    'Decades',
  ];

  final Map<String, double> timeConversionRates = {
    'Seconds': 1.0, // Base unit is Seconds
    'Minutes': 60.0, // 1 Minute = 60 Seconds
    'Hours': 3600.0, // 1 Hour = 3600 Seconds
    'Days': 86400.0, // 1 Day = 86400 Seconds
    'Weeks': 604800.0, // 1 Week = 604800 Seconds
    'Months': 2592000.0, // 1 Month = 2592000 Seconds (30 days)
    'Years': 31536000.0, // 1 Year = 31536000 Seconds (365 days)
    'Decades': 315360000.0, // 1 Decade = 315360000 Seconds (10 years)
  };

  void _convert() {
    try {
      double input = double.parse(_inputController.text);
      double inputInSeconds = input * timeConversionRates[_inputUnit]!;
      double output = inputInSeconds / timeConversionRates[_outputUnit]!;
      setState(() {
        _result =
            '${input.toStringAsFixed(2)} $_inputUnit = ${output.toStringAsFixed(2)} $_outputUnit';
      });
    } catch (e) {
      setState(() {
        _result = 'Please enter a valid number';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 3, 78),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 9, 129),
        title: const Text(
          'Time Conversion',
          style: TextStyle(
              fontSize: 25, fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter time',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton<String>(
                    value: _inputUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        _inputUnit = newValue!;
                      });
                      _convert();
                    },
                    items:
                        timeUnits.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Color.fromARGB(190, 195, 0, 255)),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.swap_horiz, size: 32),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = (_selectedIndex + 1) % 2;
                      String tempUnit = _inputUnit;
                      _inputUnit = _outputUnit;
                      _outputUnit = tempUnit;
                    });
                    _convert();
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: _outputUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        _outputUnit = newValue!;
                      });
                      _convert();
                    },
                    items:
                        timeUnits.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Color.fromARGB(190, 195, 0, 255)),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
