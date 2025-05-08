import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: context.colorScheme.surface,
          hintText: 'Search...',
          hintStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: context.colorScheme.onSurface.withOpacity(0.4),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: context.colorScheme.onSurface.withOpacity(0.4),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 11),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            borderSide: BorderSide(
              color: context.colorScheme.outline.withOpacity(0.4),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            borderSide: BorderSide(
              color: context.colorScheme.outline.withOpacity(0.4),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            borderSide: BorderSide(
              color: context.colorScheme.outline.withOpacity(0.4),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
