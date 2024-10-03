import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/i_option_cubit.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/cubit/option_state.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/model/option_model.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/service/i_option_service.dart';
import 'package:a_pos_flutter/feature/back_office/menu/sub_view/option/service/option_service.dart';
import 'package:a_pos_flutter/product/global/getters/getter.dart';
import 'package:flutter/widgets.dart';

class OptionCubit extends IOptionCubit {
  OptionCubit() : super(OptionState.initial());

  final IOptionService _optionService = OptionService();
  final TextEditingController optionNameController = TextEditingController();
  final TextEditingController optionDescController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemLPriceController = TextEditingController();
  final TextEditingController itemHPriceController = TextEditingController();
  final TextEditingController itemDPriceController = TextEditingController();
  final TextEditingController itemTPriceController = TextEditingController();
  final TextEditingController itemTaxController = TextEditingController();
  List<OptionModel?> originalOptionList = [];
  List<Item?> originalItemList = [];
  Map<String, List<Item>> optionItemsMap = {};
  List<Item> deletedItems = []; // List to store deleted items

  /// init
  @override
  void init() {
    appLogger.info('OPTION CUBIT', 'INITIALIZED!!');
    getOptions();
  }

  /// option
  @override
  OptionModel? get option => state.option;

  /// SET SELECTED Option
  @override
  void setSelectedOption(OptionModel option) {
    optionNameController.text = option.name ?? '';
    optionDescController.text = option.specialName.toString();

    if (option.items != null && option.items!.isNotEmpty) {
      itemNameController.text = option.items!.first.itemName ?? '';
      itemPriceController.text = option.items!.first.price?.toString() ?? '0.0';
      itemLPriceController.text = option.items!.first.lunchPrice?.toString() ?? '0.0';
      itemHPriceController.text = option.items!.first.happyHourPrice?.toString() ?? '0.0';
      itemDPriceController.text = option.items!.first.deliveryPrice?.toString() ?? '0.0';
      itemTPriceController.text = option.items!.first.takeOutPrice?.toString() ?? '0.0';
      itemTaxController.text = option.items!.first.vatRate?.toString() ?? '0.0';

      setSelectedItem(option.items!.first);
    } else {
      itemNameController.text = '';
      itemPriceController.text = '0.0';
      itemLPriceController.text = '0.0';
      itemHPriceController.text = '0.0';
      itemDPriceController.text = '0.0';
      itemTPriceController.text = '0.0';
      itemTaxController.text = '0.0';
    }

    emit(state.copyWith(selectedOption: option));
  }

  /// set selected item
  @override
  setSelectedItem(Item item) {
    itemNameController.text = item.itemName ?? '';
    itemPriceController.text = item.price.toString();
    itemLPriceController.text = item.lunchPrice.toString();
    itemHPriceController.text = item.happyHourPrice.toString();
    itemDPriceController.text = item.deliveryPrice.toString();
    itemTPriceController.text = item.takeOutPrice.toString();
    itemTaxController.text = item.vatRate.toString();

    emit(state.copyWith(selectedItem: item));
  }

  /// add new item to selected Option's ITEM LIST
  @override
  Future<void> addNewItem() async {
    if (state.selectedOption == null) return;
    final items = state.selectedOption?.items;
    if (items != null && items.isNotEmpty) {
      final lastItem = items.last;

      // Check if the last item has a name and other necessary fields filled
      if (lastItem.itemName == null ||
          lastItem.itemName!.isEmpty ||
          lastItem.price == null ||
          (lastItem.itemName?.length ?? 0) <= 1) {
        return; // Do not add a new item
      }
    }

    // Create a new item with a unique ID
    final newItem = Item.empty().copyWith(id: () => generateUniqueId());
    final updatedItems = List<Item>.from(state.selectedOption!.items!)..add(newItem);

    final updatedOption = state.selectedOption!.copyWith(items: updatedItems);
    setSelectedItem(updatedItems.last);

    emit(state.copyWith(
      selectedOption: updatedOption,
      allOptions: state.allOptions.map((option) {
        if (option?.id == updatedOption.id) {
          return updatedOption;
        }
        return option;
      }).toList(),
    ));
  }

