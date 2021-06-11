import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cubipool2/injection_container.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/profile/domain/entities/reward.dart';
import 'package:cubipool2/modules/profile/domain/usecases/get_available_rewards.dart';

class RewardsPage extends StatefulWidget {
  RewardsPage({Key? key}) : super(key: key);

  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  bool _hasFetchDataError = false;
  bool _isLoading = true;
  int _availablePoints = 0;
  List<Reward> _rewards = [];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _fetchRewards();
    });
    super.initState();
  }

  Future _fetchRewards() async {
    setState(() => _isLoading = true);

    final useCase = injector.get<GetAvailableRewards>();
    final either = await useCase.execute(NoParams());
    either.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hubo un error al obtener los datos')),
        );
        _hasFetchDataError = true;
      },
      (data) {
        _availablePoints = data.availablePoints;
        _rewards = data.rewards;
      },
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recompensas')),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            SvgPicture.asset(
              'assets/logos/reward.svg',
              semanticsLabel: 'Acme Logo',
              height: 96,
            ),
            const SizedBox(height: 8),
            const Text('Disponible'),
            Text(
              '$_availablePoints Puntos',
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text('¿Qué podría canjear con mis puntos?'),
            const SizedBox(height: 32),
            if (_isLoading) CircularProgressIndicator(),
            if (_hasFetchDataError) _buildFetchRewardsButton(),
            Expanded(child: _buildRewards(_rewards)),
          ],
        ),
      ),
    );
  }

  Widget _buildFetchRewardsButton() {
    return ElevatedButton(
      child: Text('Volver a cargar'),
      onPressed: () {
        setState(() {
          _hasFetchDataError = false;
        });
        _fetchRewards();
      },
    );
  }

  Widget _buildRewards(List<Reward> rewards) {
    return ListView.separated(
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        return _buildRewardCard(rewards[index]);
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget _buildRewardCard(Reward reward) {
    return ListTile(
      leading: Image.network(reward.imageUrl),
      title: RichText(
        text: TextSpan(
          text: '${reward.name} ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: '(${reward.points} puntos)',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reward.description),
          ElevatedButton(
            child: Text('Canjear', style: TextStyle(fontSize: 14)),
            style: TextButton.styleFrom(
              shape: StadiumBorder(),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            ),
            onPressed: () {
              // TODO: Add actions
            },
          ),
        ],
      ),
    );
  }
}
