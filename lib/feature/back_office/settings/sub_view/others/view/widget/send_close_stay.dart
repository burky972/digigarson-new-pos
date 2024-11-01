import 'package:flutter/material.dart';

class SendCloseStay extends StatefulWidget {
  const SendCloseStay({super.key});

  @override
  State<SendCloseStay> createState() => _SendCloseStayState();
}

int? selectedDineInSend;
int? selectedTakeOutSend;
int? selectedPickUpSend;
int? selectedDeliverySend;
int? selectedSeatBarSend;
int? selectedNonSeatBarSend;
int? selectedQuickServiceSend;

class _SendCloseStayState extends State<SendCloseStay> {
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
                'After Send/Close Go Back Or Stay',
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
                    groupValue: selectedDineInSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInSend = value!;
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
                    groupValue: selectedDineInSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInSend = value!;
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
                    groupValue: selectedDineInSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInSend = value!;
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
                    groupValue: selectedTakeOutSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutSend = value!;
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
                    groupValue: selectedTakeOutSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutSend = value!;
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
                    groupValue: selectedTakeOutSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutSend = value!;
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
                    groupValue: selectedPickUpSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUpSend = value!;
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
                    groupValue: selectedPickUpSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUpSend = value!;
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
                    groupValue: selectedPickUpSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUpSend = value!;
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
                    groupValue: selectedDeliverySend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliverySend = value!;
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
                    groupValue: selectedDeliverySend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliverySend = value!;
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
                    groupValue: selectedDeliverySend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliverySend = value!;
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
                    groupValue: selectedSeatBarSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarSend = value!;
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
                    groupValue: selectedSeatBarSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarSend = value!;
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
                    groupValue: selectedSeatBarSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarSend = value!;
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
                    groupValue: selectedNonSeatBarSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarSend = value!;
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
                    groupValue: selectedNonSeatBarSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarSend = value!;
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
                    groupValue: selectedNonSeatBarSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarSend = value!;
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
                    groupValue: selectedQuickServiceSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServiceSend = value!;
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
                    groupValue: selectedQuickServiceSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServiceSend = value!;
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
                    groupValue: selectedQuickServiceSend,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServiceSend = value!;
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
