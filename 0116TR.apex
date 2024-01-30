
// childdan parenta query

list<opportunity>   oppList = [SELECT Opportunity.Id, Opportunity.Name,
                               Account.Name, Account.rating
                               FROM Opportunity];
system.debug(oppList.size()); // 47
system.debug(oppList);

/*
(Opportunity:{Id=006Hu00001WWJoWIAX, Name=new opp with new record type,
RecordTypeId=012Hu000001DwebIAC}
*/

for( opportunity  opp:   oppList ){
    //system.debug(opp); // {Id=006Hu00001WWJoWIAX, Name=new opp with new record type, RecordTypeId=012Hu000001DwebIAC}
    //system.debug(opp.Account.Name); // Farmers Coop. of Florida
system.debug( opp.name +' nin accountunun ismi >> ' + opp.Account.Name + '. Rating >> '+ opp.Account.rating   );
// Farmers Coop. of Florida- nin accountunun ismi >> Farmers Coop. of Florida rating >> Hot
}


// Custom objectte childdan parenta query

list<Student__c>   oppList = [SELECT Id,name, First_Name__c ,
                               Parent__r.gender__c, Parent__r.Name
                               FROM Student__c];
// Parent__c   bu calismaz
// Parent__r   bu r  relation 


// PARENT dan CHILD objecte query

SELECT id, name  ,  ( SELECT Id, Name FROM Opportunities  )   FROM account
//  account ile contacts   querysini yaziniz
SELECT id,name,(SELECT Id, Name FROM Contacts)      from account
list <account> accList= [SELECT id, name  , 
                         ( SELECT Id, Name FROM Opportunities  )   
                         FROM account];
//system.debug(accList);
// Account:{Id=001Hu00002xfONBIA2, Name=GenePoint}

for ( account  acc : accList ){
    
    for(  Opportunity  opp :  acc.Opportunities     ){
        // accountun icindeki Opportunities listesini getirir
        system.debug(acc.name+ ' accountun oppsi >> '+ opp.name);
        
    }
}

// CUSTOM parenttan custom Child
list <Parent__c> prnList= [SELECT id, name , 
                         ( SELECT Id, Name FROM Students__r  )   
                         FROM Parent__c];
for( Parent__c  prnt : prnList     ){
    for(Student__c  stn: prnt.Students__r      ){
        
       system.debug( prnt.name + ' adli parentin childi ' + stn.Name ); 
    }
      
}

/// MAP ile ayni isi yapmak
List <account> accList= [SELECT id, name  , 
                         ( SELECT Id, Name FROM Opportunities  )   
                         FROM account];
MAP<ID, account> accMap = new Map<ID, account>( [SELECT id, name  , 
                         ( SELECT Id, Name FROM Opportunities  )   
                         FROM account]   );
// 001Hu00002xfONAIA2 ==> United Oil & Gas Corp IDsi
   
list<opportunity> oppList= accMap.get('001Hu00002xfON6IAM').Opportunities; 
 system.debug(oppList.size()); // 10
    
// United Oil & Gas Corp  un opp lerini ekranda gosterin
// odev  bu soruyu bir de list yontemi ve for each ile cozunuz
// SOQL detay kismi 
// bu kismin varlogini bilmeniz ve ihtiyac halinde gerkeli yardim alinir


//  ****  AGGREGATE (KUMELESMIS)  FUNCTIONLAR  ****

// MIN(), MAX(), COUNT() , AVG() , SUM()  bunlar bir cok data alip sadece 1 data doner 
list<account> accList = [SELECT name ,   numberofemployees FROM Account   
                               WHERE numberofemployees >500];
for( account acc : accList ){
    
    system.debug(acc.name + ' hesanin calisan sayisi ' + acc.numberofemployees);
}
system.debug( 'COUNT >>> ' + [SELECT   COUNT(numberofemployees) FROM Account   
                               WHERE numberofemployees >500]);


// COUNT >>> (AggregateResult:{expr0=9}) 
//9 adet accountun calisan sayisi 500 den yuksekmis
system.debug(' Max >>  ' + [SELECT   MAX(numberofemployees) 
                            FROM Account   WHERE numberofemployees >500  ]);
// Max >>  (AggregateResult:{expr0=145000})

// eger brup olarka almak istersek GROUP BY kullanilmasi gerek  
[SELECT industry ,  COUNT(name) FROM Account  GROUP BY  industry ]
system.debug(' COUNT >>  ' + [SELECT industry,  MAX(numberofemployees) FROM Account GROUP BY  industry ]);


// AGGREGATE WHERE ile CALISMAZ
SELECT Industry, COUNT(numberofemployees) FROM Account GROUP BY Industry  
    WHERE COUNT(numberofemployees)>1
    

  // AGGREGATE HAVING  ile CALISIR  
system.debug(' COUNT >>  ' + [SELECT Industry, COUNT(Name) 
                              FROM Account 
                              GROUP BY Industry  
                              HAVING COUNT(name)>1 ] );


