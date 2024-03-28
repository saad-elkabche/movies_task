


import 'package:movie_app/core/constants/enums/app_status.dart';

extension AppStatusExtension on AppStatus?{

  bool get isSuccess=>this==AppStatus.success;
  bool get isError=>this==AppStatus.error;
  bool get isLoading=>this==AppStatus.loading;


}