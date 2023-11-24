/// #DART# ///
export 'dart:io';
export 'dart:math';
export 'dart:async';
export 'dart:convert';
export 'dart:typed_data';
export 'package:flutter/material.dart';
export 'package:flutter_web_plugins/url_strategy.dart'
       if (dart.library.html) 'package:flutter_web_plugins/flutter_web_plugins.dart';


//basic
export 'package:path_provider/path_provider.dart';
export 'package:provider/provider.dart';

//Firebase
export 'package:firebase_auth/firebase_auth.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'firebase_options.dart';

//models
export '../models/user.dart';
export '../models/food_model.dart';
export '../models/tavolo.dart';
export '../models/comanda.dart';

//database
export 'database/database_user.dart';
export 'database/database_food.dart';
export 'database/database_table.dart';
export 'database/database_super_comanda.dart';
export 'database/database_order.dart';

//services
export 'app_director.dart';
export 'auth.dart';


//screens
export '../screens/loading_screen.dart';
export '../screens/staffScreen/LoginScreen.dart';
export '../screens/staffScreen/StaffHomepage.dart';

//general widget
export '../widgets/GeneralWidget/CustomTextField.dart';
export '../widgets/GeneralWidget/CustomExpansionTile.dart';












