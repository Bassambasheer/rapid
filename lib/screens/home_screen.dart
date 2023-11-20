import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rapidd_technologies/Utils/context_extension.dart';
import 'package:rapidd_technologies/Utils/model/data_model.dart';
import 'package:rapidd_technologies/Utils/utils.dart';
import 'package:rapidd_technologies/riverpods/data_pod.dart';
import 'package:rapidd_technologies/screens/add_data_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataNotifier = ref.watch(dataProvider);
    dataNotifier.getData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () {
            context.navigateToScreen(child: AddData());
          },
          child: Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 204, 240),
                borderRadius: BorderRadius.circular(25)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Icon(Icons.add)
                ],
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<Data>>(
          stream: dataNotifier.getData(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      context.navigateToScreen(
                          child: AddData(
                        isEdit: true,
                        data: snapshot.data![index],
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 79, 80, 81),
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name :  ${snapshot.data![index].name ?? ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Designation : ${snapshot.data![index].designation ?? ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                dataNotifier
                                    .deleteData(snapshot.data![index].id ?? '')
                                    .then((value) {
                                  Utils.showToast('Data deleted Successfully');
                                }).catchError((e) {
                                  Utils.showErrorToast('Something went wrong');
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
