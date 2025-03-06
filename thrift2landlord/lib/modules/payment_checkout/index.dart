import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thrift2landlord/core/components/index.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../core/components/inputs/custom_date_picker.dart';
import '../../core/models/data/listings/installment_plan_model.dart';
import '../../core/models/data/listings/payment_model.dart';
import '../../core/models/data/listings/property_listings_model.dart';
import '../../core/themes/app_sizes.dart';

part 'controllers/payment_checkout_controller.dart';
part 'services/payment_checkout_service.dart';
part 'views/payment_checkout_screen.dart';
part 'widgets/bank_transfer.dart';
part 'widgets/payment_option.dart';
