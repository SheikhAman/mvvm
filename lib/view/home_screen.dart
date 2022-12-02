import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// main e provider na declare korle aivabe object create kore use korbo
// method ta call korbo.
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchMovieListApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              userPreference.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: const Center(child: Text('Logout')),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, _) {
            switch (value.moviesList.status) {
              case Status.LOADING:
                return Center(
                    child: const CircularProgressIndicator(
                  color: Colors.blue,
                ));
              case Status.ERROR:
                return Center(child: Text(value.moviesList.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.moviesList.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          Utils.urlHttpsConvert(
                            value.moviesList.data![index].poster.toString(),
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                              value.moviesList.data![index].images!.first
                                  .toString(),
                            );
                          },
                        ),
                        title: Text(
                            value.moviesList.data![index].title.toString()),
                        subtitle:
                            Text(value.moviesList.data![index].year.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(value.moviesList.data![index].imdbRating
                                .toString()),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
