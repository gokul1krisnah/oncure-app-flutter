import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// A reusable custom button for the entire application.
class PrimaryButton extends StatelessWidget {
  // 1. Define the properties (variables) this button will need
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? bgColor;
  final FontWeight? fontWeight;
  

  // 2. Create the constructor to receive these properties
  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.icon, 
    this.bgColor,
    this.fontWeight,
    super.key,
  });

  // 3. Build the UI for the button
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 56, // Set a fixed height for the button
    child: ElevatedButton(
      // The action that happens when the button is tapped
      onPressed: onPressed,

      // The visual style of the button
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AppColors.primary, // Purple background
        foregroundColor: Colors.white, // Text and icon color
        shadowColor: AppColors.greyText, // Shadow color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
      ),

      // The content inside the button (Text and optional Icon)
      child: _buildButtonContent(),
    ),
  );

  /// A helper method to build the widget inside the button cleaner
  Widget _buildButtonContent() {
    // Create a list of widgets starting with the Text
    final List<Widget> contentWidgets = [
      Text(
        text,
        style: TextStyle(fontWeight: fontWeight ?? FontWeight.w600, fontSize: 16),
      ),
    ];

    // If an icon was provided, add it to our list of widgets
    if (icon != null) {
      contentWidgets.add(const SizedBox(width: 8)); // Add a small space gap
      contentWidgets.add(Icon(icon, size: 20)); // Add the icon itself
    }

    // Return them all arranged in a horizontal row
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Center everything horizontally
      children: contentWidgets,
    );
  }
}