  /// Update any item value from the ITEM list
  @override
  void updateSelectedItemValue(UpdatedItemValue updatedItemValue, String? value) {
    if (state.selectedOption == null || state.selectedOption!.items == null) return;
    final items = state.selectedOption!.items!;
    final itemIndex = items.indexWhere((item) => item.id == state.selectedItem?.id);
    if (itemIndex == -1) return;

    Item updatedItem = items[itemIndex];
    updatedItem = _switchCase(updatedItemValue, updatedItem, items, itemIndex, value);

    final updatedItems = List<Item>.from(items)..[itemIndex] = updatedItem;
    final updatedOption = state.selectedOption!.copyWith(items: updatedItems);

    emit(state.copyWith(
      selectedOption: updatedOption,
      allOptions: state.allOptions.map((option) {
        if (option?.id == updatedOption.id) {
          return updatedOption;
        }
        return option;
      }).toList(),
      selectedItem: updatedItem,
    ));
  }

  @override
  String generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Switch case for updating item values
  Item _switchCase(UpdatedItemValue updatedItemValue, Item updatedItem, List<Item> items,
      int itemIndex, String? value) {
    switch (updatedItemValue) {
      case UpdatedItemValue.itemName:
        updatedItem = items[itemIndex].copyWith(
          itemName: value ?? items[itemIndex].itemName,
        );
        break;
      case UpdatedItemValue.itemPrice:
        updatedItem = items[itemIndex].copyWith(
          price: double.tryParse(value ?? items[itemIndex].price.toString()),
        );
        break;
      case UpdatedItemValue.itemLPrice:
        updatedItem = items[itemIndex].copyWith(
          lunchPrice: double.tryParse(value ?? items[itemIndex].lunchPrice.toString()),
        );
        break;
      case UpdatedItemValue.itemHPrice:
        updatedItem = items[itemIndex].copyWith(
          happyHourPrice: double.tryParse(value ?? items[itemIndex].happyHourPrice.toString()),
        );
        break;
      case UpdatedItemValue.itemDPrice:
        updatedItem = items[itemIndex].copyWith(
          deliveryPrice: double.tryParse(value ?? items[itemIndex].deliveryPrice.toString()),
        );
        break;
      case UpdatedItemValue.itemTPrice:
        updatedItem = items[itemIndex].copyWith(
          takeOutPrice: double.tryParse(value ?? items[itemIndex].takeOutPrice.toString()),
        );
        break;
      case UpdatedItemValue.vatRate:
        updatedItem = items[itemIndex].copyWith(
          vatRate: (double.tryParse(value ?? items[itemIndex].vatRate.toString()) ??
                  items[itemIndex].vatRate)
              ?.toInt(),
        );
        break;
      default:
    }
    return updatedItem;
  }

  /// Update option name or description
  @override
  void updateOptionNameOrDesc(String value, {bool isName = false}) {
    if (state.selectedOption == null) return;
    final index = state.allOptions.indexWhere((option) => option?.id == state.selectedOption?.id);
    if (index != -1) {
      final updatedOptions = List<OptionModel?>.from(state.allOptions);
      if (isName) {
        final updatedOption = state.selectedOption?.copyWith(name: value);
        updatedOptions[index] = updatedOption;
        emit(state.copyWith(allOptions: updatedOptions, selectedOption: updatedOption));
      } else {
        final updatedOption = state.selectedOption?.copyWith(specialName: value);
        updatedOptions[index] = updatedOption;
        emit(state.copyWith(allOptions: updatedOptions, selectedOption: updatedOption));
      }
    }
  }

