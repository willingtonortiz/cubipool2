import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cubipool2/injection_container.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/profile/domain/usecases/share_cubicle.dart';
import 'package:cubipool2/shared/widgets/notification_dialog.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';

class ShareCubiclePage extends StatefulWidget {
  final Reservation reservation;
  final VoidCallback onSuccess;

  ShareCubiclePage({
    Key? key,
    required this.reservation,
    required this.onSuccess,
  }) : super(key: key);

  @override
  _ShareCubiclePageState createState() => _ShareCubiclePageState();
}

class _ShareCubiclePageState extends State<ShareCubiclePage> {
  final descriptionController = TextEditingController(text: 'a' * 255);
  int? _selectedSeats;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compartir cubículo')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                _buildSeatsCountDropdown(widget.reservation),
                const SizedBox(height: 32),
                _buildDescriptionInput(),
                const SizedBox(height: 32),
                _isLoading
                    ? CircularProgressIndicator()
                    : _buildPublishButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeatsCountDropdown(Reservation reservation) {
    final totalSeats = reservation.seats;
    const int USED_SEATS = 2;
    final remainingSeats = totalSeats - USED_SEATS;
    final seatsCount = List.generate(remainingSeats, (index) => index + 1);

    return Row(
      children: [
        Icon(Icons.person),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Cantidad de asientos'),
            value: _selectedSeats,
            underline: Container(
              height: 2,
              color: Theme.of(context).primaryColor,
            ),
            onChanged: (int? item) {
              setState(() => _selectedSeats = item);
            },
            items: seatsCount
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text('${item.toString()} asientos'),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionInput() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(256),
      ],
      controller: descriptionController,
      keyboardType: TextInputType.multiline,
      minLines: 5,
      maxLines: null,
      decoration: InputDecoration(
        labelText: 'Descripción...',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }

  Widget _buildPublishButton() {
    return ElevatedButton(
      onPressed: () async {
        final description = descriptionController.text.trim();
        if (_selectedSeats == null || description.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Debes completar los campos')),
          );
          return;
        }

        setState(() => _isLoading = true);
        final useCase = injector.get<ShareCubicle>();
        final either = await useCase.execute(ShareCubicleParams(
          reservationId: widget.reservation.id,
          description: description,
          sharedSeats: _selectedSeats!,
        ));
        setState(() => _isLoading = false);

        either.fold(
          (failure) {
            if (failure is ServerFailure) {
              showSharedCubicleFailureSnackbar(context, failure.firstError);
            }
          },
          (r) => showSharedCubicleDialog(context),
        );
      },
      child: const Text('Publicar'),
    );
  }

  void showSharedCubicleFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showSharedCubicleDialog(BuildContext context) async {
    final dialog = NotificationDialog(
      title: 'Cubículo compartido',
      content: 'Tu cubículo se ha compartido exitosamente',
      okText: 'Entiendo',
      onOk: () async {
        Navigator.of(context).pop();
        widget.onSuccess();
      },
    );

    await showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }
}
