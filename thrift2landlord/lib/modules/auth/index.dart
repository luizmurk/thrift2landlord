import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift2landlord/core/services/shared_services.dart';

import '../../core/components/index.dart';
import '../../core/models/data/user_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/app_services.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';
import '../../data/repositories/collections.dart';

part './views/splash.dart';
part './services/auth_service.dart';
part './controllers/auth_controller.dart';
part './views/sign_up.dart';
part './views/sign_in.dart';
part './views/email_verification.dart';
part './views/forgot_password.dart';
