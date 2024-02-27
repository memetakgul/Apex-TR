trigger AccountTrigger on Account (before insert , before update , before delete , after insert , after update, after delete, after undelete ) {
  
    SWITCH on Trigger.operationType {
        
        WHEN BEFORE_INSERT  { 
            
        	for(Account acc : TRIGGER.NEW){
        		acc.rating ='Hot';
                acc.BillingState='ARKANSAS';
                
                if (acc.Industry==null){ //String.isBlank(acc.Insustry)
                    acc.Industry='Banking';
                }
            }
            
            //Account olusturulurken eger ayni isimli bir account varsa izin verme error mesaji goster
            
          AccountTriggerHandler.accNameDublicate(trigger.new);
            
            
           /*
             Write a trigger on Account, when an account is inserted, automatically account billing
             address should populate into the account shipping address.
            When it comes to Account Billing and Shipping Address, we cannot 
            directly enter the values to the field Address because the Address is split into Street,
             City, State, PostalCode, and Country.
            */
            
            AccountTriggerHandler.shippingAdressUpdate(trigger.new);
            
            
          
        }   
        WHEN BEFORE_UPDATE  { 
            
            
            // Eger accountun type kismi update ediliyor ise
            // ve accountun industry si bos ise
            // o zaman indusrty kismi education olsun
                                 
            AccountTriggerHandler.industryCheck(trigger.new , trigger.oldMap);
            
          //•Create a filed named ‘Old Phone’ on account object
		//•Whenever phone field is updated on Account record
		//•Then Old Phone filed should also get updated with old version of phone number on account
          
            AccountTriggerHandler.oldPhoneSaving(trigger.new, trigger.oldMap);
		
        }            
        WHEN BEFORE_DELETE  { }
        WHEN AFTER_INSERT   { 
            
            /*
            list <contact>cntList=new list <contact>();
            for(account acc2:trigger.new){
                contact cnt=new contact();
                cnt.LastName= 'Cnt of '+ acc2.name;
              	cnt.AccountId= acc2.id;   
                cntList.add(cnt);
            }
           insert cntList;  
            */
            
            
            ////////----Recursion----///////
            
            AccountTriggerHandler.accRecursionExample(trigger.new);
            
            
            
        }
        WHEN AFTER_UPDATE   { 
            
            /*
             Write a trigger on the Account when the Account is updated check all opportunities related to the account.
             Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from 
            today and stage not equal to close won.
        	*/
            
            AccountTriggerHandler.oppStageUpdate(trigger.newMap);
        	

               
        
        }
        WHEN AFTER_DELETE   { }
        WHEN AFTER_UNDELETE { 
        
            list<id> accIdleri = new List<Id>();
            
         // yontem 1  
            for( account acc: trigger.new){
                
              accIdleri.add(acc.Id);                        
                
            } 
            
      // yontem 2
     SET<id> accIdleri2 = trigger.newMap.keySet();       
   
            // kodun ana kismi
            list<contact> cntList = [SELECT id,Description FROM contact 
                                     WHERE accountId IN: accIdleri2  ];               
            
            for(contact cnt : cntList ){
                
                cnt.Description = ' senin account copten cikti';
                
            }
            
     update cntList;            
        
        // calisan ama hatali sayilan kod    
            for(account acc: trigger.new){
                list<contact> cntList1 =[SELECT id ,Description FROM contact 
                                         WHERE accountId =: acc.id ];
                for(contact cnt : cntList1 ){
                   cnt.Description = ' senin account copten cikti';
  
                }
                update cntList1;
            }
            
            
        }
 
    }
        
}