public class Calisma1 {
    
public STATIC INTEGER cntListOlustur(integer cntSayisi , string cntIsmi){
  
  list<contact> cntList = new List<contact>();
    for(integer i=0 ; i< cntSayisi ; i++      ){
       contact yeniRecord = new contact();
    
            yeniRecord.LastName  = cntIsmi + ' ' + i ;
            yeniRecord.AccountId = '001Ho000019qdZqIAI';
          cntList.add(yeniRecord);  
        
    }
    
    insert cntList;
   return   cntList.size();   
        
    }
    
//Calisma1.cntListOlustur(152,'AAA Wise');    
    
    
    
    // Bu hata veriyor, sanırım Close Date ile alakalı
    public static Opportunity createNewOpportunity(string name, decimal amount, string stage, date closeDate){
    Opportunity newRecord= new Opportunity();
    newRecord.Name= name;
    newRecord.Amount= amount;
    newRecord.StageName= stage;
   newRecord.CloseDate= closeDate;
    database.insert(newRecord);
    return newRecord;
    }
    
    
 //ornek 2
 // ISTEDIGINIZ SAYIDA CONTACT RECORDUNU OTOMAIK OLARAK OLUSTURAN BIR KOD YAZINIZ
// CONTACT ISIMLERI  CNT 1 , CNT 2 SEKLINDE OLSUN
// CONTACT ACCOUNTU OLARAK DA ISTEDIGINIZ BIR ACCOUNTU SECINIZ

    public static list<contact> createContacts(integer cntSayisi, string accName){
       
        list<contact> cntList = new List<contact>();
        string filtre = '%'+accName+'%';
        account acc = new account();
        
        try{
            
             acc =[SELECT id,name From Account 
                             WHERE name LIKE : filtre];
        }catch (Exception e){
            system.debug('Malesef '+accName+' isimli bir account yoktur.');
        }
        
        for(integer i=0 ; i<cntSayisi ; i++){
          contact cnt = new Contact();
            cnt.FirstName = 'AAA gene point';
            cnt.LastName = 'cnt ' + i ;
            if (acc.id != null){               
                cnt.AccountId = acc.id;  
            }
           
            cntList.add(cnt);
        }
        //INSERT cntList;
        return cntList;
       // BITTI
    }
    
// bütün contactlardan emaili olmayanlara email olarak 
// wisequarter@wisequarter ekleyelim.    
    
 public static list<contact> contactEmail(){
       
        list<contact> cntList = [SELECT id,name,Email  From contact];
       //string wiseEmail ='wise@wise.com';
    
        for(contact cnt : cntList ){
            if (cnt.Email  == null){
                
                cnt.Email  = 'wise@wise.com';
                
                
                    }else{
                        system.debug(cnt+' already has an email adress.');
                    }        
          
        }
        database.update(cntList,false) ;
        return cntList;
       
    }    
    
//annual revenue 500.000 in üzerinde olan account larin 
//rating ini hot olarak update edin.    
    
    public static list<account> accRating(){
       
        list<account> accList = [SELECT id, rating,AnnualRevenue   
                                 From account];
    	string rating= 'Hot';
    
        for(account acc : accList ){
            if (acc.AnnualRevenue  >= 500000){
                
                acc.rating  = rating;        
          
        }
           
   }
        database.update(accList,false) ;
        return accList;
 }       
    
    
//eger opp closed olmamis ve colse date 5 gun var ise 
//description a 'Ha Gayret' yazin.     
    
    public static list <Opportunity> oppCheck(){
       
        list<Opportunity> oppList = [SELECT id, CloseDate, Description, StageName   
                                     From Opportunity];
     
    		date bugun = date.today();
        	integer kalanGun ;
        	string DescriptionNote= 'HA GAYRET';
        
        for(Opportunity opp : oppList ){
             kalanGun = bugun.daysBetween(opp.CloseDate);
            //system.debug(kalanGun);
            if ((kalanGun <= 5 && kalanGun >= 0) &&  
                (opp.StageName !='Closed Won' && opp.StageName !='Closed Lost')){
                
                opp.Description=DescriptionNote ;
                   //system.debug(opp.Description);       
        	}    
    	}    
         database.update(oppList,false) ;
        return oppList;
    
    }
    
