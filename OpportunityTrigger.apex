trigger OpportunityTrigger on Opportunity (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {
  
    
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { }
        WHEN BEFORE_UPDATE  { 
            
        /*  Whenever Opportunity is updated
			Display who and when the record is updated
			on description of Opportunity record 
		*/
            
            string userName = system.userInfo.getName();
            date bugun = system.today(); //dateTime = dateTime.now();
            
            for(opportunity opp : trigger.new){
                opp.Description = 'Bu record '+userName+' tarafindan '+'\n'+
                    bugun+' tarihinde update edildi. ';
            }
            
            
        }
        WHEN BEFORE_DELETE  { 
        
            //Prevent deleting of an Opportunity if Opportunity is 'Closed '
        	
            for (Opportunity Opp : Trigger.old){
                if(Opp.IsClosed){
                    Opp.addError('Opp can not be deleted if Stage is closed');
                }
            }
        
        
        }
        WHEN AFTER_INSERT   { }
        WHEN AFTER_UPDATE   { 
                        
            //When the Opportunity stage is updated to "Negotiation/Review" 
            //Develop a trigger that creates a TASK for the owner
       
         List<Task> taskList = new List<Task>();
    
            for (Opportunity newOpp : Trigger.new) {
                 // SELECT Id, WhoId, WhatId, Subject, Status, Priority, ActivityDate FROM Task
                Opportunity oldOpp=trigger.oldMap.get(newOpp.id);
                    
                    if(newOpp.StageName  == 'Negotiation/Review' 
                      && oldOpp.StageName  != 'Negotiation/Review'){
                        
                         Task newTask = new Task();
                
                        newTask.Subject = 'Follow up with this Opportunity ';
                        newTask.OwnerId = newOpp.OwnerId; //Kime assign edilecegi
                        newTask.WhatId = newOpp.Id ; //Yeni olusan Opp id si ---opp degil kisi olursa WhoId---            
                        newTask.ActivityDate = Date.today().addDays(7); //Date.today()+ 7  
                        
                        taskList.add(newTask);
                    }
                           
              }
                   if (!taskList.isEmpty()) {
                            insert taskList;
                        }        
        
        
        }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { }
 
    }
    
}