import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

Widget textFieldWidget(context, _fieldName, label, inputType) {
  return FormBuilderTextField(
    name: _fieldName,
    decoration: InputDecoration(
      labelText: label,
    ),
    onChanged: onChanged,

    // valueTransformer: (text) => num.tryParse(text),
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(context),
    ]),
    keyboardType: inputType,
  );
}

onChanged(val) {
  print(val);
}

Widget formFieldTypeAheadWidget(context, _fieldName, label, values) {
  return (FormBuilderTypeAhead<String>(
    decoration: InputDecoration(labelText: label, hintText: 'Digite su $label'),
    name: _fieldName,
    itemBuilder: (context, value) {
      //return ListTile(title: Text(continent));
      return ListTile(
        leading: Icon(Icons.auto_awesome),
        title: Text(value),
        //subtitle: Text('\$${suggestion['price']}'),
      );
    },
    suggestionsCallback: (query) {
      if (query.isNotEmpty) {
        var lowercaseQuery = query.toLowerCase();
        return values.where((value) {
          return value.toLowerCase().contains(lowercaseQuery);
        }).toList(growable: false)
          ..sort((a, b) => a
              .toLowerCase()
              .indexOf(lowercaseQuery)
              .compareTo(b.toLowerCase().indexOf(lowercaseQuery)));
      } else {
        return values;
      }
    },
  ));
}

Widget submitButtonWidget(label, context, _formKey, callBack) {
  return MaterialButton(
    color: Theme.of(context).accentColor,
    child: Expanded(
        flex: 5,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        )),
    onPressed: () {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        print(_formKey.currentState!.value);
        callBack(_formKey.currentState!.value);
      } else {
        print("Hay Errores en los Datos");
      }
    },
  );
}
