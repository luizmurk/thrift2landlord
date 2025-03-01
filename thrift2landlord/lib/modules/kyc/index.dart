import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/components/index.dart';
import '../../core/components/inputs/custom_date_picker.dart';
import '../../core/components/inputs/custom_file_picker.dart';
import '../../core/models/data/KYC/kyc.dart';
import '../../core/models/data/user_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/shared_services.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';

part 'controllers/kyc_controller.dart';
part 'views/kyc_screen.dart';
part 'widgets/skeletons/kyc_skeleton.dart';
part 'widgets/personal.dart';
part 'services/kyc_service.dart';
part 'widgets/identification.dart';
part 'widgets/employment_income.dart';
part 'widgets/bank_details.dart';
part 'widgets/next_of_kin.dart';
part 'widgets/security.dart';
part 'chat_bindings.dart';
