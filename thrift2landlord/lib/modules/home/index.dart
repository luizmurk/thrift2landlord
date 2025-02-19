import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thrift2landlord/core/components/index.dart';

import '../../core/components/others/custom_avatar.dart';
import '../../core/components/others/custom_settings_tile.dart';
import '../../core/services/listings_services.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';
import '../../core/utils/custom_divider.dart';
import '../../core/utils/sample_form_screen.dart';
import '../../data/repositories/images.dart';
import '../chat/index.dart';
import '../landing/index.dart';
import '../listings/index.dart';
import '../payments/index.dart';
import '../profile/index.dart';
import '../properties/index.dart';

part 'controllers/home_controller.dart';
part 'views/home_screen.dart';
part 'widgets/skeletons/home_skeleton.dart';
part 'home_bindings.dart';
