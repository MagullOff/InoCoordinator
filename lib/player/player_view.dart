import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/components.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'package:ino_coordinator/player/player_bloc.dart';
import 'package:ino_coordinator/player/player_repository.dart';
import 'package:ino_coordinator/player/player_stats.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return SafeArea(
      child: BlocProvider(
          create: (context) {
            var sesstionCubit = context.read<SessionCubit>();
            return PlayerBloc(
                sessionCubit: sesstionCubit,
                playerRepo: context.read<PlayerRepository>(),
                playerCredentials: sesstionCubit.playerCredentials)
              ..add(GetPlayerStats());
          },
          child: BlocListener<PlayerBloc, PlayerState>(
            listener: ((context, state) {
              if (state is PlayerError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            }),
            child: BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                if (state is PlayerLoading) {
                  return _buildLoading();
                } else if (state is PlayerLoaded) {
                  return _buildCard(context, state.stats);
                } else if (state is PlayerError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          )),
    );
  }

  Widget _buildCard(BuildContext context, PlayerStats model) {
    return Scaffold(
      floatingActionButton: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 104, 159, 56),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.qr_code_2,
            size: 40,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTitle(context, model.name),
            _buildCapturePercentage(context, model.capturePercentage),
            _buildList(context, model.pointList)
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    );
  }

  Widget _buildCapturePercentage(BuildContext context, int capturePercentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 10,
            color: Color.fromARGB(255, 104, 159, 56),
          ),
        ),
        child: Center(
            child: Text('$capturePercentage%\ncomplete',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<PointStats> list) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        physics: ScrollPhysics(parent: null),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          var textColor = list[index].date == null
              ? Color.fromARGB(255, 55, 55, 55)
              : Color.fromARGB(255, 104, 159, 56);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: list[index].date == null
                      ? Colors.white
                      : Color.fromARGB(255, 240, 248, 233),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(64, 0, 0, 0),
                        spreadRadius: 2,
                        blurRadius: 4)
                  ],
                ),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        list[index].date == null ? Icons.close : Icons.done,
                        color: textColor,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'Captured by ${list[index].capturePercentage}% of players',
                    style: TextStyle(color: textColor),
                  ),
                  title: Text(list[index].name,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  trailing: Text(list[index].date ?? '',
                      style: TextStyle(color: textColor)),
                )),
          );
        },
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
