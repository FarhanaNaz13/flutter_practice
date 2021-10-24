import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/widgets/annotated_region_wrapper.dart';

extension ScaffoldMaker on Widget {
  Widget _makeScaffold(context, {bool poppable = false}) {
    return Scaffold(
      body: SafeArea(
          child: poppable
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                    this,
                  ],
                )
              : this),
    );
  }
}

extension ThemeScreenMaker on Widget {
  Widget makethemeScreen(context, {bool poppable = false}) {
    return AnnotatedRegionWrapper(
        child: this._makeScaffold(context, poppable: poppable));
  }
}

extension ThemeRoundBoxDecorationMaker on Widget {
  Widget round(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        shape: BoxShape.circle,
      ),
      child: this,
    );
  }

  Widget roundRect(BuildContext context, {borderColor}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            color:
                borderColor ?? Theme.of(context).primaryColor.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: this,
    );
  }
}
