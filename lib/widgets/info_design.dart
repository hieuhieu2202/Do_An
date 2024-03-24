import 'package:delivery_food/model/menus.dart';
import 'package:flutter/material.dart';



class InfoDesignWidget extends StatefulWidget {
  Menus? model;

  BuildContext? context;

  InfoDesignWidget(this.model, this.context);

  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          // decoration: BoxDecoration(
          //   color: Colors.red,
          // ),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.thumbnailURL!,
                height: 320,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                widget.model!.menuTitle!,
                style: const TextStyle(
                    color: Colors.cyan, fontSize: 20, fontFamily: "TrainOne"),
              ),
              Text(
                widget.model!.menuInfo!,
                style: const TextStyle(
                    color: Colors.grey, fontSize: 12, fontFamily: "TrainOne"),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
