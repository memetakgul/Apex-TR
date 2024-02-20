public class AsyncQueueable implements Queueable{

    //https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_queueing_jobs.htm
    
   
    public void execute(QueueableContext context) {
        //Get all account records, set Wisequarter as parent account for each account and then update records in database
               
        List<account> accList=[SELECT id, ParentId FROM Account];
        
        account wise = [SELECT id, ParentId FROM Account 
                        WHERE name = 'WiseQuarter' LIMIT 1];
        
        for(account acc : accList){
            if (acc.id != wise.Id){
                
            	acc.ParentId=wise.Id;
            } 
        }
        
        update accList;
    }

    
    //Anon Window
    
    /*
      AsyncQueueable job = new AsyncQueueable();
	  ID jobId = System.enqueueJob(job);
					//queueable default 200 records
	*/

    
    
    
    
}