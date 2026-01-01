import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/routes/app_routes.dart';
import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import 'filter_page.dart';
import '../../domain/usecases/filter_doctors_usecase.dart';

class GlobalSearchPage extends StatelessWidget {
  const GlobalSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: const _GlobalSearchPageView(),
    );
  }
}

class _GlobalSearchPageView extends StatelessWidget {
  const _GlobalSearchPageView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: false,
          decoration: const InputDecoration(
            hintText: 'Search doctors, specialties...',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            context.read<SearchBloc>().add(SearchQueryChanged(query));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              final currentFilters =
                  context.read<SearchBloc>().state.filters ?? FilterParams();
              final result = await Navigator.push<FilterParams>(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FilterPage(initialFilters: currentFilters),
                ),
              );
              if (result != null && context.mounted) {
                context.read<SearchBloc>().add(SearchFilterApplied(result));
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.status == SearchStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == SearchStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred'),
            );
          }

          if (state.status == SearchStatus.success && state.doctors.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No doctors found',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (state.status == SearchStatus.initial) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Search for your preferred doctor',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.doctors.length,
            itemBuilder: (context, index) {
              final doctor = state.doctors[index];
              return Card(
                elevation: 0,
                color: colorScheme.surfaceContainerLow,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Hero(
                    tag: 'doctor_${doctor.id}',
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(doctor.profileImageUrl),
                    ),
                  ),
                  title: Text(
                    doctor.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.category.name,
                        style: TextStyle(color: colorScheme.primary),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber[700]),
                          const SizedBox(width: 4),
                          Text(
                            '${doctor.rating} (${doctor.reviewCount} reviews)',
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () => context.pushNamed(
                    AppRoutes.doctorDetails,
                    pathParameters: {'doctorId': doctor.id},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