  /// add new option to table list
  @override
  Future<void> addNewOption() async {
    // If there is a selected option or the title of the last option is empty, do not perform the operation.
    if (state.allOptions.isNotEmpty &&
        (state.allOptions.last?.name == null ||
            state.allOptions.last!.name!.isEmpty ||
            state.selectedOption == null)) {
      return;
    }

    // Clear text controllers
    optionNameController.clear();
    optionDescController.clear();

    // Create a new option with a unique ID
    final newOption = OptionModel(
        id: generateUniqueId(), // Generate a unique ID
        name: '',
        specialName: ' ',
        chooseLimit: 0,
        state: 1,
        items: const []);

    // Add the new option to the list
    final updatedOptions = List<OptionModel>.from(state.allOptions)..add(newOption);

    emit(state.copyWith(
      allOptions: updatedOptions,
      selectedOption: newOption,
    ));
  }

  /// SAVE CHANGES AND REQUEST TO POST OPTION SERVICE
  @override
  Future<void> saveChanges() async {
    final originalIds = originalOptionList.map((option) => option?.id).toSet();
    final updatedOptions = state.allOptions;
    final newOptions = updatedOptions.where((option) => !originalIds.contains(option?.id)).toList();

    // If there is a new option, send a POST request
    for (var option in newOptions) {
      await postOptions(optionModel: option!);
    }

    // If there is a change in the existing options, send a PUT request
    for (var updatedOption in updatedOptions) {
      // Skip the newly created options since they've already been posted
      if (newOptions.contains(updatedOption)) continue;

      final originalOption = originalOptionList.firstWhere(
        (option) => option?.id == updatedOption?.id,
        orElse: () => OptionModel.empty(),
      );

      if (originalOption != null && originalOption != updatedOption) {
        await putOptions(optionModel: updatedOption!, optionId: updatedOption.id!);
      }
    }
  }

  /// Calling this func when user click on delete button!
  void handleItemDeletion(Item itemToDelete) {
    final updatedOptions = state.allOptions.map((option) {
      if (option?.items != null) {
        final updatedItems = option!.items!.where((item) => item.id != itemToDelete.id).toList();
        return option.copyWith(items: updatedItems);
      }
      return option;
    }).toList();

    // Add the deleted item to the deletedItems list
    final updatedDeletedItems = List<Item>.from(deletedItems)..add(itemToDelete);
    deletedItems = updatedDeletedItems;
    for (var deletedItem in deletedItems) {
      appLogger.warning('DELETED ITEM: ', deletedItem.toJson().toString());
    }
    emit(state.copyWith(
      allOptions: updatedOptions,
      selectedOption: state.selectedOption?.copyWith(
        items: state.selectedOption?.items?.where((item) => item.id != itemToDelete.id).toList(),
      ),
      selectedItem: state.selectedOption?.items?.isNotEmpty == true
          ? state.selectedOption!.items!.first
          : null,
    ));
  }

  /// SAVE CHANGES AND REQUEST TO Put OPTION SERVICE for update items!
  @override
  Future<void> saveItemChanges() async {
    final itemsToUpdate = <Item>[];
    List<Item?> stateItems = [];

    for (var option in state.allOptions) {
      if (option?.items != null) {
        stateItems.addAll(option!.items!);
      }
    }

    for (var item in stateItems) {
      final originalItem = originalItemList.firstWhere(
        (original) => original?.id == item?.id,
        orElse: () => null,
      );

      if (originalItem == null || !item!.equals(originalItem)) {
        itemsToUpdate.add(item!);
      }
    }

    if (itemsToUpdate.isNotEmpty) {
      for (var item in itemsToUpdate) {
        final option = state.allOptions.firstWhere(
          (opt) => opt?.items?.any((i) => i.id == item.id) ?? false,
          orElse: () => null,
        );

        if (option != null) {
          final optionId = option.id;
          final updatedItems = option.items!.map((i) {
            if (i.id == item.id) {
              return i.copyWith(id: () => null);
            }
            return i.copyWith(id: () => null);
          }).toList(); //13
          final updatedOption = option.copyWith(items: updatedItems);
          appLogger.info('saveItemChanges', 'UPDATED ITEM: ${updatedOption.toJson().toString()}');
          for (var element in updatedOption.items ?? []) {
            appLogger.info('saveItemChanges', 'UPDATED ITEM: ${element.toJson().toString()}');
          }
          await putOptions(optionId: optionId!, optionModel: updatedOption);
        }
      }
    }

    // send put request for deleted items
    for (var deletedItem in deletedItems) {
      appLogger.info('saveItemChanges', 'DELETED ITEM: ${deletedItem.toJson().toString()}');

      // updatedOptions içindeki option'ları kontrol etmek yerine, deletedItem'in orijinal item'ını bulmaya çalışıyoruz
      final originalOption = originalOptionList.firstWhere(
        (opt) => opt?.items?.any((i) => i.id == deletedItem.id) ?? false,
        orElse: () => OptionModel.empty(),
      );

      if (originalOption != null) {
        final optionId = originalOption.id;
        final updatedOption = originalOption.copyWith(
          items: originalOption.items!.where((i) => i.id != deletedItem.id).toList(),
        );

        await putOptions(optionModel: updatedOption, optionId: optionId!);
        deletedItems = [];
      } else {
        appLogger.error('saveItemChanges', 'Original option not found for deleted item.');
      }
    }
  }

