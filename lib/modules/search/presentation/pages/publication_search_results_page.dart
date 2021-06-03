import 'package:cubipool2/modules/search/domain/entities/publication.dart';
import 'package:cubipool2/shared/pages/not_found_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/modules/search/domain/entities/campus.dart';

import 'publication_detail_page.dart';

class PublicationSearchResultsPage extends StatelessWidget {
  final List<Publication> publications;
  final Campus campus;

  const PublicationSearchResultsPage({
    Key? key,
    required this.publications,
    required this.campus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado de búsqueda'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildChips(),
              _buildCubicleList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChips() {
    final padding = const EdgeInsets.symmetric(
      vertical: -2.0,
      horizontal: 4.0,
    );

    return Wrap(
      spacing: 8.0,
      children: [
        Chip(
          label: Text('Campus ${campus.name}'),
          labelPadding: padding,
        ),
      ],
    );
  }

  Widget _buildCubicleList(BuildContext context) {
    if (publications.isEmpty) {
      return Expanded(
        child:
            NotFoundPage.fromMonitaChina('No encontré cubiculos, lo siento...'),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: publications.length,
        itemBuilder: (_, index) => _buildCubicleListItem(
          context,
          publications[index],
        ),
      ),
    );
  }

  Widget _buildCubicleListItem(
    BuildContext context,
    Publication publication,
  ) {
    final formatter = DateFormat.Hm();
    final formattedStartHour = formatter.format(publication.startHour);
    final formattedEndHour = formatter.format(publication.endHour);

    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.tab_outlined),
                        const SizedBox(width: 8.0),
                        Text('Cubículo ${publication.cubicleCode}'),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(Icons.watch_later_outlined),
                        const SizedBox(width: 8.0),
                        Text('$formattedStartHour - $formattedEndHour'),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${publication.description}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
      onTap: () async {
        await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (context) => PublicationDetailPage(
              campus: campus,
              publication: publication,
            ),
          ),
        );
      },
    );
  }
}
