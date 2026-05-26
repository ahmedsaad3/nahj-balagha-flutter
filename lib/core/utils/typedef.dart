import 'package:flutter/material.dart';

typedef VoidValidCallBackInt = void Function(int)?;
typedef ValidCallbackBoolean = void Function(bool)?;
typedef ValidCallBack = String? Function(String?);
typedef ItemBuilderCallBack = Widget Function(BuildContext, int);
typedef DynamicCallBack = Function(dynamic)?;
typedef ResponseConverter<T> = T Function(dynamic response);
