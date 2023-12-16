import 'package:ez_mooc/services/vdo_detail_service.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _performSearch();
                    print(
                        'Search query: ${textEditingController.text}'); // Debugging line
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                ),
              ),
              controller: textEditingController,
              onSubmitted: (value) {
                _performSearch();
              },
            ),
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
                        textEditingController.text =
                            controller.recentSearches[index];
                        // Implement
                        //action on tapping a recent search item, if needed
                        _performSearch();
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performSearch() async {
    String searchQuery = textEditingController.text;

    if (searchQuery.isNotEmpty &&
        !controller.recentSearches.contains(searchQuery)) {
      controller.saveSearch(searchQuery);

      textEditingController.clear(); // Clearing the text field after search
    }
    await Get.find<VdoDetailService>().getSearchVdo(searchQuery);

    Get.toNamed('/search-result');
  }
}
