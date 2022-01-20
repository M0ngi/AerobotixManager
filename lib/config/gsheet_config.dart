// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:gsheets/gsheets.dart';

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "first-haven-333515",
  "private_key_id": "277962c6401890c275c897f20ee8498e8cead23f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDCVFPckFQoESqL\nbYbOcqbyxaIgsbawGHTXHj5cX/E2gDNPfvQo0ZhadV2g4zl7+i330NtKgaTCaZh+\nq9GsKaYlgEg+rzmXpwtRfnvmF82M+qWzokj4uiMJbU4Z2QFNGJXfge06o6H5JXTJ\n7cySeVvd9TWrYNR8OTw8vtbfUuvv33+LohXEvnK8H1iroRiG3MRmBrp5w7dUcZz8\n3nzAJHtlHiQ0VTDC8NlpCmPRZGaVJJ5PBG2CBcL4DPiYyA2awHrMoY1qtEx1qlyq\nf1BiF/C15ftyfnNiOrIt1V7cC9OGCjPsw2zZTCUKlsRe1Jn9TUZHUsV/iwBpk26h\nGebFFucnAgMBAAECggEAXmXvXN/heZspIxS/3O516c2WXbJmT7F5pHvlCCN0/agW\nBMJjYaa7DwofQsXOSUq05MJYnB9RBT2dXb8iObL7qhDgR08AN4pmJZ6/Gf0rFRY2\nwwWM1AI7fdtSipzPFH/iYfHv5sHRL0GCM4soCmkYdsAkY41EetmkyM9depuB0AHT\nZzGLUF0YLbxY5ChqzrwmcofYZy/m4PN2wDguiaPWt2LjXVCUTuW95jMGD06Ti2CV\nGraKoaLt50YEZ9cvx4IoQQghr5BBEOltet9BrCMTT2BYNmzz6VryyE3RHgpK7lYt\nCNPLc1CUEO6QaIdE8kxqdygDcxNQ7MJn9GQmmDEi3QKBgQD/9pbpOVfYAu/bk7pn\n0XTdqWccW+A2WArhMGhdKiIJZrap8pzyCORqS+Y1f8UBCfrRJ2PMDWWE4Mz7UeDd\nuNnux6ZNYwiNX8ijix5S8xIcJv78LvWXSfe5qhoPsosuDwFTV20YVo+f3SSmpB+q\nERo3E3hYBIcGlZ6mO4LnHkww9QKBgQDCW3jcn1cMTwLxUJUAq6LPiT2z7LKHDeeP\n7oRbxt2d+2p/xHXSlUBCERV+0GGUf1JHES/bL9oXc1gRVUzjjnbTmAjILSC/MVS1\nA9sBPfsOKq+Yei2dsg6tRQ6DeeeRUgUAnKoM3pm0ykp/bDvlKa00hp1mrk0RT+QA\nuVj51bs2KwKBgQCfyYBL99AuuSajHIWxacBa3/XObkx5oFyqV13PSw4UcFp3nUz8\nizCMavU7UJfbHi/FgaF7MKG/YdaUzXhi8ZKazWezx67/ElxeO+qiPbuAd5eWNnp6\nB2LuNJIwWnUoO5XIQTuJhgAC/Dp1DN/3etWyrCTkTW89XQm9HEmLng5SQQKBgHbb\nFYhl8QfX8ca9LsHgNIqSNSeo4mxw9mEwzcSKUtDgBXrpG9yR5WABrpGEwYfcbOaE\n/i0ekFKy+PJwpbqrTsOLQCOaZWJGurSQDQgvbS52sDegz/CWCR+xEXUZwaE+9Uww\nglWoc3r6EqDmAaLc3801XWCDyyGBJ7/BmUX/jKNNAoGAUww0gYcCOe9++AUJen3H\nPmb1lh7zsOMRKdXn1ZfH7m3qxeu+T6//OvaATmEGDe/3J39A8NtmKshJ0Jf8oY6u\niUIoI9hGRx8o1qatVQT4b3vpq3kgtpbQcwAlnCe21q8RiE6QuDKjuh7WHnx3rsWj\n6cpG0N8C5/cLDOTJSqCtlzw=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheet@first-haven-333515.iam.gserviceaccount.com",
  "client_id": "117116097987056375071",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet%40first-haven-333515.iam.gserviceaccount.com"
}''';

class SpreadSheet {
  static late final gsheets;
  static late final spreadsheet;
  static late final membresSheet, itemsSheet, dbSheet;
  static String lastError = "";
  static bool init = false;
  static bool running = false;

  static Future<bool> initSheet() async {
    if (running) return false;
    lastError = "";
    running = true;

    try {
      gsheets = GSheets(_credentials);
    } catch (e) {
      lastError = "E1: " + e.toString() + "\n";
    }

    try {
      /// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
      /// [YOUR_SPREADSHEET_ID] in the path is the id your need
      spreadsheet = await gsheets
          .spreadsheet("1t51H_CSHPFoKB7KW_AcGMi3gwyJnecfM_k5wvk4OQ04");
    } catch (e) {
      lastError += "E2: " + e.toString() + "\n";
    }

    try {
      membresSheet = spreadsheet.worksheetByTitle("Membres");
      itemsSheet = spreadsheet.worksheetByTitle("Items");
      dbSheet = spreadsheet.worksheetByTitle("Demandes");
    } catch (e) {
      lastError += "E3: " + e.toString();
      running = false;

      return false;
    }
    running = false;
    init = spreadsheet != null;
    return (spreadsheet != null);
  }
}
