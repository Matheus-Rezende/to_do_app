import 'package:go_router/go_router.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository_remote.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/routing/routes.dart';
import 'package:to_do_app/ui/splash/widgets/splash_screen.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:to_do_app/ui/todo/widgets/todo_screen.dart';
import 'package:to_do_app/ui/todo_details/viewmodels/todo_details_viewmodel.dart';
import 'package:to_do_app/ui/todo_details/widgets/todo_details_screen.dart';

GoRouter routerConfig() {
  final todosRepository = TodosRepositoryRemote(apiClient: ApiClient(host: '192.168.3.22'));
  return GoRouter(
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: Routes.todos,
        builder: (context, state) {
          return TodoScreen(todoViewmodel: TodoViewmodel(todosRepository: todosRepository));
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final todoId = state.pathParameters['id']!;
              final TodoDetailsViewmodel todoDetailsViewmodel = TodoDetailsViewmodel(
                todosRepository: todosRepository,
              );
              todoDetailsViewmodel.load.execute(todoId);
              return TodoDetailsScreen(todoDetailsViewmodel: todoDetailsViewmodel);
            },
          ),
        ],
      ),
    ],
  );
}
