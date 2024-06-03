import 'package:flutter/material.dart';
import 'blurred_box.dart';

// ignore: must_be_immutable
class SelectableThumbnailGrid extends StatefulWidget {
  SelectableThumbnailGrid({this.selectedThumbnail = 0, required this.list });

  int selectedThumbnail; List<AssetImage> list;

  int getThumbnail() {
    return selectedThumbnail;
  }

  @override
  State<SelectableThumbnailGrid> createState() =>
      _SelectableThumbnailGridState();
}

class _SelectableThumbnailGridState extends State<SelectableThumbnailGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 3,
              childAspectRatio:
                  2, //MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedThumbnail = index;
                    });
                  },
                  child: Card(
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: widget.list[index],
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                          height: 200,
                          width: 200,
                          child: widget.selectedThumbnail == index
                              ? BlurredBox(
                                  borderRadius: BorderRadius.circular(10),
                                  sigma: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(100, 0, 0, 0)),
                                    child: Center(
                                      child: ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (Rect bounds) =>
                                            const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          
                                          colors: [
                                            
                                            Colors.lightBlue,
                                            Colors.pink,
                                            Colors.yellow,
                                            
                                          ],
                                          stops: [ .2,.6, .8],
                                        ).createShader(bounds),
                                        child: Icon(
                                          Icons.check_circle_outline,
                                          size: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 35
                                              : 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox())));
            }));
  }
}
