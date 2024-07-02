import 'package:flutter/material.dart';

class WeightConversionScreen extends StatefulWidget {
  @override
  _WeightConversionScreenState createState() => _WeightConversionScreenState();
}

class _WeightConversionScreenState extends State<WeightConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _inputUnit = 'Grams';
  String _outputUnit = 'Kilograms';
  String _result = '';
  int _selectedIndex = 0;

  final List<String> units = ['Grams', 'Kilograms', 'Pounds', 'Ounces'];

  final Map<String, double> conversionRates = {
    'Grams': 1.0,
    'Kilograms': 1000.0,
    'Pounds': 453.592,
    'Ounces': 28.3495,
  };

  void _convert() {
    double input = double.parse(_inputController.text);
    double inputInGrams = input * conversionRates[_inputUnit]!;
    double output = inputInGrams / conversionRates[_outputUnit]!;
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
          'Weight Conversion',
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
                              color: Color.fromARGB(190, 195, 0, 255),
                            ),
                          ));
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
