import 'package:flutter/material.dart';
import 'package:responsive_scafold/custom_loader.dart';
import 'package:responsive_scafold/custom_text.dart';
import 'custom_button.dart';
import 'custom_date_picker.dart';
import 'custom_date_range_picker.dart';
import 'custom_dialgue.dart';
import 'custom_drop_down.dart';
import 'custom_icon_button.dart';
import 'custom_image.dart';
import 'custom_logger.dart';
import 'custom_scaffold.dart';
import 'custom_textfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/home': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  bool _isEnabled = true;
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _phone;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Save the form fields
      // Handle form submission logic
      print('Email: $_email');
      print('Phone Number: $_phone');
    } else {
      // If the form is not valid, handle accordingly
      print('Form is not valid');
    }
  }

  void _toggleLoading() {
    _submitForm();
    LoaderManager.instance.showLoader(context);
    setState(() {
      _isLoading = !_isLoading;
    });

    // Simulate a network request
    if (!_isLoading) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isEnabled = !_isEnabled;
          _isLoading = !_isLoading;
        });
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isEnabled = !_isEnabled;
          _isLoading = !_isLoading;
        });
        LoaderManager.instance.hideLoader();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Responsive Scaffold Example',
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Email',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  // Add additional email validation logic here
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onPressed: _toggleLoading,
                text: 'Submit',
                icon: Icons.send,
                elevation: 8.0,
                isLoading: null,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomIconButton(
                icon: Icons.favorite,
                onPressed: () {
                  showResponsiveDialog(context);
                  // Handle the button press
                },
                tooltip: 'favorite_button',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomPopupMenu<String>(
                items: const ['Item 1', 'Item 2', 'Item 3'],
                selectedItem: 'Item 1',
                hint: 'Select an item',
                selectedItemStyle: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
                unselectedItemStyle: const TextStyle(color: Colors.black),
                borderColor: Colors.blue,
                onChanged: (value) {
                  print('Selected: $value');
                  Logger.info("This is an info message.");
                  Logger.success("This is a warning message.");
                  Logger.error("This is an error message.");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDatePicker(
                initialDate: DateTime.now(),
                onDateSelected: (selectedDate) {
                  print('Selected date: $selectedDate');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDateRangePicker(
                initialDateRange: DateTimeRange(
                    start: DateTime.now(),
                    end: DateTime.now().add(const Duration(days: 7))),
                onDateRangeSelected: (DateTimeRange dateRange) {
                  // Handle the selected date range
                  print(
                      'Selected range: ${dateRange.start} to ${dateRange.end}');
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ScreenWithoutAppBarAndDrawer();
          }));
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBarItems: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }

  void showResponsiveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ResponsiveDialog(
          title: 'Responsive Dialog',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomText('This is a responsive dialog.'),
              const SizedBox(height: 16),
              CustomImage(
                imageUrl:
                    'data:image/jpeg;base64,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', // Network image URL
                // assetPath: 'assets/images/my_image.png', // Asset image path
                // filePath: '/path/to/local/image.png', // File image path
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              CustomText('Additional content can go here.'),
            ],
          ),
          cancelButtonText: 'Cancel',
          submitButtonText: 'Submit',
          onCancel: () {
            // Handle cancel action
            print('Cancel pressed');
          },
          onSubmit: () {
            // Handle submit action
            print('Submit pressed');
          },
          additionalActions: [
            CustomButton(
              text: 'Additional Action',
              onPressed: () {
                // Additional action
                print('Additional action pressed');
              },
              primaryColor: Colors.orange,
              elevation: 6.0,
            ),
          ],
        );
      },
    );
  }
}

class ScreenWithoutAppBarAndDrawer extends StatelessWidget {
  const ScreenWithoutAppBarAndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'No AppBar and Drawer',
      body: Center(
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ExampleForm();
              }));
            },
            child: CustomText('This screen has no AppBar and Drawer!')),
      ),
      showDrawer: false, // Optionally hide Drawer
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Settings Page')),
    );
  }
}

class ExampleForm extends StatefulWidget {
  @override
  _ExampleFormState createState() => _ExampleFormState();
}

class _ExampleFormState extends State<ExampleForm> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _phone;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Save the form fields
      // Handle form submission logic
      print('Email: $_email');
      print('Phone Number: $_phone');
    } else {
      // If the form is not valid, handle accordingly
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Set the GlobalKey to the Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              CustomTextField(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number cannot be empty';
                  }
                  // Add additional phone number validation logic here
                  return null;
                },
                onSaved: (value) {
                  _phone = value;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
