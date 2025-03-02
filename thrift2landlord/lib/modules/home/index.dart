import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/components/index.dart';
import '../../core/components/others/custom_avatar.dart';
import '../../core/models/data/user_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/shared_services.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';
import '../../data/repositories/images.dart';
import '../landing/index.dart';
import '../listings/index.dart';
import '../payments/index.dart';
import '../profile/index.dart';
import '../properties/index.dart';

part 'controllers/home_controller.dart';
part 'views/home_screen.dart';
part 'widgets/skeletons/home_skeleton.dart';
part 'widgets/kyc_banner.dart';
part 'home_bindings.dart';
