import 'package:auto_route/auto_route.dart';
import 'package:upcoming_games/models/game.dart';
import 'package:upcoming_games/pages/details_page.dart';
import 'package:upcoming_games/pages/home_page.dart';
import 'package:upcoming_games/pages/image_viewer_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MyHomeRoute.page, path: '/', initial: true),
        AutoRoute(page: DetailsRoute.page, path: '/details/:id'),
        AutoRoute(page: ImageViewerRoute.page, path: '/image-viewer'),
      ];
}
