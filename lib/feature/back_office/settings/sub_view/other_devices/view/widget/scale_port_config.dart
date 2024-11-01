import 'package:a_pos_flutter/product/extension/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ScalePortConfig extends StatefulWidget {
  const ScalePortConfig({super.key});

  @override
  State<ScalePortConfig> createState() => _ScalePortConfigState();
}

String? selectedValue;
String? selectedValue2;
String? selectedValue3;
String? selectedValue4;
String? selectedValue5;
String? selectedValue6;
List<String> listscaleport = <String>[
  'HOT',
  'TEST',
  'KITCHEN',
  'Receipt',
];
List<String> listScaleType = <String>[
  'CAS',
];
List<String> listPort = <String>[
  'COM1',
  'COM2',
  'COM3',
  'COM4',
  'COM5',
  'COM6',
];
List<String> listBaudRate = <String>[
  '100',
  '300',
  '600',
  '1200',
  '2400',
  '4800',
  '9600',
  '14400',
  '19200',
  '38400',
  '56000',
  '57600',
  '115200',
  '128000',
  '256000',
];
List<String> listDataBits = <String>[
  '5',
  '6',
  '7',
  '8',
];
List<String> listParity = <String>[
  'None',
  'Odd',
  'Even',
  'Mark',
  'Space',
];
List<String> listStopBits = <String>[
  'None',
  'One',
  'Two',
  'OnePointFive',
];
List<String> listHandShake= <String>[
  'None',
  'XOnXOff',
  'RequestToSend',
  'RequestToSendXOnXOff',
];


class _ScalePortConfigState extends State<ScalePortConfig> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Flexible(
            flex: 6,
            child: Text(
              "Scale Port Configuration",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            flex: 4,
            child: Row(
              children: [
                const Flexible(flex: 2, child: Text('Scale Type')),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue2,
                    isExpanded: true,
                    items: listscaleport
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue2 = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: context.dynamicWidth(0.02)),
                const Flexible(flex: 2, child: Text('Port')),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue2,
                    isExpanded: true,
                    items: listscaleport
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue2 = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: context.dynamicWidth(0.02)),
                const Flexible(flex: 2, child: Text('Baud Rate')),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue2,
                    isExpanded: true,
                    items: listscaleport
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue2 = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: context.dynamicWidth(0.02)),
                const Flexible(flex: 2, child: Text('Data Bits')),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue2,
                    isExpanded: true,
                    items: listscaleport
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue2 = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Flexible(
            flex: 4,
            child: Row(
              children: [
                const Flexible(flex: 2, child: Text('Parity')),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue2,
                    isExpanded: true,
                    items: listscaleport
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue2 = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: context.dynamicWidth(0.02)),
                const Flexible(flex: 2, child: Text('Stop Bits')),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue2,
                    isExpanded: true,
                    items: listscaleport
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue2 = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: context.dynamicWidth(0.02)),
                const Flexible(flex: 2, child: Text('Handshake')),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: const Text(''),
                    value: selectedValue2,
                    isExpanded: true,
                    items: listscaleport
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue2 = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Flexible(
            flex: 4,
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const Text('Weight  Retrieving Code'),
                const SizedBox(width: 8),
                SizedBox(width: context.dynamicWidth(0.05), child: const TextField()),
                SizedBox(width: context.dynamicWidth(0.02)),
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const Text('Integrate Scale Witg System'),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
