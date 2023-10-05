import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/extensions/strings.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCloudBloc, UserCloudState>(
      builder: (context, state) {
        if (state is GetUserByIdResult && state.isSuccess) {
          final data = state.user;
          return _UserGreetings(data: data);
        }
        return const _UserGreetings(data: null);
      },
    );
  }
}

class _UserGreetings extends StatelessWidget {
  const _UserGreetings({
    required this.data,
  });

  final User? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              NetworkImage(data?.imageUrl ?? AssetConts.imageUserDefault),
          radius: 25.0,
        ),
        const SizedBox(
          width: 15,
        ),
        Text((data?.role ?? "No Role").getGreetingBasedOnTime()),
      ],
    );
  }
}
