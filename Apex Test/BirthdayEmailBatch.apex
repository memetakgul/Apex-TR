public class BirthdayEmailBatch implements Database.Batchable<sObject> , Schedulable{

     public Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        // bu method databseden islem yapacagimiz recordlari SOQL ile getirme yeridir
        
       return Database.getQueryLocator([SELECT Id, LastName, FirstName, Birthdate , Email  
                                        FROM Contact WHERE Birthdate  = TODAY ]); 
    }
     
    public void execute(Database.BatchableContext BC, List<Contact> cntList) {
        // ne yapilcaksa o code un yazildigi yer
        // process each batch of records default size is 200
       
        for(Contact cnt : cntList) {        
            // Set email 
            if(cnt.Email != null){
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                // Set recipients -- toAdresses hold a list.
                message.toAddresses = new String[] {cnt.Email};
                message.subject = 'Happy Birthday! ' + cnt.FirstName + ' ' + cnt.LastName ;
                message.plainTextBody = 'As Silverline family, we wish you a very happy birthday and send you best wishes for much happiness in your life! ';
                Messaging.SingleEmailMessage[] messages = 
                    new List<Messaging.SingleEmailMessage> {message};
                        
                        try{
                            //send email
                            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                        }catch(Exception e){
                            System.debug('An error occurred: ' + e.getMessage() );
                        }
           
            }
        }
        
         
    }   
     
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
        // butun islem bittikten sonra bisey istiyorsak onu yazildigi yer 
     System.debug('Birthday emails are sent with Batch Class ' );
        
    }
    
    public void execute(SchedulableContext scon) {
    	Database.executeBatch(new BirthdayEmailBatch(),100);
    }
    
    
    
}