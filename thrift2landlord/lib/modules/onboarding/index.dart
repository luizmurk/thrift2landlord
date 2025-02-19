import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thrift2landlord/core/components/index.dart';

import '../../core/components/others/custom_settings_tile.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/listings_services.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';
import '../../core/themes/app_typography.dart';
import '../../core/utils/custom_divider.dart';
import '../../core/utils/sample_form_screen.dart';

part 'controllers/onboarding_controller.dart';
part 'views/onboarding_screen.dart';
part './widgets/onboarding_slide.dart';
part 'chat_bindings.dart';
