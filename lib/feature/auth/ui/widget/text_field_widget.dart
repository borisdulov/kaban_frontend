import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.hintText,
    this.isPassword = false,
  });

  final String text;
  final IconData icon;
  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          SizedBox(height: AppSize.p4),
          Card(
            color: context.colorScheme.surface,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              side: BorderSide(
                color: context.colorScheme.onSurface.withOpacity(0.2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSize.p12),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 16,
                    color: context.colorScheme.onSurface.withOpacity(0.4),
                  ),
                  SizedBox(width: AppSize.p8),
                  Expanded(
                    child: TextField(
                      obscureText: isPassword,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: context.colorScheme.onSurface.withOpacity(0.4),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        
                        //* Скрыть/Открыть видимость пароля
                        // suffixIcon:
                        //     isPassword
                        //         ? IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(Icons.visibility, size: 16),
                        //         )
                        //         : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
