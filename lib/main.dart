import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SfDataGridDemo()));
}

class SfDataGridDemo extends StatefulWidget {
  const SfDataGridDemo({Key? key}) : super(key: key);

  @override
  SfDataGridDemoState createState() => SfDataGridDemoState();
}

class SfDataGridDemoState extends State<SfDataGridDemo> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter SfDataGrid'),
        ),
        body: SfDataGrid(
            source: _employeeDataSource,
            columns: getColumns,
            columnWidthMode: ColumnWidthMode.fill,
            onCellTap: ((details) {
              if (details.rowColumnIndex.rowIndex != 0) {
                int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
                var row = _employeeDataSource.effectiveRows
                    .elementAt(selectedRowIndex);

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0))),
                        content: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                    'ID: ${row.getCells()[0].value.toString()}'),
                                Text(
                                    'Name: ${row.getCells()[1].value.toString()}'),
                                Text(
                                    'Designation: ${row.getCells()[2].value.toString()}'),
                                Text(
                                    'Salary: ${row.getCells()[3].value.toString()}'),
                                SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK"))),
                              ]),
                        )));
              }
            })));
  }

  List<GridColumn> get getColumns {
    return [
      GridColumn(
          columnName: 'id',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text(
                'ID',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Name', overflow: TextOverflow.ellipsis))),
      GridColumn(
          columnName: 'designation',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child:
                  const Text('Designation', overflow: TextOverflow.ellipsis))),
      GridColumn(
          columnName: 'salary',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: const Text('Salary', overflow: TextOverflow.ellipsis)))
    ];
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 70000),
      Employee(10002, 'Kathryn', 'Manager', 99000),
      Employee(10003, 'Lara', 'Developer', 33000),
      Employee(10004, 'Michael', 'Designer', 35000),
      Employee(10005, 'Martin', 'Developer', 45000),
      Employee(10006, 'Newberry', 'Developer', 29000),
      Employee(10007, 'Balnc', 'Designer', 33000),
      Employee(10008, 'Perry', 'Developer', 31000),
      Employee(10009, 'Gable', 'Developer', 29500),
      Employee(10010, 'Grimes', 'Developer', 28000)
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    buildDataGridRow(employees);
  }

  void buildDataGridRow(List<Employee> employeeData) {
    dataGridRow = employeeData.map<DataGridRow>((employee) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: employee.id),
        DataGridCell<String>(columnName: 'name', value: employee.name),
        DataGridCell<String>(
            columnName: 'designation', value: employee.designation),
        DataGridCell<int>(columnName: 'salary', value: employee.salary),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRow = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => dataGridRow.isEmpty ? [] : dataGridRow;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}
