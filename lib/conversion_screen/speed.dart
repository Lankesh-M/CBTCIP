import 'package:flutter/material.dart';

class SpeedConversionScreen extends StatefulWidget {
  @override
  _SpeedConversionScreenState createState() => _SpeedConversionScreenState();
}

class _SpeedConversionScreenState extends State<SpeedConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _inputUnit = 'Meters/Second';
  String _outputUnit = 'Kilometers/Hour';
  String _result = '';
  int _selectedIndex = 0;

  final List<String> units = [
    'Meters/Second',
    'Kilometers/Hour',
    'Miles/Hour',
    'Feet/Second'
  ];

  final Map<String, double> conversionRates = {
    'Meters/Second': 1.0,
    'Kilometers/Hour': 3.6,
    'Miles/Hour': 2.237,
    'Feet/Second': 3.281,
  };

  void _convert() {
    double input = double.parse(_inputController.text);
    double inputInMetersPerSecond = input / conversionRates[_inputUnit]!;
    double output = inputInMetersPerSecond * conversionRates[_outputUnit]!;
    setState(() {
      _result = '$input $_inputUnit = $output $_outputUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 3, 78),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 9, 129),
        title: const Text(
          'Speed Conversion',
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
                labelText: 'Enter value',
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
                    items: units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 13,
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
                    items: units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 13,
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
