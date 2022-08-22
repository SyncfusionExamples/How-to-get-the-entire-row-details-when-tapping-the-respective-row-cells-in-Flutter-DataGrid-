# How-to-get-the-entire-row-details-when-tapping-the-respective-row-cells-in-Flutter-DataGrid-

In this article, you can learn about how to get the entire row details when tapping the respective row cells in [Flutter DataGrid](https://help.syncfusion.com/flutter/datagrid/overview).  

## STEP 1: 
Create a data source class by extending [DataGridSource](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource-class.html) for mapping data to the SfDataGrid.

```dart
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
        child: SelectableText(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

```

## STEP 2:
Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the required properties. When you tap the row, you will get the row index in the [onCellTap](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/onCellTap.html) callback. Then, you can fetch the respective row data from the [DataGridSource.effectiveRows](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource/effectiveRows.html). Here, the respective row details will be shown in the AlertDialog with a `onCellTap`.

```dart
List<Employee> _employees = <Employee>[];
late EmployeeDataSource _employeeDataSource;

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

```
