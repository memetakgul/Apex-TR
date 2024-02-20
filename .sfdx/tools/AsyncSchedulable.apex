public class AsyncSchedulable implements Schedulable{
//https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_scheduler.htm
    
     public void execute(SchedulableContext SC) {
      // genelde burada Batch apex, queueable veya normal bir class, method cagirilir
               
         
         /* 	Task
            •Create( Query ) a list for open Opportunities that should have closed by the current date
            •And
            •Creates a task on each one to remind the owner to update the opportunity 
         */
         
         
         List<Opportunity> oppList =[SELECT id, Name, CloseDate FROM Opportunity 
                                     WHERE CloseDate<=today AND isClosed=false ];
         list<task> taskList = new list<task>();
         
         for(Opportunity opp : oppList){
             if (oppList != null){
                 
                 Task newTask = new Task();
                
                newTask.Subject = opp.name +' adli opp due date i gecti ' ;
                newTask.OwnerId = opp.OwnerId; //Kime assign edilecegi
                newTask.WhatId = opp.Id ; //Yeni olusan opp id si             
                newTask.ActivityDate = Date.today().addDays(2); //Date.today()+ 2 //2 gun icinde task sonuclanmasi gerek
                
                taskList.add(newTask);
            }
         }
         
         //Schedule edildiginde(alarm kuruldugunda) update edilemez
         
   	}
        
        
    //Scedule new way: Setup>>Apex Classes>>Scedule Apex>>>to see>>Apex Jobs or Sceduled Jobs
    
    //Scedule old way:
    
    /* cronExpresion
    //https://www.freeformatter.com/cron-expression-generator-quartz.html
    
    //string cronText= 'seconds  minutes  hours day_of_month  month  day_of_week  optinal_year';
    //String cronText = '20 30 8 10 2 ?';
    
    AsyncSchedulable ornek = new AsyncSchedulable();
	String sch = '20 30 8 10 2 ?';
	String jobID = System.schedule('cronExp', sch, ornek);
    */
    
}