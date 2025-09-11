import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SearchableMultiSelectDropdown<T> extends StatelessWidget {
  final ValueNotifier<List<T>> selectedItemsNotifier = ValueNotifier<List<T>>(
    [],
  );
  final String controlName;
  final String label;
  final List<T> items;
  final bool? mandatory;
  final List<T> Function() selItems;
  final Function(List<T>?)? onChangeListener;
  final Key? fieldKey;

  SearchableMultiSelectDropdown({
    this.fieldKey,
    required this.controlName,
    required this.label,
    required this.items,
    required this.selItems,
    this.mandatory,
    this.onChangeListener,
  });

  String itemValueMapper(T item) {
    if (item is Lov) {
      return item.optDesc;
    } else {
      return item.toString();
    }
  }

  _onChangeListener(List<T> val) {
    selectedItemsNotifier.value = val;
    if (onChangeListener != null)
      onChangeListener!(selectedItemsNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: Colors.black, 
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    if (mandatory == null || mandatory == true)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ReactiveFormField<String, T>(
            key: fieldKey,
            formControlName: controlName,
            validationMessages: {
              ValidationMessage.required: (error) => '$label is required',
            },
            builder: (field) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: DropdownSearch<T>.multiSelection(
                  items: items,
                  selectedItems: selItems(),
                  enabled: field.control.enabled,
                  itemAsString: (item) => itemValueMapper(item),
                  popupProps: PopupPropsMultiSelection.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      filled: true, // Enables background color
                      fillColor: Colors.grey.shade100, // Your background shade
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Remove default border
                      ),
                      hintText: 'Select $label',
                      hintStyle: TextStyle(
                        color: Colors.grey
                      ),
                      errorText: field.errorText,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    ),
                  ),
                  onChanged: (val) {
                    _onChangeListener(val);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
