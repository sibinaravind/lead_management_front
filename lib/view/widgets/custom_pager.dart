import 'package:flutter/material.dart';

import '../../../res/style/colors/colors.dart';

class CustomPager extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageSelected;

  const CustomPager({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomPagerState createState() => _CustomPagerState();
}

class _CustomPagerState extends State<CustomPager> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: widget.totalPages < 3 ? 200 : 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: IconButton(
                onPressed: widget.currentPage > 1
                    ? () => {_scrollTo(1), widget.onPageSelected(1)}
                    : null,
                icon: const Icon(Icons.first_page),
              ),
            ),
            FittedBox(
              child: IconButton(
                onPressed: widget.currentPage > 1
                    ? () => {
                          _scrollTo(widget.currentPage - 1),
                          widget.onPageSelected(widget.currentPage - 1)
                        }
                    : null,
                icon: const Icon(Icons.arrow_left),
              ),
            ),
            SizedBox(
              width: widget.totalPages < 3 ? 70 : 110,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int page = 1; page <= widget.totalPages; page++)
                      Material(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () => {
                            _scrollTo(page),
                            widget.onPageSelected(page),
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: page == widget.currentPage
                                    ? AppColors.buttonGraidentColour
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                page.toString(),
                                style: TextStyle(
                                  color: page == widget.currentPage
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: widget.currentPage < widget.totalPages
                    ? () => {
                          _scrollTo(widget.currentPage + 1),
                          widget.onPageSelected(widget.currentPage + 1)
                        }
                    : null,
                icon: const Icon(Icons.arrow_right),
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: widget.currentPage < widget.totalPages
                    ? () => {
                          _scrollTo(widget.totalPages),
                          widget.onPageSelected(widget.totalPages)
                        }
                    : null,
                icon: const Icon(Icons.last_page),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollTo(int page) {
    double position;
    if (page < 10) {
      position = page * 20.0;
    } else if (page < 20) {
      position = page * 38.0;
    } else if (page < 30) {
      position = page * 36.0;
    } else if (page < 60) {
      position = page * 38.0;
    } else if (page < 80) {
      position = page * 38.5;
    } else {
      position = page * 39.0;
    }

    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
