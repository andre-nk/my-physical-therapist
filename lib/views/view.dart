import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_physical_therapist_admin/configs/configs.dart';
import 'package:my_physical_therapist_admin/models/model.dart';
import 'package:my_physical_therapist_admin/views/widgets/widget.dart';
import 'package:my_physical_therapist_admin/providers/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';

part "auth/auth_page.dart";
part "auth/sign_in_page.dart";
part "auth/sign_up_page.dart";
part "auth/forgot_password_page.dart";
part 'app/landing_page.dart';
part 'app/user_admin_list_page.dart';
// part 'app/dashboard_page.dart';
part 'app/event_page.dart';
// part 'app/patient_education_page.dart';
// part 'app/goal_page.dart';
// part 'app/exercises_goal_page.dart';
// part 'app/weight_tracker_page.dart';
// part 'app/pain_scale_page.dart';
// part 'app/chat_page.dart';
// part 'app/exercises_page.dart';
part 'subpage/user_list.dart';
part 'subpage/admin_list.dart';
part 'subpage/event_item_page.dart';
part 'subpage/event_editor.dart';
// part 'sub_page/chat_contact_page.dart';