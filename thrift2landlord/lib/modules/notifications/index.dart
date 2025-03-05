import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thrift2landlord/core/components/index.dart';

import '../../core/models/data/listings/notifications_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/app_services.dart';

part 'controllers/notification_controller.dart';
part 'views/notification_screen.dart';
part 'services/mock_data_service.dart';
part 'services/notification_service.dart';
