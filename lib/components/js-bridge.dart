@JS() // Sets the context, which in this case is `window`
library t;

import 'package:js/js.dart';
@JS('showInput') // This marks the annotated function as a call to `console.log`
external void showInput(dynamic id);

@JS('setHost') // This marks the annotated function as a call to `console.log`
external void setHost(dynamic host);
