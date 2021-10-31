import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:election_exit_poll_07610461/pages/candidate.dart';
import 'package:election_exit_poll_07610461/services/api.dart';
import 'package:google_fonts/google_fonts.dart';
class candiList extends StatefulWidget {
  const candiList({Key? key}) : super(key: key);

  @override
  _candiListState createState() => _candiListState();
}

class _candiListState extends State<candiList> {

  late Future<List<Candidate>> _futureCandiList;

  @override
  void initState() {
    super.initState();
    _futureCandiList = _loadCandi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.deepPurple.shade100,
      child: FutureBuilder<List<Candidate>>(
        future: _futureCandiList,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {//ถ้าข้อมูลยังมาไม่สมบูรณ์
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var candiList = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: candiList!.length,
              itemBuilder: (BuildContext context, int index) {
                var Candi = candiList[index];

                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: InkWell(
                    //onTap: () => _handleClickFoodItem(Candi),
                    child: Row(
                      children: <Widget>[

                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      Candi.candidateNumber.toString(),
                                      style: GoogleFonts.prompt(fontSize: 20.0),
                                    ),
                                    Text(
                                      Candi.candidateTitle.toString(),
                                      style: GoogleFonts.prompt(fontSize: 20.0),
                                    ),
                                    Text(
                                      Candi.candidateFirstName.toString(),
                                      style: GoogleFonts.prompt(fontSize: 20.0),
                                    ),
                                    Text(
                                      Candi.candidateLastName.toString(),
                                      style: GoogleFonts.prompt(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<List<Candidate>> _loadCandi() async {
    List list = await Api().fetch('Candidate');
    var CandiList = list.map((item) => Candidate.fromJson(item)).toList();
    return CandiList;
  }



  /*_handleClickFoodItem(Candidate Candi) {
    Navigator.pushNamed(
      context,
      FoodDetail.routeName,
      arguments: Candi,
    );

  }*/
}
