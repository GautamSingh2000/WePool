import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wepool/utils/colors.dart';

import '../../widgets/global/GlobalOutlinEditText.dart';

class PublishRideScreen extends StatefulWidget {
  @override
  _PublishRideScreenState createState() => _PublishRideScreenState();
}

class _PublishRideScreenState extends State<PublishRideScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Publish your ride",
              style: GoogleFonts.poppins(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Pickup Field
            Text(
              "Pickup From",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            GlobalOutlineEditText(
              hintText: "Enter your full address",
              controller: _pickupController,
              prefixIcon: Image.asset(
                "assets/icons/ic_search.png",
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(height: 26),

            // Destination Field
            Text(
              "Destination",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            GlobalOutlineEditText(
              hintText: "Enter your full address",
              controller: _destinationController,
              prefixIcon: Image.asset(
                "assets/icons/ic_search.png",
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(height: 30),

            // Add Stopover
            Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: IconButton(
                    onPressed: () {
                      // Add your action here
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
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


                const SizedBox(width: 15),
                Text(
                  "Add a Stopover",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // TODO: Handle button click
                },
                child:  Text(
                  "Continue",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
