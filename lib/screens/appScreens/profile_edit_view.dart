import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:vix_roader/screens/appScreens/app_drawer.dart';

class ProfileEditView extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile '),
        ),
        drawer:
            Drawer(child: AppDrawer() // Populate the Drawer in the next step.
                ),
        body: FormBuilder(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _textFieldWidget(context, 'name'),
              //         _dateFieldWidget(context, 'birth'),
              //         _checkBoxFieldWidget(context, 'terms'),
              //         _imageFieldWidget(context, 'photo'),
              _submitButtonWidget(context, _formKey),
              SizedBox(height: 20),
              _resetButtonWidget(context, _formKey),
            ],
          ),
        ));
  }

  _onChanged(val) {
    print(val);
  }

  Widget _textFieldWidget(context, _fieldName) {
    return FormBuilderTextField(
      name: _fieldName,
      decoration: InputDecoration(
        labelText: 'Nombre Completo',
      ),
      onChanged: _onChanged,
      initialValue: 'Esteban Ortiz Oviedo Velasco',
      // valueTransformer: (text) => num.tryParse(text),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context),
        FormBuilderValidators.max(context, 70),
      ]),
      keyboardType: TextInputType.name,
    );
  }

  Widget _dateFieldWidget(context, _fieldName) {
    return FormBuilderDateTimePicker(
      name: _fieldName,
      // onChanged: _onChanged,
      inputType: InputType.date,
      decoration: InputDecoration(
        labelText: 'Appointment Time',
      ),
      //initialTime: TimeOfDay(hour: 8, minute: 0),
      initialValue: DateTime.now(),
      enabled: true,
    );
  }

  Widget _checkBoxFieldWidget(context, _fieldName) {
    return FormBuilderCheckbox(
      name: _fieldName,
      initialValue: false,
      onChanged: _onChanged,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'I have read and agree to the ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Terms and Conditions',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      validator: FormBuilderValidators.equal(
        context,
        true,
        errorText: 'You must accept terms and conditions to continue',
      ),
    );
  }

  Widget _imageFieldWidget(context, _fieldName) {
    return FormBuilderImagePicker(
      name: _fieldName,
      decoration: const InputDecoration(labelText: 'Pick Photos'),
      maxImages: 1,
    );
  }

  Widget _submitButtonWidget(context, _formKey) {
    return MaterialButton(
      color: Theme.of(context).accentColor,
      child: Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _formKey.currentState!.save();
        if (_formKey.currentState!.validate()) {
          print(_formKey.currentState!.value);
        } else {
          print("validation failed");
        }
      },
    );
  }

  Widget _resetButtonWidget(context, _formKey) {
    return ElevatedButton(
      onPressed: () {
        // Reset form
        _formKey.currentState!.reset();

        // Optional: unfocus keyboard
        FocusScope.of(context).unfocus();
      },
      child: Text('Reset'),
    );
  }
}
