import 'package:cubipool2/modules/shared/widgets/async_confirmation_dialog.dart';
import 'package:cubipool2/modules/shared/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';

class ReservationResultsPage extends StatefulWidget {
  ReservationResultsPage({Key? key}) : super(key: key);

  @override
  _ReservationResultsPageState createState() => _ReservationResultsPageState();
}

class _ReservationResultsPageState extends State<ReservationResultsPage> {
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
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (_, index) => _buildCubicle(index + 1),
                  // separatorBuilder: (_a, _b) => Divider(),
                ),
              ),
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
          label: Text('Campus Villa'),
          labelPadding: padding,
        ),
        Chip(
          label: Text('10:00 - 11:00'),
          labelPadding: padding,
        ),
      ],
    );
  }

  Widget _buildCubicle(int index) {
    return InkWell(
      onTap: () {
        print(index);
        showNotificationDialog();
        // showConfirmationDialog();
      },
      child: Card(
        // elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.tab_outlined),
                        const SizedBox(width: 8.0),
                        Text('Cubículo 103'),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(Icons.watch_later_outlined),
                        const SizedBox(width: 8.0),
                        Text('10:15 - 11:00'),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Estaremos estudiando para la 3ra PC de cálculo 5, te esperamos',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }

  void showNotificationDialog() {
    final alert = NotificationDialog(
      title: '¿Estas seguro de querer continuar?',
      // content: 'No hay marcha atrás!!!',
      onOk: () {
        print('');
      },
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => alert,
    );
  }

  void showConfirmationDialog() {
    final alert = AsyncConfirmationDialog(
      title: '¿Estas seguro de querer continuar?',
      // content: 'No hay marcha atrás!!!',
      onOk: () async {
        await Future.delayed(Duration(seconds: 2));
      },
      onCancel: () async {
        await Future.delayed(Duration(seconds: 2));
      },
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => alert,
    );
  }
}
