import 'package:flutter/material.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/injection_container.dart';
import 'package:cubipool2/modules/profile/domain/usecases/get_points_history.dart';
import 'package:cubipool2/modules/profile/domain/entities/point_history.dart';
import 'package:intl/intl.dart';

class PointsHistoryPage extends StatefulWidget {
  const PointsHistoryPage({Key? key}) : super(key: key);

  @override
  _PointsHistoryPageState createState() => _PointsHistoryPageState();
}

class _PointsHistoryPageState extends State<PointsHistoryPage> {
  bool _isLoading = true;
  List<PointHistory> _points = [];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      fetchPointsHistory(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de puntos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildPointsHistoryList(),
          )
        ],
      ),
    );
  }

  Widget _buildPointsHistoryList() {
    if (_points.isEmpty) {
      return Center(
        child: Text('No hay historial de puntos'),
      );
    }
    return ListView.separated(
      itemCount: _points.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        return _buildPointsHistoryItem(_points[index]);
      },
    );
  }

  Widget _buildPointsHistoryItem(PointHistory point) {
    final formatter = DateFormat('dd/MM/yyyy');
    final date = DateTime.parse(point.date).toLocal();
    final parsedDate = formatter.format(date);

    return ListTile(
      title: Text(
        point.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPointsColor(point.points),
          const SizedBox(height: 4),
          Text('$parsedDate'),
        ],
      ),
    );
  }

  Widget _buildPointsColor(int points) {
    final color = points >= 0 ? Colors.green : Colors.red;
    final addPlus = points > 0 ? '+' : '';
    return Text(
      '$addPlus$points puntos',
      style: TextStyle(color: color),
    );
  }

  Future<void> fetchPointsHistory(BuildContext context) async {
    final useCase = injector.get<GetPointsHistory>();
    final either = await useCase.execute(NoParams());
    either.fold(
      (failure) {
        if (failure is ServerFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(failure.firstError),
              backgroundColor: Colors.red,
            ));
        }
      },
      (points) {
        setState(() {
          _points = points;
        });
      },
    );

    setState(() {
      _isLoading = false;
    });
  }
}
