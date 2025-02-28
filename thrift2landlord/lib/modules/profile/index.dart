import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thrift2landlord/core/components/index.dart';
import 'package:thrift2landlord/modules/auth/index.dart';

import '../../core/components/others/custom_avatar.dart';
import '../../core/components/others/custom_settings_tile.dart';
import '../../core/models/data/user_model.dart';
import '../../core/services/app_services.dart';
import '../../core/services/shared_services.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';
import '../../core/themes/theme_controller.dart';

part 'controllers/profile_controller.dart';
part 'services/edit_profile.dart';
part 'controllers/edit_profile.dart';
part 'views/profile_screen.dart';
part 'widgets/skeletons/profile_skeleton.dart';
part 'widgets/edit_profile_form.dart';
part 'profile_bindings.dart';
