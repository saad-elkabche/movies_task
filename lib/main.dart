import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/constants/app_colors/app_colors.dart';
import 'package:movie_app/core/dependencies/dependencies.dart';
import 'package:movie_app/data/data_providers/api_provider/api_client.dart';
import 'package:movie_app/data/repository/repository.dart';
import 'package:movie_app/domain/repository/repository.dart';
import 'package:movie_app/routes.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await prepareDependencies();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black
    )
  );
  runApp(MovieApp());
}



Future<void> prepareDependencies() async{
  await dotenv.load(fileName: ".env");
  Repository repository=RepositoryIml(apiClient: ApiClientIml(
      baseUrl: dotenv.env["base_url"]!,
      apiKey: dotenv.env["api_key"]!)
  );
  Dependencies.put(repository);
}


class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
    );
  }
}
