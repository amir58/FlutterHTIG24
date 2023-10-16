import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/apis/ecommerce/features/profile/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EProfileScreen extends StatefulWidget {
  const EProfileScreen({super.key});

  @override
  State<EProfileScreen> createState() => _EProfileScreenState();
}

class _EProfileScreenState extends State<EProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final cubit = ProfileCubit();

  @override
  void initState() {
    super.initState();
    cubit.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is GetProfileSuccessState) {
            nameController.text = cubit.profileData.name;
            phoneController.text = cubit.profileData.phone;
            emailController.text = cubit.profileData.email;
          }
        },
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    buildWhen: (previous, current) =>
                        current is GetProfileSuccessState,
                    builder: (context, state) {
                      return cubit.profileData.image.isEmpty
                          ? CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey[300],
                              child: const CircularProgressIndicator.adaptive(),
                            )
                          : CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(cubit.profileData.image),
                            );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      onPressed: () => update(),
                      child: const Text(
                        "Update",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void update() {
    cubit.updateProfile(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
    );
  }
}
