import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thrift2landlord/core/components/index.dart';

import '../../core/models/data/listings/document_model.dart';
import '../../core/models/data/listings/property_listings_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_sizes.dart';
import '../listings/index.dart';
import '../properties/index.dart';

part 'controllers/landing_controller.dart';
part 'views/landing_screen.dart';
part 'views/documents.dart';
part 'widgets/skeletons/landing_skeleton.dart';
part 'landing_bindings.dart';
