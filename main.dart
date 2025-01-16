import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  String _operator = "";
  double? _firstOperand;

  void _handleButtonPress(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _currentInput = "";
        _operator = "";
        _firstOperand = null;
      } else if (value == "+" || value == "-" || value == "×" || value == "÷") {
        if (_currentInput.isNotEmpty) {
          _firstOperand = double.tryParse(_currentInput);
          _operator = value;
          _currentInput = "";
        }
      } else if (value == "=") {
        if (_currentInput.isNotEmpty && _firstOperand != null) {
          double secondOperand = double.tryParse(_currentInput) ?? 0.0;
          switch (_operator) {
            case "+":
              _output = (_firstOperand! + secondOperand).toString();
              break;
            case "-":
              _output = (_firstOperand! - secondOperand).toString();
              break;
            case "×":
              _output = (_firstOperand! * secondOperand).toString();
              break;
            case "÷":
              _output = (_firstOperand! / secondOperand).toString();
              break;
          }
          _currentInput = _output;
          _firstOperand = null;
          _operator = "";
        }
      } else {
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _handleButtonPress(label),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: Text(
                _output,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("÷"),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("×"),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: [
                  _buildButton("C"),
                  _buildButton("0"),
                  _buildButton("="),
                  _buildButton("+"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
