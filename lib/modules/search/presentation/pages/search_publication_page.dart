import 'package:cubipool2/modules/search/domain/entities/campus.dart';
import 'package:cubipool2/modules/search/presentation/pages/publication_search_results_page.dart';
import 'package:cubipool2/modules/search/presentation/provider/providers.dart';
import 'package:cubipool2/modules/search/presentation/provider/search_publication_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const DEFAULT_RESERVATION_HOURS = [1, 2];

class PublicationPage extends StatefulWidget {
  PublicationPage({Key? key}) : super(key: key);

  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  Campus? _selectedCampus;
  int? _selectedHoursCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar cubículos compartidos'),
      ),
      body: SafeArea(
        child: _buildApp(),
      ),
    );
  }

  Widget _buildApp() {
    return ProviderListener<SearchPublicationsState>(
      provider: publicationNotifierProvider.state,
      onChange: (context, state) async {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is PublicationsFoundState) {
          Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => PublicationSearchResultsPage(
                publications: state.publications,
                campus: _selectedCampus!,
                hoursCount: _selectedHoursCount!,
              ),
            ),
          );

          context.read(publicationNotifierProvider).getInitialData();
        }
      },
      child: Consumer(
        builder: (context, watch, child) {
          final state = watch(publicationNotifierProvider.state);

          if (state is InitialState) {
            return _buildInitialState(context, state);
          } else if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildInitialState(
    BuildContext context,
    InitialState state,
  ) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 32.0),
          Image.asset('assets/logos/books.png'),
          const SizedBox(height: 32.0),
          _buildCampusDropdown(context, state.campus),
          const SizedBox(height: 16.0),
          _buildHoursCount(DEFAULT_RESERVATION_HOURS),
          const SizedBox(height: 16.0),
          _buildSearchButton(context),
        ],
      ),
    );
  }

  Widget _buildCampusDropdown(
    BuildContext context,
    List<Campus> campus,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: DropdownButton(
        isExpanded: true,
        hint: Text('Seleccione la sede'),
        value: _selectedCampus,
        underline: Container(
          height: 2,
          color: Theme.of(context).primaryColor,
        ),
        onChanged: (Campus? item) {
          setState(() {
            _selectedCampus = item;
          });
        },
        items: campus
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item.name),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildHoursCount(List<int> hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Cantidad de horas'),
          ...hours.map((hour) {
            return Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<int>(
                      groupValue: _selectedHoursCount,
                      value: hour,
                      onChanged: setHoursCount),
                  Text('$hour'),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void setHoursCount(int? value) {
    setState(() {
      _selectedHoursCount = value;
    });
  }

  Widget _buildSearchButton(BuildContext context) {
    return ElevatedButton(
      onPressed: hasAllOptionsSelected()
          ? () {
              context
                  .read(publicationNotifierProvider)
                  .searchPublications(_selectedCampus!, _selectedHoursCount!);
            }
          : null,
      child: Text('Buscar'),
    );
  }

  bool hasAllOptionsSelected() {
    return _selectedCampus != null && _selectedHoursCount != null;
  }
}
