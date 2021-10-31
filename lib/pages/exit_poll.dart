import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:election_exit_poll_07610461/services/api.dart';
import 'package:election_exit_poll_07610461/pages/candidate.dart';
import 'package:election_exit_poll_07610461/pages/candi_list.dart';

class exitPoll extends StatefulWidget {
  const exitPoll({Key? key}) : super(key: key);

  @override
  _exitPollState createState() => _exitPollState();
}

class _exitPollState extends State<exitPoll> {
  late Future<List<Candidate>> _futureCandiList;

  @override
  void initState() {
    super.initState();
    _futureCandiList = _loadCandi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
              ),
              Image.asset(
                'assets/images/vote_hand.png',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'EXIT POLL',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
              ),
              Text(
                'เลือกตั้ง อบต.',
                style: GoogleFonts.sarabun(
                  textStyle: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(9.0),
              ),
              Text(
                'รายชื่อผู้สมัครรับเลือกตั้ง',
                style: GoogleFonts.sarabun(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                'นายกองค์การบริหารส่วนตำบลเขาพระ',
                style: GoogleFonts.sarabun(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                'อำเภอเมืองนครนายก จังหวัดนครนายก',
                style: GoogleFonts.sarabun(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget build2 () {
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
                var candi = candiList[index];

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
                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      candi.candidateNumber.toString(),
                                      style: GoogleFonts.prompt(fontSize: 20.0),
                                    ),
                                    Text(
                                      candi.candidateTitle.toString(),
                                      style: GoogleFonts.prompt(fontSize: 20.0),
                                    ),
                                    Text(
                                      candi.candidateFirstName.toString(),
                                      style: GoogleFonts.prompt(fontSize: 20.0),
                                    ),
                                    Text(
                                      candi.candidateLastName.toString(),
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
}
