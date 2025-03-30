import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wepool/utils/colors.dart';
import 'package:wepool/widgets/global/GlobalOutlinEditText.dart';

class SearchRideScreen extends StatefulWidget {
  const SearchRideScreen({super.key});

  @override
  State<SearchRideScreen> createState() => _SearchRideScreenState();
}

class _SearchRideScreenState extends State<SearchRideScreen> {
  final TextEditingController _leavingFromController = TextEditingController();
  final TextEditingController _goingToController = TextEditingController();
  int seats = 4; // Default seat count
  DateTime? selectedDate;

  void _swapAddresses() {
    setState(() {
      String temp = _leavingFromController.text;
      _leavingFromController.text = _goingToController.text;
      _goingToController.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Enables scrolling
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    "Search your Ride",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Leaving From Label
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Leaving From",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Leaving From Input
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: GlobalOutlineEditText(
                    hintText: "Enter your full address",
                    controller: _leavingFromController,
                    prefixIcon: Image.asset(
                      "assets/icons/ic_search.png",
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),

                // Going To Input with Swap Icon
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Going to",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: IconButton(
                        onPressed: _swapAddresses,
                        icon: Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                          size: 16,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),

                // Going To Input
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: GlobalOutlineEditText(
                    hintText: "Enter your full address",
                    controller: _goingToController,
                    prefixIcon: Image.asset(
                      "assets/icons/ic_search.png",
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),

                // Date and Seats Selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Select Date Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Going to",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: _pickDate,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundGray01,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  color: AppColors.borderGray01,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDate == null
                                        ? "Select Date"
                                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.hintGray,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),

                    // Seats Counter Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No of seats",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),

                        SizedBox(height: 10),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Decrement Button
                              Container(
                                height: 28,
                                // Increased for better UI consistency
                                width: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundGray01,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.borderGray01,
                                  ),
                                ),
                                child: Center(
                                  // Ensures icon is centered
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: AppColors.iconGray02,
                                    ),
                                    padding: EdgeInsets.zero,
                                    // Removes default padding
                                    constraints: BoxConstraints(),
                                    // Removes default constraints
                                    onPressed: () {
                                      if (seats > 1) setState(() => seats--);
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(width: 10), // Spacing
                              // Seat Count Display
                              Container(
                                height: 40,
                                width: 72,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.borderGray01,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "$seats",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 10), // Spacing
                              // Increment Button
                              Container(
                                height: 28, // Slightly increased for better UI
                                width: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundGray01,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.borderGray01,
                                  ),
                                ),
                                child: Center(
                                  // Ensures the icon is centered
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 16,
                                      color: AppColors.iconGray02,
                                    ),
                                    padding: EdgeInsets.zero,
                                    // Removes extra padding
                                    constraints: BoxConstraints(),
                                    // Prevents default constraints
                                    onPressed: () {
                                      if (seats < 10) setState(() => seats++);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _validateAndProceed,
                    // Validation before proceeding
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Pick Date Function
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    }
  }

  // Validation Function
  void _validateAndProceed() {
    if (_leavingFromController.text.isEmpty) {
      _showSnackbar("Please enter your leaving address.");
      return;
    }
    if (_goingToController.text.isEmpty) {
      _showSnackbar("Please enter your destination address.");
      return;
    }
    if (selectedDate == null) {
      _showSnackbar("Please select a date.");
      return;
    }
    if (seats < 1) {
      _showSnackbar("Please select at least one seat.");
      return;
    }

    // Proceed to next step
    print("All fields are valid, proceeding...");
  }

  // Show Snackbar for Error Messages
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
      ),
    );
  }
}
