import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension XBuildContext on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
}
