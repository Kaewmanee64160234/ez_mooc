import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<Search_Controller> {
  SearchView({Key? key}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Column(
        children: [
          // Search input field
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter search term',
              suffixIcon: GestureDetector(
                onTap: () {
                  _performSearch();
                },
                child: Icon(Icons.search),
              ),
            ),
            onSubmitted: (value) => _performSearch(),
          ),
          SizedBox(height: 10),
          // Display recent searches
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: controller.recentSearches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.history),
                      title: Text(controller.recentSearches[index]),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // Implement action on tapping a recent search item, if needed
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    String searchQuery = textEditingController.text;
    if (searchQuery.isNotEmpty &&
        !controller.recentSearches.contains(searchQuery)) {
      controller.saveSearch(searchQuery);
      print('Search query: $searchQuery'); // Debugging line
      textEditingController.clear(); // Clearing the text field after search
    }
  }
}
