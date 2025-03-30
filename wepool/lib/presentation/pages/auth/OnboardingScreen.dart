import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wepool/utils/colors.dart';

import '../../../widgets/global/GlobalOutlinEditText.dart';
import '../../provider/RegistrationProvider.dart';

class OnboardingScreen extends StatefulWidget {
  final String email;

  const OnboardingScreen({super.key, required this.email});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /// Function to show Cupertino Date Picker inside a bottom sheet
  void _showDatePicker(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// Selected Date Text
              Text(
                "${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    selectedDate = newDate;
                  },
                ),
              ),

              /// Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _dobController.text =
                          "${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}";
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                  child: Text(
                    "Done",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Convert month number to month name
  String _getMonthName(int month) {
    const List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  bool isButtonEnabled = false; // Track button state

  @override
  void initState() {
    super.initState();

    /// Listen for changes in text fields
    _nameController.addListener(_validateForm);
    _dobController.addListener(_validateForm);
    _numberController.addListener(_validateForm);
  }

  /// Function to check if all fields are filled
  void _validateForm() {
    setState(() {
      isButtonEnabled =
          _nameController.text.isNotEmpty &&
          _dobController.text.isNotEmpty &&
          _numberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<RegistrationProvider>(
          builder: (context, registrationProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (registrationProvider.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(registrationProvider.errorMessage),
                    backgroundColor: Colors.red, // Error styling
                    duration: Duration(seconds: 3),
                  ),
                );
                registrationProvider
                    .clearError(); // Clear error message after showing
              }
            });
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 10,
                    ),
                    child: Form(
                      key: _formKey,
                      // Wrap everything inside a Form for validation
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 Title
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                            child: Text(
                              "Welcome Onboard!",
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          /// 🔹 Subtitle
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "One more step and you’ll be \nready to go",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray001,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          /// 🔹 Name Input
                          GlobalOutlineEditText(
                            hintText: "Enter your full name",
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Name cannot be empty";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          /// 🔹 Date of Birth Input (With Cupertino Date Picker)
                          GestureDetector(
                            onTap: () => _showDatePicker(context),
                            child: AbsorbPointer(
                              child: GlobalOutlineEditText(
                                hintText: "Add your birthday",
                                controller: _dobController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Add date of birth";
                                  }
                                  return null;
                                },
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: AppColors.gray003,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          /// 🔹 Mobile Number Input
                          GlobalOutlineEditText(
                            hintText: "Enter your mobile number",
                            controller: _numberController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Phone Number cannot be empty";
                              }
                              if (value.length < 10) {
                                return "Phone Number must be at least 10 characters";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 30),

                          /// 🔹 Continue Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  isButtonEnabled
                                      ? () {
                                        if (_formKey.currentState!.validate()) {
                                          Provider.of<RegistrationProvider>(
                                            context,
                                            listen: false,
                                          ).setUserDetails(
                                            _nameController.text,
                                            _dobController.text,
                                            _numberController.text,
                                          );

                                          // Call registerUser with context
                                          Provider.of<RegistrationProvider>(
                                            context,
                                            listen: false,
                                          ).registerUser(context);
                                        }
                                      }
                                      : null,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor:
                                    isButtonEnabled
                                        ? AppColors.primary
                                        : AppColors.gray001, // Change color when disabled
                              ),
                              child: Text(
                                "Continue",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Extra space at bottom
                        ],
                      ),
                    ),
                  ),
                ),
                // Circular Loading Overlay
                if (registrationProvider.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
