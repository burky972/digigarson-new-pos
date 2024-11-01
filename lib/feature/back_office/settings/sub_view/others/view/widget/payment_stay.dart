import 'package:flutter/material.dart';

class PaymentStay extends StatefulWidget {
  const PaymentStay({super.key});

  @override
  State<PaymentStay> createState() => _PaymentStayState();
}

int? selectedDineInPayment;
int? selectedTakeOutPayment;
int? selectedPickUptPayment;
int? selectedDeliveryPayment;
int? selectedSeatBarPayment;
int? selectedNonSeatBarPayment;
int? selectedQuickServicePayment;

class _PaymentStayState extends State<PaymentStay> {
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
                'After Payment Go Back Or Stay',
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
                    groupValue: selectedDineInPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInPayment = value!;
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
                    groupValue: selectedDineInPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInPayment = value!;
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
                    groupValue: selectedDineInPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDineInPayment = value!;
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
                    groupValue: selectedTakeOutPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutPayment = value!;
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
                    groupValue: selectedTakeOutPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutPayment = value!;
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
                    groupValue: selectedTakeOutPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTakeOutPayment = value!;
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
                    groupValue: selectedPickUptPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUptPayment = value!;
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
                    groupValue: selectedPickUptPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUptPayment = value!;
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
                    groupValue: selectedPickUptPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedPickUptPayment = value!;
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
                    groupValue: selectedDeliveryPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliveryPayment = value!;
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
                    groupValue: selectedDeliveryPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliveryPayment = value!;
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
                    groupValue: selectedDeliveryPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedDeliveryPayment = value!;
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
                    groupValue: selectedSeatBarPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarPayment = value!;
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
                    groupValue: selectedSeatBarPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarPayment = value!;
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
                    groupValue: selectedSeatBarPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedSeatBarPayment = value!;
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
                    groupValue: selectedNonSeatBarPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarPayment = value!;
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
                    groupValue: selectedNonSeatBarPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarPayment = value!;
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
                    groupValue: selectedNonSeatBarPayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNonSeatBarPayment = value!;
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
                    groupValue: selectedQuickServicePayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServicePayment = value!;
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
                    groupValue: selectedQuickServicePayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServicePayment = value!;
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
                    groupValue: selectedQuickServicePayment,
                    onChanged: (int? value) {
                      setState(() {
                        selectedQuickServicePayment = value!;
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
