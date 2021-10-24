import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    Key? key,
    required this.context,
    required this.svgPath,
    required this.title,
    required this.description,
    required this.isExpanded,
    required this.child,
  }) : super(key: key);

  final BuildContext context;
  final String svgPath;
  final String title;
  final String description;
  final bool isExpanded;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withOpacity(isExpanded ? 1.0 : 0.1),
              blurRadius: isExpanded ? 2.0 : 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    svgPath,
                    width: 54,
                    height: 54,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        description,
                        style: GoogleFonts.poppins(),
                      )
                    ],
                  ),
                ],
              ),
              isExpanded
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        child
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
