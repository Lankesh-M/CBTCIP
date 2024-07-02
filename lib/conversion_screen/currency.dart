import 'package:flutter/material.dart';

class CurrencyConversionScreen extends StatefulWidget {
  @override
  _CurrencyConversionScreenState createState() =>
      _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _inputCurrency = 'USD';
  String _outputCurrency = 'IND';
  String _result = '';
  int _selectedIndex = 0;

  final List<String> currencies = [
    'USD',
    'EURO',
    'YEN',
    'Pound',
    'AUS',
    'CAD',
    'IND',
    'Dirham-Arab',
  ];

  final Map<String, double> conversionRates = {
    'USD': 1.0, // Base currency
    'IND': 83.43,
    'EURO': 0.93,
    'YEN': 147.28,
    'Pound': 0.77,
    'AUS': 1.61,
    'CAD': 1.37,
    'Dirham-Arab': 3.67, // United Arab Emirates Dirham (AED)
  };

  void _convert() {
    double input = double.parse(_inputController.text);
    double inputInUSD = input / conversionRates[_inputCurrency]!;
    double output = double.parse(
        (inputInUSD * conversionRates[_outputCurrency]!).toStringAsFixed(2));
    setState(() {
      _result = '$input $_inputCurrency = $output $_outputCurrency';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 3, 78),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 9, 129),
        title: const Text(
          'Currency Conversion',
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
                  labelText: 'Enter amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton<String>(
                    value: _inputCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _inputCurrency = newValue!;
                      });
                      _convert();
                    },
                    items: currencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Color.fromARGB(190, 195, 0, 255)),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_double_arrow_down),
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
                      String tempCurrency = _inputCurrency;
                      _inputCurrency = _outputCurrency;
                      _outputCurrency = tempCurrency;
                    });
                    _convert();
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: _outputCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _outputCurrency = newValue!;
                      });
                      _convert();
                    },
                    items: currencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Color.fromARGB(190, 195, 0, 255)),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_double_arrow_down),
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
              style: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
