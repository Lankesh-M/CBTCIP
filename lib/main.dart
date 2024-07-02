import 'package:flutter/material.dart';
import 'package:unit_converter/conversion_screen/currency.dart';
import 'package:unit_converter/conversion_screen/length.dart';
import 'package:unit_converter/conversion_screen/speed.dart';
import 'package:unit_converter/conversion_screen/temp.dart';
import 'package:unit_converter/conversion_screen/time.dart';
import 'package:unit_converter/conversion_screen/weight.dart';
import 'package:unit_converter/model/conversion.dart';

void main() {
  runApp(const UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UnitConverterHomePage(),
    );
  }
}

class UnitConverterHomePage extends StatelessWidget {
  UnitConverterHomePage({super.key});

  final List<Conversion> conversions = [
    Conversion(
        icon: const Icon(Icons.line_weight_sharp, size: 100), type: "Length"),
    Conversion(
        icon: const Icon(Icons.currency_exchange, size: 100), type: "Currency"),
    Conversion(
        icon: const Icon(Icons.monitor_weight, size: 100), type: "Weight"),
    Conversion(icon: const Icon(Icons.access_time, size: 100), type: "Time"),
    Conversion(icon: const Icon(Icons.speed, size: 100), type: "Speed"),
    Conversion(icon: const Icon(Icons.sunny, size: 100), type: "Temperature")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 1),
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Unit Converter',
          style: TextStyle(
              fontSize: 25, fontStyle: FontStyle.italic, color: Colors.white),
        )),
        backgroundColor: Color.fromARGB(255, 49, 9, 129),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: conversions.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (conversions[index].type == "Length") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LengthConversionScreen(),
                    ),
                  );
                } else if (conversions[index].type == "Weight") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeightConversionScreen(),
                    ),
                  );
                } else if (conversions[index].type == "Speed") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpeedConversionScreen(),
                    ),
                  );
                } else if (conversions[index].type == "Currency") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurrencyConversionScreen(),
                    ),
                  );
                } else if (conversions[index].type == "Time") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimeConversionScreen()),
                  );
                } else if (conversions[index].type == "Temperature") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TemperatureConversionScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ConversionScreen(type: conversions[index].type),
                    ),
                  );
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 49, 9, 129),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        conversions[index].icon,
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          conversions[index].type,
                          style: const TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(255, 0, 0, 1),
                          ),
                        )
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }
}

class ConversionScreen extends StatelessWidget {
  final String type;

  const ConversionScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type),
      ),
      body: Center(
        child: Text('Conversion logic for $type will go here.'),
      ),
    );
  }
}
