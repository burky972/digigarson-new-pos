part of '../view/option_group_view.dart';

mixin _OptionGroupsMixin on State<OptionGroupsView> {
  int? selectedOptionIndex = 0;

  List<Map<String, String>> selectedOptionData = [
    {
      'groupName': 'Eggs Style Options 1',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options 2 ',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options 3 ',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options 4 ',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options 5 ',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options 6',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options 77',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': '8888 Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': '99 Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': '10 Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': '11 Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
    {
      'groupName': 'Eggs Style Options',
      'groupDescription': 'Description of fjds dfjsl Eggs Style Options',
    },
  ];
  late TextEditingController _groupNameController;
  late TextEditingController _groupDescController;
  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController(
        text: selectedOptionData[selectedOptionIndex ?? 0]['groupName'] ?? '');
    _groupDescController = TextEditingController(
        text: selectedOptionData[selectedOptionIndex ?? 0]['groupDescription'] ?? '');
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupDescController.dispose();
    super.dispose();
  }

  void onSelectedTapped(index) {
    setState(() {
      if (selectedOptionIndex == index) {
        return;
      } else {
        selectedOptionIndex = index;
        setTextFieldControllerText(index);
      }
    });
  }

  void setTextFieldControllerText(int index) {
    _groupNameController.text = selectedOptionData[index]['groupName'] ?? '';
    _groupDescController.text = selectedOptionData[index]['groupDescription'] ?? '';
  }
}
