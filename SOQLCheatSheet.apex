//--------SOQL-------//

list<Account> accList =    [SELECT Id, Name, Type, Phone FROM Account];

Map<ID , Account> accMap = new Map<ID , Account>([SELECT Id, Name, Type, Phone FROM Account]);

// keySet()  ==> set doner  .. set icerisinde for loop olmaz  foreach doneriz
// value()   == liste doner
// get(KEY)   ==  verilen keyin value sunu doner

Map<ID , Account> accMap = new Map<ID , Account>([SELECT Id, Name, Type, Phone FROM Account]);
SET<id> accIdleri = accMap.keySet();

//  FILTRE
			//  WHERE

list<account>  accList = [SELECT Id, Name, Type, Phone
                           FROM Account
                           WHERE Rating = 'Hot' OR  AnnualRevenue >100000  ];


// ******* DATA BINDING **********

/*
WHERE fieldName = 'XXXX'
WHERE fieldName =: variable // tek variablar
WHERE fieldName IN: listVariable // listeler icin kullanilir 
WHERE fieldName LIKE : variable //list or any data type 
id icin LIKE olmaz =: kullanilir
*/

string rating ='Hot';
list<account>  accList = [SELECT Id, Name, Type, Phone  
                          FROM Account 
                          WHERE Rating = :rating  ];


//   WILD card  ve LIKE   methodu 
//  WHERE fieldName LIKE variable  
//  %   ==>   bir veya birden cok karakter
//  _    ==> sadece 1 karakter demektir
//  bas harfi U olan accountlari getirin

list<account> accList = [SELECT Id, Name, Type, Phone  
                           FROM Account 
                           WHERE name LIKE 'U%'];


// Childdan Parenta query

list<opportunity>   oppList = [SELECT Opportunity.Id, Opportunity.Name , 
                               Account.Name  ,Account.rating     
                               FROM Opportunity];


// Custom objectte childdan parenta query

list<Student__c>   oppList = [SELECT Id,name, First_Name__c ,
                               Parent__r.gender__c, Parent__r.Name
                               FROM Student__c];
// Parent__c   bu calismaz
// Parent__r   bu r  relation 


// PARENT dan CHILD objecte query

list <account> accList= [SELECT id, name  , 
                         ( SELECT Id, Name FROM Opportunities  )   
                         FROM account];


// CUSTOM parenttan custom Child

list <Parent__c> prnList= [SELECT id, name , 
                         ( SELECT Id, Name FROM Students__r  )   
                         FROM Parent__c];


//  ****  AGGREGATE (KUMELESMIS)  FUNCTIONLAR  ****

// MIN(), MAX(), COUNT() , AVG() , SUM()  bunlar bir cok data alip sadece 1 data doner 

system.debug( 'COUNT >>> ' + [SELECT   COUNT(numberofemployees) FROM Account   
                               WHERE numberofemployees >500]);
// COUNT >>> (AggregateResult:{expr0=9}) 
//9 adet accountun calisan sayisi 500 den yuksekmis


// AGGREGATE WHERE ile CALISMAZ
// AGGREGATE HAVING  ile CALISIR  
system.debug(' COUNT >>  ' + [SELECT Industry, COUNT(Name) 
                              FROM Account 
                              GROUP BY Industry  
                              HAVING COUNT(name)>1 ] );


// AGGREGATE depolamk isterseniz LISTE ile OLMAz
AggregateResult[] aggResult  =  [SELECT Industry, AVG(NumberOfEmployees) 
                                             FROM Account
                                            GROUP BY Industry];

AggregateResult[] groupedResults= [SELECT AVG(Amount)aver FROM Opportunity];
Object avgAmount = groupedResults[0].get('aver');

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


// RECORD LEVEL SECURITY ( SHARING RULES )

 // with sharing,   >>>>> SHARING RULES AKTIF  
 // without sharing,  >>>>> SHARING RULES DEAKTIF  
 // inherited sharing   >>>>> SHARING RULES parenttaki sharing rules aktif    
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_sharing.htm  

list<Contact>   cntList = [SELECT Id, Name,
                                   Account.Name
                                    FROM Contact
                                   WITH SECURITY_ENFORCED ];



