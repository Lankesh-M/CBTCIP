import 'package:flutter/material.dart';

class TemperatureConversionScreen extends StatefulWidget {
  @override
  _TemperatureConversionScreenState createState() =>
      _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState
    extends State<TemperatureConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _inputUnit = 'Celsius';
  String _outputUnit = 'Fahrenheit';
  String _result = '';
  int _selectedIndex = 0;

  final List<String> temperatureUnits = [
    'Celsius',
    'Fahrenheit',
    'Kelvin',
  ];

  void _convert() {
    try {
      double input = double.parse(_inputController.text);
      double celsius;

      // Convert input to Celsius
      if (_inputUnit == 'Celsius') {
        celsius = input;
      } else if (_inputUnit == 'Fahrenheit') {
        celsius = (input - 32) * 5 / 9;
      } else if (_inputUnit == 'Kelvin') {
        celsius = input - 273.15;
      } else {
        throw Exception('Invalid input unit');
      }

      // Convert Celsius to output unit
      double output;
      if (_outputUnit == 'Celsius') {
        output = celsius;
      } else if (_outputUnit == 'Fahrenheit') {
        output = celsius * 9 / 5 + 32;
      } else if (_outputUnit == 'Kelvin') {
        output = celsius + 273.15;
      } else {
        throw Exception('Invalid output unit');
      }

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
          'Temperature Conversion',
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
                labelText: 'Enter temperature',
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
                    items: temperatureUnits
                        .map<DropdownMenuItem<String>>((String value) {
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
                    items: temperatureUnits
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color.fromARGB(190, 195, 0, 255),
                          ),
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