// AGGREGATE depolamk isterseniz LISTE ile OLMAz
AggregateResult[] aggResult  =  [SELECT Industry, AVG(NumberOfEmployees) 
                                             FROM Account
                                            GROUP BY Industry];
   
    for (AggregateResult  w : aggResult ) {
            
            System.debug('Insdustry is : ' 
                         + w.get('Industry') + ' --> avarage number of emloyees is  ' 
                         + w.get('expr0') );
        }

AggregateResult[] aggResult  =  [SELECT Industry, AVG(NumberOfEmployees) ortalama 
                                             FROM Account
                                            GROUP BY Industry];
    
    for (AggregateResult  w : aggResult ) {
            
            System.debug(': ' 
                         + w.get('Industry') + ' --> avarage number of emloyees is  ' 
                         + w.get('ortalama') );
        }

AggregateResult[] aggResult=  [SELECT 
                               MIN(NumberOfEmployees),
                               MAX(NumberOfEmployees) , 
                               AVG(NumberOfEmployees) 
                               FROM Account];
        
System.debug('Min number of employees: ' + aggResult[0].get('expr0')); // burasi MIN getirir     Min number of employees: 120
System.debug('Max number of employees: ' + aggResult[0].get('expr1')); // burasi MAX getirir     Max number of employees: 145000
System.debug('Avg number of employees: ' + aggResult[0].get('expr2')); // Burasi AVG getirir     Avg number of employees: 21996.81818181818

AggregateResult[] aggResult=  [SELECT 
                               MIN(NumberOfEmployees) minimum,
                               MAX(NumberOfEmployees) maximum, 
                               AVG(NumberOfEmployees) 
                               FROM Account];
        
System.debug('Min number of employees: ' + aggResult[0].get('minimum')); // burasi MIN getirir     Min number of employees: 120
System.debug('Max number of employees: ' + aggResult[0].get('maximum')); // burasi MAX getirir     Max number of employees: 145000
System.debug('Avg number of employees: ' + aggResult[0].get('expr0')); // Burasi AVG getirir     Avg number of employees: 21996.81818181818

// **   SIRALAMA ------>  ORDER BY   ASC-- artan ,,       DESC-- azalan

 List<Account> siraliAccount = [SELECT  name , AnnualRevenue  FROM   Account  
                           
                                    ORDER BY AnnualRevenue DESC   NULLS LAST  ]; 
      
FOR(Account  acc : siraliAccount  ){
    
    system.debug(acc.Name + ' yillik ciro == >' +   acc.AnnualRevenue);
    
}   

 SELECT  name , AnnualRevenue  FROM   Account  WHERE  AnnualRevenue != null  ORDER BY AnnualRevenue DESC  

//  where kullancaksak    where order by dan once gelmelidir    
     //  sorguyu sinirla ----->   LIMIT    OFFSET
     //   offset  limitten sonra yazilir
      //  OFFSET   demek  bu kadar recirdu passgec 
      // LIMIT   sadece sana verdigim rakam kadar record getir
     
   List<Account> siraliAccount = [ SELECT  name , AnnualRevenue  
                                  FROM   Account    
                                  ORDER BY AnnualRevenue DESC  
                                  NULLS LAST   
                                  LIMIT 2 OFFSET 3];
// account obj gelen fieldlari tersten null sonda olacak sekilde 
//terten annual revenue suna gore sirala
//3 record atla sonraki 2 recordu getir
FOR(Account  acc : siraliAccount  ){
    
    system.debug(acc.Name + ' yillik ciro == >' +   acc.AnnualRevenue);
    
}   

//  DATE ile alakali query 
SELECT name, SLAExpirationDate__c FROM Account WHERE SLAExpirationDate__c > 2021-10-08     
     
// DATE-TIME degiskenli feildlar
SELECT name, CreatedDate FROM Account WHERE CreatedDate > 2020-10-08T23:59:59Z  

///Class

public with sharing class SOQLOrnekleri {
// RECORD LEVEL SECURITY ( SHARING RULES )
 // with sharing,   >>>>> SHARING RULES AKTIF  
 // without sharing,  >>>>> SHARING RULES DEAKTIF  
 //  and inherited sharing   >>>>> SHARING RULES parenttaki sharing rules aktif    
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_sharing.htm  
    
    
  
    
  // object ve field level security  
    // WITH SECURITY_ENFORCED
    // // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_with_security_enforced.htm
    public list<Contact> contactlarVeAccountlari(){
     //1.Yontem   
        list<Contact>   cntList = [SELECT Id, Name,
                                   Account.Name
                                    FROM Contact
                                   WITH SECURITY_ENFORCED ];
        /*
	//2.Yontem >>> database.query(string)
	string sorgu = 'SELECT Id, Name,Account.Name FROM Contact WITH SECURITY_ENFORCED';
                                   
        list<Contact> cntList = database.query(sorgu);
        */
        
        return cntList;
    } 
    
   public String contactVeAccount(String cntId){
      // burasi sadece contagin accountun adini donsun 
     
       Contact  cnt = [SELECT Id, Name,
                                   Account.Name
                                    FROM Contact
                                  WHERE Id =: cntId ];
       
       string accName= cnt.Account.Name;
       
       return accName;
    }   
 
    
    public List<account> accountlariVeContactlari(){
        
      List<account>  accList= [SELECT id,name,
                              (SELECT Id, Name FROM Contacts)   
                              FROM account];
    
      return accList;
    }   
    
   public STATIC List<account> accVeContactlari(string accId){
       
      List<account>  accList= [SELECT id,name,
                              (SELECT Id, Name FROM Contacts)   
                              FROM account 
                              WHERE id =: accId ];
    
      return accList;
    }   
     
}