    public STATIC list<Contact> ContactListCretation( integer numContact , string accName  ){
         list<Contact> contactList = new List<contact>();
        	string filter = '%'+accName+'%';
        account acc = new account();
        try{
            
      acc = [SELECT id, name From account 
             WHERE name LIKE : filter LIMIT 1];
        
        }catch(Exception e){
            system.debug(filter+' gecersizdir.lutfen gecerli bir account name giriniz ');
        }
        
        for(integer i = 0 ; i< numContact ; i++      ){
            Contact newContact = new Contact();
            newContact.FirstName= 'Cnt' ;
            newContact.LastName= 'Cnt ' + i;
            newContact.Phone = 'q435sfsd' ;
            if(acc.id !=null){
              newcontact.AccountId = acc.id;  
            }
            
          CONTACTLIST.add(newContact);
        }
        // insert contactList;
        return  contactList;
    }
    
    
    public static void accPhone(){
        MAP<ID, account> accMap = new Map <ID, account>();
        try{
             accMap = new Map <ID, account>([SELECT id, phone ,
                                             (SELECT Id, AssistantPhone  FROM Contacts) 
                                             From account]);
        
        }catch(Exception e){
            system.debug('Map de problem var');
        }
        
       list <contact> updateList =new List<contact> ();
        
        if (accMap != null){
            
            SET<id> accIdleri = accMap.keySet();
                    
                for(id accId : accIdleri ){
                    
                    account acc = accMap.get(accId);
                    list<contact> cntList = acc.contacts;
                        if (acc.contacts.size()>0){
                            
                            for(contact accCnt : cntList ){
                                accCnt.AssistantPhone = acc.phone ;
                            
                                updateList.add(accCnt);
                            }
                        }
                    
    
                }    
        }
        
        //update updateList;
        system.debug(updateList);
    	}    
        
    
// task >>  accounta ait opp amountlarini toplayarak
// account uzerinde evvelden olusturmus oldugunuz
// opp amount Total isimli bir fielda koyunuz
    
   
    public static void oppTotal(){
        MAP<ID, account> accMap = new Map <ID, account>();
        
        try{
             accMap = new Map <ID, account>([SELECT id, OppToplamAmount__c  ,
                                             (SELECT Id, Amount FROM opportunities) 
                                             From Account]);
        }catch(Exception e){
            system.debug('MAP de problem var');
        }
        
       list <account> updateList =new List<account> ();
        
        if (accMap != null){  
            SET<id> accIdleri = accMap.keySet();
                    
                for(id accId : accIdleri ){ 
                    account acc = accMap.get(accId); 
                    list<opportunity> oppList = acc.opportunities;
                    decimal totalAmount = 0 ;  
                    
                    if (oppList.size()>0){   
                            for(opportunity opp : oppList ){
                                if(opp.amount>0){
                                totalAmount = totalAmount + opp.amount;
                            	}
                        acc.OppToplamAmount__c  = totalAmount ;
                        updateList.add(acc)  ;  
                      		}
                	} 
                }   
                    try{
                  // update updateList;
            		 	system.debug(updateList);
         		 	}catch(Exception e){
            			system.debug('UPDATE problem cikti');
          			}
    
                }    
        }
 
    
    
    
    public static VOID totalOppAmount(){
		MAP<ID, account> accMap = new Map<ID, account>();
       
            try{
         accMap = new Map <ID, account>([SELECT id, OppToplamAmount__c  ,
                                          (SELECT Id, Amount   FROM opportunities)
                                            FROM account]);
        }catch(Exception e){
            system.debug('MAP de problem var ');
        }
       list<account> updateEdilecekListe= new List<account>();
      if (accMap != null){
        SET<id> accIdleri = accMap.keySet();
          //system.debug(accIdleri);
            for(ID accId : accIdleri ){
          account  acc = accMap.get(accId);
              //system.debug(acc);  
              list<opportunity> oppList =  acc.opportunities;
                decimal totalAmount=0;
                if (oppList.size()>0 ){
                       for(opportunity opp : oppList ){
                           if(opp.amount>0){
                               totalAmount= totalAmount + opp.amount; 
                           }
                       }
                    acc.OppToplamAmount__c = totalAmount;
                   updateEdilecekListe.add(acc);
                }
    		}
          try{
                  // update updateEdilecekListe;
             system.debug(updateEdilecekListe);
          }catch(Exception e){
            system.debug('UPDATE problem cikti');
          }
        }
    }
    
    
    
    
}