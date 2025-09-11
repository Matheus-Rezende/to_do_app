import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository_dev.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository_remote.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/domain/use_cases/todo_update_use_case.dart';

List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => ApiClient(host: '192.168.3.22')),
    ChangeNotifierProvider(
      create: (context) => TodosRepositoryRemote(apiClient: context.read()) as TodosRepository,
    ),
    ..._sharedProviders,
  ];
}

List<SingleChildWidget> get providersLocal {
  return [
    ChangeNotifierProvider(create: (context) => TodosRepositoryDev() as TodosRepository),
    ..._sharedProviders,
  ];
}

List<SingleChildWidget> get _sharedProviders {
  return [Provider(create: (context) => TodoUpdateUseCase(todosRepository: context.read()))];
}
