
public class AsynchBatchApex implements Database.Batchable<sObject>{
	//Asynch Apex lerin datasi Apex Job da tutulur
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        // bu method databseden islem yaoacagimiz recordlari SOQL ile getirme yeridir
        
         // 1. yontem
    //   String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'AAA%\' ';
     //    return Database.getQueryLocator(query);
       
         // 2. OPTION
       //     STRING filter = 'AAA%';
       // string querySecond = 'SELECT Id, Name FROM Account WHERE Name LIKE ' + filter+ ' ' ;
        
         // 3 option
       return Database.getQueryLocator([SELECT Id, Name FROM Account WHERE Name LIKE 'AAA%' ]); 
    }
     
    public void execute(Database.BatchableContext BC, List<Account> accList) {
        // ne yapilcaksa o code un yazildigi yer
        // process each batch of records default size is 200
        
        for(Account acc : accList) {        
            // Update the Account Name 
            acc.Name = acc.Name + ' WISE';
        }
        try {
            // Update the Account Record
            update accList;
         
        } catch(Exception e) {
            System.debug(e);
        }
         
    }   
     
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
        // butun islem bittikten sonra bisey istiyorsak onu yazildigi yer 
        
        system.debug(' acc isimleri update edildi');
    }
    
    
    //Anon Window
    
    /*
     
        AsynchBatchApex ornek = new AsynchBatchApex();
        Database.executeBatch(ornek, 50);
        //(hangi batch class execute edilecek , gruplama adedi)
        //Database.executeBatch(ornek); //default 200 
	*/

 
    
}

// 2 //

public class AsynchBatchApex2 implements Database.Batchable<sObject>{

     public Database.QueryLocator start(Database.BatchableContext BC) {
                
        
// NOT   SOQL de isime yaramayacak field getirmeyiniz  bosuna yuk tasimis olursunuz
// isime yaracak ( BillingCountry gibi  ) field gelmelidir
//Query yaparken bilgi cekilecek field getirilmek zorunda ama assign ettigimiz field i getirmeye gerek yok

       return Database.getQueryLocator([SELECT Id, BillingCountry ,
                                        (SELECT id  FROM contacts) 
                                        FROM Account ]); 
    }
     
    public void execute(Database.BatchableContext BC, List<Account> accList) {
        //Map ile daha guzel olur sadece daha iyi anlasilmasi icin boyle yapildi
       list<contact> cntList = new List<contact>();
        for(Account acc : accList) {        
            if(acc.contacts.size() != null){
                for(contact cnt: acc.contacts ){
                    if(acc.BillingCountry !=null ){
                      cnt.OtherCountry = acc.BillingCountry; 
                        cntList.add(cnt);
                    } 
                }              
            }
         }
        try {
            
         update cntList;
            
        } catch(Exception e) {
            System.debug(e);
        }
         
    }   
     
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
        
      
    } 
    
    
	//Anon Window
    
    
    /*
      AsynchBatchApex2 ornek = new AsynchBatchApex2();
	  Database.executeBatch(ornek, 50);
	*/

   
    
}