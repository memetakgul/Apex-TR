
////TEK RECORD////

//serialization

account acc = [SELECT id,name,rating FROM account WHERE name LIKE 'Burl%' LIMIT 1];
system.debug(acc); 
//Account:{Id=001Ho000019qdZkIAI, Name=Burlington Textiles Corp of America, Rating=Warm}

String jsonStr = JSON.serialize(acc);
system.debug(jsonStr);

/*
{"attributes":
{"type":"Account","url":"/services/data/v60.0/sobjects/Account/001Ho000019qdZkIAI"},
"Id":"001Ho000019qdZkIAI","Name":"Burlington Textiles Corp of America","Rating":"Warm"}
*/


//deserialization
Account  jsonAcc = (Account)JSON.deserialize(jsonStr, Account.class);

system.debug(jsonAcc);
//Account:{Rating=Warm, Id=001Ho000019qdZkIAI, Name=Burlington Textiles Corp of America}




/////LISTE/////

//serialization

list <account> accList = [SELECT id,name,rating FROM account LIMIT 3];
system.debug(accList); 
//(Account:{Id=001Ho00001IhegfIAB, Name=Wise Quarter}, 
//Account:{Id=001Ho00001IhzF9IAJ, Name=AAA 1 *** $$$$ $$$$ WISE, Rating=Warm}, 
//Account:{Id=001Ho00001IhzFAIAZ, Name=AAA 2 *** $$$$ WISE})

String jsonStrList = JSON.serialize(accList);
system.debug(jsonStrList);
/*
[
{"attributes":{"type":"Account","url":"/services/data/v60.0/sobjects/Account/001Ho00001IhegfIAB"},"Id":"001Ho00001IhegfIAB","Name":"Wise Quarter"},
{"attributes":{"type":"Account","url":"/services/data/v60.0/sobjects/Account/001Ho00001IhzF9IAJ"},"Id":"001Ho00001IhzF9IAJ","Name":"AAA 1 *** $$$$ $$$$ WISE","Rating&quo
...]
*/

//deserialization
list <Account>  jsonAccList = (list <Account> )JSON.deserialize(jsonStrList, list <Account>.class);

system.debug(jsonAccList);
//(Account:{Id=001Ho00001IhegfIAB, Name=Wise Quarter}, 
//Account:{Rating=Warm, Id=001Ho00001IhzF9IAJ, Name=AAA 1 *** $$$$ $$$$ WISE}, 
//Account:{Id=001Ho00001IhzFAIAZ, Name=AAA 2 *** $$$$ WISE})


//deserialization Untyped(gelenin typeini bilmiyorsak)
 Map<String,object> mesaj= (Map<String,object>)JSON.deserializeUntyped(response.getBody());