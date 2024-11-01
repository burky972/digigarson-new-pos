import 'package:flutter/material.dart';

class PrintReceiptStay extends StatefulWidget {
  const PrintReceiptStay({super.key});

  @override
  State<PrintReceiptStay> createState() => _PrintReceiptStayState();
}

int? selectedDineInPrint;
int? selectedTakeOutPrint;
int? selectedPickUpPrint;
int? selectedDeliveryPrint;
int? selectedSeatBarPrint;
int? selectedNonSeatBarPrint;
int? selectedQuickServicePrint;

class _PrintReceiptStayState extends State<PrintReceiptStay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Flexible(
          child: Column(
        children: [
          const Row(
            children: [
              Text(
                'After Print Receipt Go Back Or Stay',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
              Expanded(
                  child: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
              )),
              Expanded(
                  child: Text(
                'Layout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
              )),
              Expanded(
                  child: Text(
                'Stay',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
              )),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'DineIn',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedDineInPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedDineInPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 3,
                    groupValue: selectedDineInPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Take Out',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedTakeOutPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedTakeOutPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 3,
                    groupValue: selectedTakeOutPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Pick Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedPickUpPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUpPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedPickUpPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUpPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 3,
                    groupValue: selectedPickUpPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUpPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Delivery',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedDeliveryPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliveryPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedDeliveryPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliveryPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 3,
                    groupValue: selectedDeliveryPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliveryPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Seat Bar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedSeatBarPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedSeatBarPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 3,
                    groupValue: selectedSeatBarPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Non-Seat Bar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedNonSeatBarPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedNonSeatBarPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 3,
                    groupValue: selectedNonSeatBarPrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarPrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Quick Service',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedQuickServicePrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServicePrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedQuickServicePrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServicePrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Radio<int>(
                    value: 3,
                    groupValue: selectedQuickServicePrint,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServicePrint = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.all(Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
