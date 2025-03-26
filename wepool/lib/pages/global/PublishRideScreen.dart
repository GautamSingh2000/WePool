import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wepool/utils/colors.dart';
import 'package:wepool/widgets/global/GlobalOutlinEditText.dart';

class PublishRideScreen extends StatefulWidget {
  const PublishRideScreen({super.key});

  @override
  State<PublishRideScreen> createState() => _PublishRideScreenState();
}

class _PublishRideScreenState extends State<PublishRideScreen> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0 ),
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
                    color: Colors.black),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Leaving From",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),

            // Leaving From Input
            Container(
                margin:EdgeInsets.only(top: 10, bottom: 20),
                child: GlobalOutlineEditText(hintText: "Enter your full address",
                    controller: _leavingFromController,
                    prefixIcon: Image.asset("assets/icons/ic_search.png", width: 18,
                        height: 18))),

            // Going To Input with Swap Icon
            Row(
              children: [
                Expanded(child: Text("Going to",style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),),
                ),
                SizedBox(
                  width: 24, // Adjust width
                  height: 24, // Adjust height
                  child: IconButton(
                    onPressed: _swapAddresses,
                    icon: Icon(Icons.swap_vert, color: Colors.white, size: 14), // Smaller icon
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary, // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Rounded corners
                      ),
                      padding: EdgeInsets.zero, // Remove extra padding
                    ),
                  ),
                )



              ],
            ),

            Container(
                margin:EdgeInsets.only(top: 10, bottom: 15),
                child: GlobalOutlineEditText(hintText: "Enter your full address",
                    controller: _goingToController,
                    prefixIcon: Image.asset("assets/icons/ic_search.png", width: 18,
                        height: 18))),

            // Date and Seats Row
            Row(
              children: [
                // Select Date Button
                Column(
                  children: [
                    Text(
                      "Going to",
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: _pickDate,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate == null ? "Select Date" : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                style: TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              Icon(Icons.calendar_today, size: 18, color: Colors.black54),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 16),

                // Seat Counter
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No of seats",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          _buildCounterButton(Icons.remove, () {
                            if (seats > 1) setState(() => seats--);
                          }),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("$seats", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          _buildCounterButton(Icons.add, () {
                            if (seats < 10) setState(() => seats++);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 24),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Text Field Widget
  Widget _buildTextField(String hintText, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
    );
  }

  // Seat Counter Button
  Widget _buildCounterButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black),
      constraints: BoxConstraints(),
      padding: EdgeInsets.all(8),
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
}
