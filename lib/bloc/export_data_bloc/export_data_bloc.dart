import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:flutter_app/bloc/edit_account_bloc/edit_account_bloc_export.dart';
import 'package:flutter_app/bloc/export_data_bloc/export_data_bloc_event.dart';
import 'package:flutter_app/bloc/export_data_bloc/export_data_bloc_export.dart';
import 'package:flutter_app/db/dao/record_db.dart';
import 'package:flutter_app/model/db_response.dart';
import 'package:flutter_app/model/req/export_req.dart';
import 'package:flutter_app/repositories/account_respository.dart';
import 'package:flutter_app/repositories/record_respository.dart';
import 'package:flutter_app/tool/time_tool.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class ExportDataBloc extends Bloc<ExportDataBlocEvent, ExportDataBlocState>
{
  @override
  ExportDataBlocState get initialState {
    return ExportDataBlocUnInitializedState();
  }

  @override
  Stream<ExportDataBlocState> mapEventToState(ExportDataBlocEvent event) async*{
    if (!(state is ExportDataBlocLoadingState)) {
      if (event is ExportDataBlocQueryEvent) {
        yield ExportDataBlocLoadingState();
        try {
          DBResponse dbResponse = await RecordRespository.queryByTime(event.startYear, event.startMonth, event.endYear, event.endMonth);
          if (dbResponse.result == true) {
            List<List<String>> list = new List();
            List<String> names = new List();
            names.add("year");
            names.add("month");
            names.add("day");
            names.add("name");
            names.add("amount");
            names.add("unit");
            names.add("main amount");
            names.add("main unit");
            names.add("account");
            names.add("remark");
            names.add("time");
            list.add(names);
            List<ExportReq> exportReqs = dbResponse.data;
            for(int i = 0; i < exportReqs.length; i++){
              List<String> tmp = new List();
              tmp.add(exportReqs[i].year);
              tmp.add(exportReqs[i].month);
              tmp.add(exportReqs[i].day);
              tmp.add(exportReqs[i].name);
              tmp.add(exportReqs[i].amount);
              tmp.add(exportReqs[i].unit);
              tmp.add(exportReqs[i].mainAmount);
              tmp.add(exportReqs[i].mainUint);
              tmp.add(exportReqs[i].amount);
              tmp.add(exportReqs[i].remark);
              tmp.add(exportReqs[i].time);
              list.add(tmp);
            }
            final res = const ListToCsvConverter().convert(list);
            String dir = (await getTemporaryDirectory()).path;
            String fileName = "TwoTiny_" + TimeTool.customFormatTime_YYYY_MM_DD(DateTime.now().millisecondsSinceEpoch);
            File file = new File('$dir/$fileName.csv');
            await file.writeAsString(res);
//            launch("mailto:smith@example.org?subject=News&body=New%20plugin");

            final Email email = Email(
              body: 'TwoTiny Data Export',
              subject: "TwoTiny " + event.startYear.toString() + "/" + event.startMonth.toString() + "-" + event.endYear.toString() + "/" + event.endMonth.toString(),
              recipients: [event.email],
              attachmentPaths: ['$dir/$fileName.csv'],
              isHTML: false,
            );

            await FlutterEmailSender.send(email);
            yield ExportDataBlocQuerySuccessState();

          } else {
            yield ExportDataBlocFailedState(dbResponse.message);
          }
        } catch (e) {
          yield ExportDataBlocFailedState(e.toString());
        }
      }
    }
  }
}