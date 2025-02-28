import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thrift2landlord/core/components/index.dart';

import '../../core/models/data/listings/payment_model.dart';
import '../../core/models/data/listings/property_listings_model.dart';
import '../../core/models/data/user_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/app_services.dart';
import '../../core/services/shared_services.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';
import '../listings/index.dart';

part 'controllers/properties_controller.dart';
part 'views/properties_screen.dart';
part 'views/liked_properties.dart';
part 'widgets/skeletons/properties_skeleton.dart';
part 'properties_bindings.dart';
part 'services/properties_service.dart';
part 'widgets/property.dart';
part 'widgets/property_payment.dart';
