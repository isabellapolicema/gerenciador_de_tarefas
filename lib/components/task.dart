import 'package:flutter/material.dart';
import 'package:primeiro_projeto_flutter/components/difficulty.dart';

class Tasks extends StatefulWidget {
  final String name;
  final String photo;
  final int difficulty;



  const Tasks(this.name, this.photo, this.difficulty, {Key? key})
      : super(key: key);

//
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int level = 1;
  int dificCounter = 0;

  void levelUp(){
    setState((){
      level++;
      if(((level/widget.difficulty)/10)>=1){
        dificCounter++;
        level = 0;
      }
    });
  }

  Color colorSet() {
    if (dificCounter == 1) {
      return const Color.fromARGB(255, 152, 108, 229);
    } else if (dificCounter == 2) {
      return const Color.fromARGB(255, 79, 17, 93);
    } else if (dificCounter >= 3) {
      return const Color.fromARGB(255, 77, 76, 84);
    } else {
      return Colors.blue;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: colorSet(),
            ),
            height: 140,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black12,
                      ),
                      // width: 72,
                      // height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          widget.photo,
                          height: 100,
                          width: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                                fontSize: 16, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Difficulty(difficultyLevel: widget.difficulty,),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 52,
                        width: 62,
                        child: ElevatedButton(
                          onPressed: levelUp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'Upar',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.difficulty > 0)
                            ? ((level/widget.difficulty) / 10)
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nível: $level',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              )
                 // : const Text ('Proeficiente!', style: TextStyle(color:Colors.white)),

            ],
          ),
        ],
      ),
    );
  }
}
