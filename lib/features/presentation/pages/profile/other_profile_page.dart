import 'package:final_project/common/consts/asset_conts.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/features/presentation/bloc/user_cloud/get_other_user/get_other_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherProfilePage extends StatefulWidget {
  static const route = '/other-profile';

  const OtherProfilePage({super.key, this.uid});

  final String? uid;

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  @override
  void initState() {
    super.initState();

    context
        .read<GetOtherUserBloc>()
        .add(GetOtherUserByIdEvent(uid: widget.uid ?? "-"));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GetOtherUserBloc, GetOtherUserState>(
        builder: (context, state) {
      if (state is GetOtherUserByIdLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is GetOtherUserByIdResult && state.isSuccess) {
        final data = state.user;
        return Scaffold(
          appBar: AppBar(
            title: Text("${data?.name ?? "Someone"}'s Profile"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        data?.imageUrl ?? AssetConts.imageUserDefault),
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        data?.name ?? "Unknown",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data?.role ?? "Unknown Role",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Registered at ${DateUtil.formatDate(data?.createdAt ?? DateTime.now().toString())}",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      }
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Something went wrong.'),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Back"))
            ],
          ),
        ),
      );
    });
  }
}
