import 'package:flutter/material.dart';
import 'package:flutter24/apis/ecommerce/data_source/local/app_shared_preferences.dart';
import 'package:flutter24/apis/ecommerce/features/home/cubit/e_home_cubit.dart';
import 'package:flutter24/apis/ecommerce/features/login/view/e_login_screen.dart';
import 'package:flutter24/apis/ecommerce/models/EHomeResponse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EHomeScreen extends StatefulWidget {
  const EHomeScreen({super.key});

  @override
  State<EHomeScreen> createState() => _EHomeScreenState();
}

class _EHomeScreenState extends State<EHomeScreen> {
  final cubit = EHomeCubit();

  @override
  void initState() {
    super.initState();
    cubit.getHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<EHomeCubit, EHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: state is EGetHomeSuccessState
                ? Container(
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 25.h,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount:
                        //         (state.data['banners'] as List<dynamic>).length,
                        //     itemBuilder: (context, index) {
                        //       String image = (state.data['banners']
                        //           as List<dynamic>)[index]['image'];
                        //       return Container(
                        //         margin: EdgeInsets.all(10.sp),
                        //         child: Image.network(image),
                        //       );
                        //     },
                        //   ),
                        // ),
                        // SizedBox(height: 10.sp),
                        SizedBox(
                          height: 25.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.homeData.banners.length,
                            itemBuilder: (context, index) {
                              String image =
                                  cubit.homeData.banners[index].image;
                              return Container(
                                margin: EdgeInsets.all(10.sp),
                                child: Image.network(image),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: cubit.homeData.products.length,
                            itemBuilder: (context, index) {
                              Products product = cubit.homeData.products[index];

                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(10.sp),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.sp)),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.sp),
                                        topRight: Radius.circular(25.sp),
                                      ),
                                      child: Image.network(
                                        product.image,
                                        height: 25.h,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(product.name),
                                    Text("${product.price} EGP"),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
