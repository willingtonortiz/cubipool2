import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cubipool2/injection_container.dart';
import 'package:cubipool2/modules/search/domain/usecases/search_all_publications.dart';
import 'package:cubipool2/modules/search/domain/usecases/get_all_campus.dart';
import 'package:cubipool2/modules/search/presentation/provider/search_publication_state.dart';

final getAllCampus = injector.get<GetAllCampusPublications>();
final getAllPublications = injector.get<SearchAllPublications>();

final getAllCampusProvider = Provider<GetAllCampusPublications>((ref) => getAllCampus);
final getAllPublicationsProvider =
    Provider<SearchAllPublications>((ref) => getAllPublications);

final publicationNotifierProvider = StateNotifierProvider(
  (ref) => PublicationNotifier(
    ref.watch(getAllCampusProvider),
    ref.watch(getAllPublicationsProvider),
  ),
);
