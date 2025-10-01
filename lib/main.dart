import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            side: const BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      ),
      home: const ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _controller = TextEditingController();

  String? sourceUnit = "Celsius";
  String? targetUnit = "Fahrenheit";
  String result = "";

  final List<String> units = ["Celsius", "Fahrenheit", "Kelvin"];

  double convert(double value, String from, String to) {
    double celsius;

    if (from == "Celsius") {
      celsius = value;
    } else if (from == "Fahrenheit") {
      celsius = (value - 32) * 5 / 9;
    } else {
      celsius = value - 273.15;
    }

    if (to == "Celsius") {
      return celsius;
    } else if (to == "Fahrenheit") {
      return (celsius * 9 / 5) + 32;
    } else {
      return celsius + 273.15;
    }
  }

  void _calculate() {
    final input = double.tryParse(_controller.text);
    if (input == null) {
      setState(() {
        result = "Introduceți o valoare validă!";
      });
      return;
    }

    final output = convert(input, sourceUnit!, targetUnit!);
    setState(() {
      result =
      "${input.toStringAsFixed(2)} $sourceUnit = ${output.toStringAsFixed(2)} $targetUnit";
    });
  }

  Widget buildRadioGroup(String title, String? groupValue,
      void Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            ...units.map((unit) => RadioListTile<String>(
              title: Text(unit, style: const TextStyle(color: Colors.white)),
              value: unit,
              groupValue: groupValue,
              activeColor: Colors.yellow,
              onChanged: onChanged,
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convertor temperatură"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Introduceți temperatura",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildRadioGroup("Unitate sursă", sourceUnit, (value) {
              setState(() => sourceUnit = value);
            }),
            const SizedBox(height: 10),
            buildRadioGroup("Unitate destinație", targetUnit, (value) {
              setState(() => targetUnit = value);
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text("Convertiți"),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}


