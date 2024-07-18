import 'package:flutter/material.dart';
import 'package:project/ServerData/FunctionsRequest.dart';
import 'package:project/ServerData/UpdatePage.dart';
import 'package:project/ServerData/model.dart';
import 'package:project/ServerData/widget/DeleteItemAndMoveLeftAndRight.dart';
import 'package:project/ServerData/widget/createButton.dart';

class DataFromServer extends StatefulWidget {
  const DataFromServer({super.key});

  @override
  State<DataFromServer> createState() => _RequestToServerState();
}

class _RequestToServerState extends State<DataFromServer> {
  Repository repository = Repository();
  late final User user;

  //! For searching
  late TextEditingController searchController;

  //! List to hold all users data from the API
  List<User> listPerson = [];

  //! List for filtered data based on search query
  List<User> filteredList = [];

  //! Initialize filtered list with all data
  getData({String? searchQuery}) async {
    try {
      listPerson = await repository.getData(searchQuery: searchQuery);
      filteredList = listPerson;
    } catch (e) {
      print('Error fetching data: $e');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Initialize search controller
    searchController = TextEditingController();
    getData();
  }

  //! Function to update the list based on search query
  void updateList(String val) {
    setState(() {
      if (val.isEmpty) {
        filteredList = listPerson;
      } else {
        filteredList = listPerson
            .where((element) => element.name
                .toString()
                .toLowerCase()
                .contains(val.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Http"),
      ),
      body: Column(
        children: [
          //! Search TextField
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 108, 17, 255),
                  ),
                ),
              ),
              onChanged: (value) {
                //! Update the list based on search query
                updateList(value);
              },
            ),
          ),
          //! List of Users
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                User user = filteredList[index];
                //! Navigate to UpdatePage when user item is tapped
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePageFromServer(
                          user: user,
                          // similarity:
                          //     user.similarity, // Pass similarity as an argument
                        ),
                        settings: RouteSettings(
                          arguments: [
                            user.id.toString(),
                            user.name,
                            user.address.city,
                            user.address.street,
                            user.address.geo.lat.toString(),
                            user.address.geo.lng.toString(),
                            user.date, // Pass date as an argument
                            user.time, // Pass time as an argument
                            user.similarity, // Pass similarity as an argument
                          ],
                        ),
                      ),
                    );
                  },

                  //! Widget to handle deletion and swiping of user item
                  child: DeleteCardAndMoveLeftAndRight(user, context),
                );
              },
            ),
          ),
        ],
      ),
      //! Button to navigate to create page
      floatingActionButton: floatingButton(),
    );
  }
}
