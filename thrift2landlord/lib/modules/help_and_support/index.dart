import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:thrift2landlord/core/themes/app_colors.dart';

import '../../core/models/data/user_model.dart';
import '../../core/services/shared_services.dart';
import '../../core/themes/app_sizes.dart';

part './chat_screen.dart';
part './message_page.dart';
part './repositories/controllers/chat_controller.dart';
part './repositories/controllers/faqController.dart';
part './repositories/models/faq.dart';
part './repositories/models/faq_model.dart';
part './repositories/models/message.dart';
part './repositories/services/faqService.dart';
part './repositories/services/hlep_support_service.dart';
part './repositories/widgets/bottom_chat_bar.dart';
part './repositories/widgets/_tab_view.dart';
part './repositories/widgets/call_dropdown.dart';
part './repositories/widgets/chat_input_field.dart';
part './repositories/widgets/customPopupMenu.dart';
part './repositories/widgets/faq_tags.dart';
part './repositories/widgets/full_image_modal.dart';
part './repositories/widgets/image_preview_dialog.dart';
part './repositories/widgets/message.dart';
