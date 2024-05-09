public class OppReminderEmailBatch implements Database.Batchable<sObject> , Schedulable {

     public Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        // bu method databseden islem yapacagimiz recordlari SOQL ile getirme yeridir
        
       return Database.getQueryLocator([SELECT Id, Name, CloseDate, Owner.Name, Owner.Email
										FROM Opportunity
										WHERE CloseDate = NEXT_N_DAYS:3 AND IsClosed = false ]); 
    }
    
   
    public void execute(Database.BatchableContext BC, List<Opportunity> oppList) {
        // ne yapilcaksa o code un yazildigi yer
        // process each batch of records default size is 200
      
        for(Opportunity opp : oppList) {     
            // Set email 
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                // Set recipients -- toAdresses holds a list.
                message.toAddresses = new String[] {opp.Owner.Email};
                message.subject = opp.Owner.Name + 'Opportunity required action!' ;
                message.plainTextBody = 'Hello ' + opp.Owner.Name + ',\n\n' +
                                   opp.Name + ' Opportunity has to be closed before ' + 
                                   opp.CloseDate.format() + '.\n\n' +
                                   'Please finalize your sales process.';
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
     
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
        // butun islem bittikten sonra bisey istiyorsak onu yazildigi yer 
    
        
    }
    
    public void execute(SchedulableContext scon) {
        
    	Database.executeBatch(new BirthdayEmailBatch(),100);
    }
    
    
}