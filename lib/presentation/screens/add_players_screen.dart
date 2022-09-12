import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q8intouch_task/business_logic/users_cubit/users_cubit.dart';
import 'package:q8intouch_task/data/models/mapper_models/users_model.dart';
import 'package:q8intouch_task/presentation/screens/components/saved_item.dart';
import 'package:q8intouch_task/presentation/widgets/app_loader.dart';
import 'package:q8intouch_task/presentation/widgets/custom_btn.dart';
import 'package:q8intouch_task/presentation/widgets/custom_text_field.dart';

import 'components/player_item.dart';

class AddPlayersScreen extends StatefulWidget {
  const AddPlayersScreen({Key? key}) : super(key: key);

  @override
  State<AddPlayersScreen> createState() => _AddPlayersScreenState();
}

class _AddPlayersScreenState extends State<AddPlayersScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    context.read<UsersCubit>().getUsers();
    context.read<UsersCubit>().controller = ScrollController()
      ..addListener(context.read<UsersCubit>().getNextUsers);
    super.initState();
  }

  @override
  void dispose() {
    context.read<UsersCubit>().users.clear();
    context
        .read<UsersCubit>()
        .controller
        .removeListener(context.read<UsersCubit>().getNextUsers);
    context.read<UsersCubit>().controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text(
          'Add players',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UsersLoaded) {
            UsersModel model = state.model as UsersModel;
            for (var element in model.users!) {
              context.read<UsersCubit>().users.add(element);
            }
          }
        },
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //top list view
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: context.watch<UsersCubit>().savedUsers.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  image: DecorationImage(
                                      image: NetworkImage(context
                                          .read<UsersCubit>()
                                          .savedUsers[index]
                                          .image!)),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              //remove button
                              if (context
                                          .watch<UsersCubit>()
                                          .savedUsers
                                          .length >
                                      1 &&
                                  index > 0)
                                Positioned(
                                    top: 5,
                                    right: 10,
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<UsersCubit>()
                                            .removeSavedItem(index);
                                      },
                                      child: const CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      ),
                                    )),
                            ],
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${context.read<UsersCubit>().savedUsers[index].firstName} ${context.read<UsersCubit>().savedUsers[index].lastName}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                CustomTextField(
                  controller: _searchController,
                  fillColor: Colors.grey.withOpacity(0.3),
                  hint: 'Search by player name',
                  hintColor: Colors.grey,
                  hintSize: 14,
                  perfixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                  radius: 50,
                  onSubmit: (value) {
                    context.read<UsersCubit>().search(value);
                    _searchController.clear();
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: context.watch<UsersCubit>().controller,
                    itemCount: context.watch<UsersCubit>().users.length,
                    itemBuilder: (context, index) {
                      return PlayerItem(
                        imageUrl:
                            context.read<UsersCubit>().users[index].image!,
                        name:
                            '${context.read<UsersCubit>().users[index].firstName} ${context.read<UsersCubit>().users[index].lastName}',
                        onTap: () {
                          context.read<UsersCubit>().toggleAddButton(index);
                        },
                        buttonToggle:
                            context.watch<UsersCubit>().users[index].isAdded,
                      );
                    },
                  ),
                ),
                if (context.watch<UsersCubit>().isLoadMoreRunning)
                  const Center(
                    child: AppLoader(),
                  ),
                if (!context.watch<UsersCubit>().hasNextPage)
                  const Center(
                    child: Text(
                      'there\'s no more users',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 70,
        child: CustomBtn(
          radius: 40,
          text: 'Continue',
          onTap: () {},
        ),
      ),
    );
  }
}