/////Anon Window


// CHILD dan parenta
//  contactlari ve bu contactlarin acclarini getiren bir method yaziniz
SOQLOrnekleri ornek = new SOQLOrnekleri();
list<Contact> sonucListesi=  ornek.contactlarVeAccountlari();
for( Contact cnt :  sonucListesi    ){
 system.debug( cnt.Name + '   calistigi kurum >>> ' + cnt.Account.Name   );
}

//  idsini verecegim contact in nerede calsitigini soyle
 SOQLOrnekleri ornek = new SOQLOrnekleri();
 string accAdi=  ornek.contactVeAccount('003Hu00003UFBfnIAH');
system.debug( accAdi); // American Banking Corp.

// soru 3  parenttan childa
//   account ve account contactlarini goster
SOQLOrnekleri ornek = new SOQLOrnekleri();
 List<account> accList= ornek.accVeContactlari();

// soru 4  parenttan childa
// idsini verdigim accountun contactlarini donunuz
List<account> accList=  SOQLOrnekleri.accVeContactlari('001Hu00002xfONCIA2'); 
system.debug(accList.get(0).Contacts);
for( account acc: accList){
    system.debug(acc.contacts);
}



//  ODEV 
//Soru 1 Account objesinde  Industrye gore ayni sektorde calisan ve 
//         firma sayisi 1 den fazla olan sektorleri getiriniz.
// KOPYA
// COUNT() ve HAVING

AggregateResult[] aggResult=[SELECT Industry, COUNT(name) firmaSayisi
                           FROM Account GROUP BY Industry  
    					   HAVING COUNT(name)>1 ];
system.debug(aggResult); 
//(AggregateResult:{Industry=null, firmaSayisi=6}, 
//AggregateResult:{Industry=Apparel, firmaSayisi=2}, 
//AggregateResult:{Industry=Energy, firmaSayisi=3})



// Soru 2 butun accountlari ve bu accountlarda contact olan ve ismi A ile baslayan kisileri bulun   
    
// kopya  LIKE    ve wild card      


list<Account>   conList = [SELECT Id, Name ,
                           (SELECT Id, Name FROM Contacts )
                               FROM Account Where name LIKE 'A%'];
system.debug(conList.size()); 


    
//SORU 3) Account objesinden gelen verileri azalan siraladiktan sonra 
//        bastan 4. recordu getiriniz
// KOPYA  OFFSET LIMIT

List<Account> accList = [SELECT  name , AnnualRevenue  FROM   Account  
                        ORDER BY AnnualRevenue DESC   NULLS LAST 
                        LIMIT 1 OFFSET 3 ];
system.debug(accList); 

// SORU 4) Çalışan sayısı ikinci en yüksek olan Account adını ve çalışan sayısını seçin
// KOPYA  OFFSET LIMIT
//   tch the id,name,rating from account if the names are 
//  'GenePoint', 'Burlington Textiles Corp of America', ' sForce' , 'Dickenson plc'
//  dinamik kod yaziniz   liste olsuturun  ve o listeyi aratin 


Account acc = [SELECT  name , NumberOfEmployees  FROM   Account  
                        ORDER BY NumberOfEmployees DESC   NULLS LAST 
                        LIMIT 1 OFFSET 1 ];
//system.debug(acc); 

list <string> accList= new list<string>{'GenePoint', 'Burlington Textiles Corp of America', ' sForce' , 'Dickenson plc','University of Arizona'};


    if (accList.contains(acc.name)){
        system.debug(acc.name); 
    }else{
         system.debug('Name of the account that searched not on the list');
    }




// soru 5  eger bilinmedik bir ID verilirse bu ID yi kontrole ederek veri donunuz

public STATIC void idCheck(string accId){
      
        if (accId != null && (accId.length()==15 || accId.length()==18) ) {
            List<account>  accList= [SELECT id,name   
                              		FROM account 
                              		WHERE id =: accId ];
            if (accList != null){
            system.debug ('ID ' + accId + ' geçerlidir, kullanıcı bulundu.');
            }
        } else {
            system.debug ('ID ' + accId + ' geçersizdir, kullanıcı bulunamadı.'); 

    	}   
    
    }