  /// getOptions
  @override
  Future getOptions() async {
    final response = await _optionService.getOptions();
    response.fold((l) {
      emit(state.copyWith(states: OptionStates.error));
    }, (r) {
      List<OptionModel?> options = (r.data as List).map((e) => OptionModel.fromJson(e)).toList();
      emit(state.copyWith(allOptions: options, states: OptionStates.completed));
      options.isNotEmpty ? setSelectedOption(options.first ?? OptionModel.empty()) : null;
      originalOptionList = options;
      for (var option in options) {
        if (option != null) {
          optionItemsMap[option.id!] = option.items ?? [];
          // Add items to originalItemList if needed
          for (var item in option.items ?? []) {
            originalItemList.add(item);
          }
        }
      }
      for (var option in options) {
        for (var item in option?.items ?? []) {
          originalItemList.add(item);
        }
      }
    });
  }

  /// postOptions
  @override
  Future postOptions({required OptionModel optionModel}) async {
    OptionModel newOptionModel = optionModel.copyWith(id: () => null);
    final response = await _optionService.postOptions(optionModel: newOptionModel);
    response.fold((l) {
      emit(state.copyWith(states: OptionStates.error));
    }, (r) async {
      OptionModel option = OptionModel.fromJson(r.data);
      emit(state.copyWith(option: option, states: OptionStates.completed));
      await getOptions();
    });
  }

  /// putOptions
  @override
  Future putOptions({required OptionModel optionModel, required String optionId}) async {
    final modifiedOptionModel = optionModel.copyWith(
      items: optionModel.items?.map((item) => item.copyWith(id: null)).toList(),
    );
    final response =
        await _optionService.putOptions(optionId: optionId, optionModel: modifiedOptionModel);
    response.fold((l) {
      emit(state.copyWith(states: OptionStates.error));
    }, (r) async {
      OptionModel option = OptionModel.fromJson(r.data);
      await getOptions();
      emit(state.copyWith(option: option, states: OptionStates.completed));
    });
  }

  @override
  Future patchOptions({required String optionId}) async {
    emit(state.copyWith(states: OptionStates.loading));
    final response = await _optionService.patchOptions(optionId: optionId);
    response.fold((l) {
      emit(state.copyWith(states: OptionStates.error));
    }, (r) {
      emit(state.copyWith(states: OptionStates.completed));
    });
  }
}

enum UpdatedItemValue {
  itemName,
  itemPrice,
  itemLPrice,
  itemHPrice,
  itemDPrice,
  itemTPrice,
  vatRate
}

// Extension method to compare Item objects
extension on Item {
  bool equals(Item other) {
    return itemName == other.itemName &&
        price == other.price &&
        lunchPrice == other.lunchPrice &&
        happyHourPrice == other.happyHourPrice &&
        deliveryPrice == other.deliveryPrice &&
        takeOutPrice == other.takeOutPrice &&
        amount == other.amount &&
        vatRate == other.vatRate;
  }
}
