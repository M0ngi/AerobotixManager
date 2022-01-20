import 'package:manager/config/gsheet_config.dart';
import 'package:manager/models/item.dart';

class SheetTools {
  static Future<String> readCell(var sheet, int col, int row) async {
    return await sheet.values.value(column: col, row: row);
  }

  static Future<int> membreExist(String id) async {
    int row = 1;
    String fetchedID;
    do {
      row++;
      fetchedID = await readCell(SpreadSheet.membresSheet, 1, row);
      fetchedID = fetchedID.replaceAll(" ", "");
    } while (fetchedID != "" && fetchedID != id);
    if (fetchedID == id) return row;
    return -1;
  }

  static Future<String> getName(int row) async {
    return await readCell(SpreadSheet.membresSheet, 2, row);
  }

  static Future<int> itemExist(String id) async {
    int row = 1;
    String fetchedID;
    do {
      row++;
      fetchedID = await readCell(SpreadSheet.itemsSheet, 7, row);
      fetchedID = fetchedID.replaceAll(" ", "");
    } while (fetchedID != "" && fetchedID != id);
    if (fetchedID == id) return row;
    return -1;
  }

  static Future<String> getMaterialName(int row) async {
    List<String> col = await SpreadSheet.itemsSheet.values.column(1);
    if (col[row] != "") return col[row];

    String lastName = "";
    for (int i = 0; i < col.length; i++) {
      if (col[i] != "") lastName = col[i];

      if (i == row) return lastName;
    }
    return "UNKNOWN";
  }

  static Future<String> getItem(int row) async {
    return await getMaterialName(row) +
        ": " +
        await readCell(SpreadSheet.itemsSheet, 3, row);
  }

  static Future<bool> addDemand(
      String name, String compt, String typeRobot, List<ItemDesc> items) async {
    String itemsText = "";
    for (ItemDesc item in items) {
      itemsText += "- " + item.qty + " " + item.name + "\n";
    }
    List<String> row = [name, typeRobot, compt, itemsText.trim()];

    await SpreadSheet.dbSheet.insertRow(2, inheritFromBefore: true);
    await SpreadSheet.dbSheet.values.insertRow(2, row);
    return true;
  }
}
