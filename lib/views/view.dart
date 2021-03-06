import 'dart:io';
import 'dart:core';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_physical_therapist/configs/configs.dart';
import 'package:my_physical_therapist/configs/my_physical_therapist_icons.dart';
import 'package:my_physical_therapist/models/model.dart';
import 'package:my_physical_therapist/views/widget/widget.dart';
import 'package:my_physical_therapist/providers/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

part "auth/auth_page.dart";
part "auth/sign_in_page.dart";
part "auth/sign_up_page.dart";
part "auth/forgot_password_page.dart";
part 'app/default_page.dart';
part 'app/home_page.dart';
part 'app/dashboard_page.dart';
part 'app/event_page.dart';
part 'app/patient_education_page.dart';
part 'app/goal_page.dart';
part 'app/exercises_goal_page.dart';
part 'app/weight_tracker_page.dart';
part 'app/pain_scale_page.dart';
part 'app/chat_page.dart';
part 'app/exercises_page.dart';
part 'sub_page/patient_education_sub_page.dart';
part 'sub_page/event_item_page.dart';
part 'sub_page/exercises_goal_detailed_page.dart';
part 'sub_page/chat_contact_page.dart';