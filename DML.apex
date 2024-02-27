public class DMLOrnekleri {
    
// DATA MANIPULATION LANGUAGE
    //   INSERT   === > yeni kayit olustur
    //   UPDATE   === >  var olan kayidi guncelle ( edit )
    //   DELETE   ====>  var olan kayidi sil
    //   UNDELETE ===>>  silinmis ve COP TENEKESINDE  olan kaydi kurtar ( restore)
    //   UPSERT   ===>>  update + insert  = UpSert  eger kayit varsa update eder  kayit yoksa sifir kayit olusturur
// https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_database.htm   
   
 // SaveResult Class
 // https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_database_saveresult.htm#apex_methods_system_database_saveresult   
    
 //  INSERT   === >
    public static VOID accOlustur(String accIsim,string accRating  , string tel    ){
        
        
        Account yeniRecord = new Account();
        yeniRecord.name = accIsim;
        yeniRecord.Rating = accRating;
        yeniRecord.phone = tel;
        
        insert yeniRecord;  
        
        
    }


 // bulkify
// governer limit  

    public STATIC INTEGER accListOlustur(integer accSayisi , string accIsmi    ){
  
  list<account> accList = new List<account>();
    for(integer i=0 ; i< accSayisi ; i++      ){
       Account yeniRecord = new Account();
    
            yeniRecord.name = accIsmi + ' ' + i ;
            yeniRecord.Rating = 'Hot';
          accList.add(yeniRecord);  
        
    }
    
    insert accList;
   return   accList.size();   
        
    }
    
//    DELETE   ====>
     
    public static VOID deleteAllRecords(string silinecekler){
        
    /*   //1.Yontem  

     list<account> accList = [SELECT Id, Name, Type, Phone
                           FROM Account
                           WHERE name LIKE : silinecekler];
    */
    
    string sorgu = 'SELECT Id, Name, Type, Phone FROM Account WHERE name LIKE : silinecekler';
	
        list<account> accList =  database.query(sorgu); 
    delete accList;   
        
    }  
    
    
      //  id si verilen accountu sil
   public static VOID deleteOneRecord(string accId){
        
   account acc = new Account();
  if (accId != null && (accId.length() == 15 || accId.length() == 18)) {      
       acc = [ SELECT Id, Name, Phone
                        FROM Account 
                        WHERE ID =: accId    ];
  }
      
if (acc.id != null) {
    database.delete(acc );
    System.debug('Hesap başarıyla silindi.');
}else {
        // Hesap bulunamazsa hata mesajı
        System.debug('Hesap bulunamadı. Silme işlemi gerçekleştirilemedi.');
    }

/*  
// Hesap sorgulama
    List<Account> accList = [SELECT Id, Name, Phone FROM Account WHERE Id = :accId ];
    // Hesap bulundu mu kontrolü
    if (accList != null && !accList.isEmpty()) {
        // Hesap silme işlemi
        Account acc = accList[0];
        Database.delete(acc);
        System.debug('Hesap başarıyla silindi.');
    } else {
        // Hesap bulunamazsa hata mesajı
        System.debug('Hesap bulunamadı. Silme işlemi gerçekleştirilemedi.');
    }
*/
   
        
    }  
    
//   UNDELETE ===>>add ALL ROWS at the end of query
       
    public static void undeleteMethodu(string accName){
        
        string keyWord='%'+accName+'%';
        list<account> accList = [ SELECT name FROM account 
                                 WHERE name LIKE : keyWord ALL ROWS];
        undelete accList;

         /*     
list<account> accList = [ SELECT id FROM account WHERE name = : accName ALL ROWS];    
        
        undelete accList;
        */
    } 
    
    //   UPDATE   === >

    //   bir record delete edilmis ise ( cop tenekesinde ise)
   //   bu record direkt update edilemez,,
   //   once copten cikart.  sonra update et.
   
    
    public static void updateMethod(string accId){
         
       account accRecord = [ SELECT name FROM account 
                                 WHERE ID  =: accId];
        accRecord.Name='WISE UPDATED';
        
        update accRecord;
    }
    
    
//   UPSERT   ===>> 
       
     public static void upsertMethod(string accId){
         
       account accRecord = [ SELECT name FROM account 
                                 WHERE ID  =: accId];
        accRecord.Name='WISE UPDATED @@@@@';
        
         account accYeni =new account();
         accYeni.Name= 'AAA upsert ile olustu';
         
         list<account> accList= new List<Account>();
         accList.add(accRecord);
         accList.add(accYeni);
         
         
        upsert accList;
    }
    
    
}


//////  ANONYMOUS window
*********** bu kisimda pek bir konu yok  sadece class da olan methodlari cagirdik      ********** 

// DATA MANIPULATION LANGUAGE
    //   INSERT  ==== >  yeni kayit olustur
    //   UPDATE   === >  var olan kayidi guncelle ( edit )
    //   DELETE   ====>  var olan kayidi sil
    //   UNDELETE ===>>  silinmis ve COP TENEKESIN    olan kaydi kurtar ( restore)
    //   UPSERT   ===>>  update + insert  = UpSert  eger kayit varsa update eder  kayit yoksa sifir kayit olusturur
Account yeniRecord = new Account();
yeniRecord.name = 'AAA developer olusturdu *****';
yeniRecord.Rating = 'Hot';
yeniRecord.phone = '436 382A';
insert yeniRecord;
database.insert(yeniRecord);
database.insert(yeniRecord , true);
database.insert(yeniRecord , false);
DMLOrnekleri.accOlustur('AAA paremetreli acc');
DMLOrnekleri.accOlustur('AAA yeni record', 'xxxx' , 'AAA 2344456'   );
// BU YANLIS .. BUNU yapmayin

for (integer i=0; i<151;i++){
        
    Account yeniRecord= new Account();

	yeniRecord.name = 'AAA account'+i;
	yeniRecord.rating = 'Hot' ;
	
	insert yeniRecord;
}


// bulkify
// governer limit

list<account> accList= new list<account> ();
for (integer i=0; i<151;i++){
        
    Account yeniRecord= new Account();

	yeniRecord.name = 'AAA account with list'+i;
	yeniRecord.rating = 'Hot' ;
	
	accList.add(yeniRecord);
}

insert accList;


DMLOrnekleri.accListOlustur(23 ,'AAA xxxx'   );
//   DELETE   ====>  var olan kayidi sil
//  ya silecegim recordalarin ID leri veya recordlarin kendileri gerekli
// soru >  bas harleri AAA ile baslayan tum recordlari getiren SOQL yaziniz

list<account> accList = [SELECT Id, Name, Type, Phone
                           FROM Account
                           WHERE name LIKE 'AAA%'];
delete accList; //  data

DMLOrnekleri.deleteAllRecords('AAA%');
// 001Hu0000347A1zIAE
DMLOrnekleri.deleteOneRecord('001Hu0000347A1zIAE');