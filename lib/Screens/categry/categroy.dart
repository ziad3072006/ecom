import 'package:ecomorse/Screens/categry/allproduct.dart';
import 'package:ecomorse/Screens/details_screen.dart';
import 'package:ecomorse/constants/AppConstants.dart';
import 'package:ecomorse/model/get_form_api.dart';
import 'package:flutter/material.dart';
import 'package:ecomorse/Widget/widget_i_need_it.dart';


class Category extends StatefulWidget {
  final Function(String) onSelected;

  const Category({super.key, required this.onSelected});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: electronicsandjewelery.map((cat) {
                return Flexible(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategoryLevel2 = cat;
                      });
                      // widget.onSelected(cat);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AnimatedContainer(
                        height: 45,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: selectedCategoryLevel2 != cat
                              ? Border.all(color: Colors.black12)
                              : Border.all(color: white),
                          color: selectedCategoryLevel2 == cat ? blue : white,
                        ),
                        duration: const Duration(milliseconds: 500),
                        child: Center(
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: selectedCategoryLevel2 == cat
                                  ? Colors.white
                                  : black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Size(
            h: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: FutureBuilder(
                future: selectedCategoryLevel2 == 'Jewelery'
                    ? funGetJewelery('j')
                    : funGetJewelery('e'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: listOfJeEleMenWomen.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = listOfJeEleMenWomen[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(id: product.id!)));
                          },
                          child: ProductCard(product: product),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Error loading products'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}