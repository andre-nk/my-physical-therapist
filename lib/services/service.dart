import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:my_physical_therapist_admin/models/model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

part "auth_service.dart";
part "user_service.dart";
part "general_content_services.dart";
part "weight_tracker_services.dart";
part "exercises_services.dart";
part "event_services.dart";
part "chat_services.dart";
part "admin_services.dart";