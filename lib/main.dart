import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bidhan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Set this to false to remove the debug banner
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _currentNumber = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operand = '';

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = '0';
      _currentNumber = '';
      _num1 = 0;
      _num2 = 0;
      _operand = '';
    } else if (buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '/') {
      if (_operand.isNotEmpty) {
        _num2 = double.parse(_currentNumber);
        switch (_operand) {
          case '+':
            _output = (_num1 + _num2).toString();
            break;
          case '-':
            _output = (_num1 - _num2).toString();
            break;
          case 'x':
            _output = (_num1 * _num2).toString();
            break;
          case '/':
            _output = (_num1 / _num2).toString();
            break;
          default:
            break;
        }
        _num1 = double.parse(_output);
      } else {
        _num1 = double.parse(_currentNumber);
      }
      _operand = buttonText;
      _currentNumber = '';
    } else if (buttonText == '.') {
      if (!_currentNumber.contains('.')) {
        _currentNumber += '.';
      }
    } else if (buttonText == '=') {
      if (_operand.isNotEmpty && _currentNumber.isNotEmpty) {
        _num2 = double.parse(_currentNumber);
        switch (_operand) {
          case '+':
            _output = (_num1 + _num2).toString();
            break;
          case '-':
            _output = (_num1 - _num2).toString();
            break;
          case 'x':
            _output = (_num1 * _num2).toString();
            break;
          case '/':
            _output = (_num1 / _num2).toString();
            break;
          default:
            break;
        }
        _operand = '';
        _currentNumber = '';
        _num1 = 0;
        _num2 = 0;
      }
    } else {
      _currentNumber += buttonText;
    }

    setState(() {
      _output = _currentNumber.isNotEmpty ? _currentNumber : _output;
    });
  }

  Widget _buildButton(String buttonText, {Color? buttonColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor ?? Colors.blueGrey),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20.0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bidhan Calculator'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/', buttonColor: Colors.blueGrey),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('x', buttonColor: Colors.blueGrey),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-', buttonColor: Colors.blueGrey),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('.', buttonColor: Colors.blueGrey),
                    _buildButton('0'),
                    _buildButton('00'),
                    _buildButton('+', buttonColor: Colors.blueGrey),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('C', buttonColor: Colors.red),
                    _buildButton('=', buttonColor: Colors.blue),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
