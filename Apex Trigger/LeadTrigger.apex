trigger LeadTrigger on Lead (before insert , before update , before delete , after insert , after update, after delete, after undelete ){

    //If a new Lead is created or updated and if ‘Industry’ filed is null; Give a warning
    //validation
    
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { 
     
            //trigger tekrar eden codelar icerince OOP consept uygulanmali
            //HandlerClass     
        	//LeadTriggerHandler.industryControl(trigger.new);
        
        LeadTriggerHandler.industryValidation(trigger.new);
            
        //While creating a Lead assign ‘Other’ if Lead Source is null. (Before insert)
            for(lead newLd:trigger.new){
                    if(newLd.LeadSource ==null){
                        newLd.LeadSource ='Other';
                    }
            }
                       
            
        }
        WHEN BEFORE_UPDATE  { 
       
        	//LeadTriggerHandler.industryControl(trigger.new);
        	
        LeadTriggerHandler.industryValidation(trigger.new);
            
            //Create an error (Warning) trigger when a Lead is updated from 
            //'Open - Not Contacted' status to 'Closed - Not Converted' status. (Validation )
            
            for(lead newLead : trigger.new){
                lead oldLead=trigger.oldMap.get(newLead.id);
                
                if(newLead.Status == 'Open - Not Contacted' 
                  && oldLead.Status == 'Closed - Not Converted'){
                    
                      newLead.addError('Open status Leads can not be converted to Close'); 
                        
                    }
                }
            }

        
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   {
            
        //After creating Lead record , create a Task. (After insert)
       
         List<Task> taskList = new List<Task>();
    
        for (Lead newLead : Trigger.new) {
             // SELECT Id, WhoId, WhatId, Subject, Status, Priority, ActivityDate FROM Task
            Task newTask = new Task();
            
            newTask.Subject = 'Follow up with Lead: ' + newLead.lastName;
            newTask.OwnerId = newLead.OwnerId; //Kime assign edilecegi
            newTask.WhoId = newLead.Id ; //Yeni olusan Lead id si             
            newTask.ActivityDate = Date.today().addDays(5); //Date.today()+ 7  
            
            taskList.add(newTask);
        }
    
            if (!taskList.isEmpty()) {
                insert taskList;
            }
            
            
            
        }
        WHEN AFTER_UPDATE   { }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { 
            //When a lead record is Restored from a recycle bin, type 'Restored' in the console
            for(lead newLead : trigger.new){
                system.debug(newLead.id+' li record copten cikti!');
                //  after trigger icserisinde triggeri tetikleyen reocrd read only oldugu icin
               //  bu record icerisinde degisiklik yapilamaz
              //   newLed.description = 'Bu idli record çöpten çıktı!';
             // LeadTrigger: execution of AfterUndelete caused by: System.FinalException: Record is read-only Trigger.LeadTrigger: line 22, column 1
            }        
        }
 
    }
    
    
    
    
}