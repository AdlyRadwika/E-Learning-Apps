import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/extensions/strings.dart';
import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/user_cloud_bloc.dart';
import 'package:final_project/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarContent extends StatefulWidget {
  const AppBarContent({
    super.key,
  });

  @override
  State<AppBarContent> createState() => _AppBarContentState();
}

class _AppBarContentState extends State<AppBarContent> {
  final _storageService = locator<SecureStorageService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCloudBloc, UserCloudState>(
      builder: (context, state) {
        if (state is GetUserByIdResult && state.isSuccess) {
          final data = state.user;
          _storageService.saveUserData(user: data);
          UserConfigUtil.role = data?.role ?? "-";
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
