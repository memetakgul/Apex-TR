public class Calisma2 {

    //Example 1A: Type code to check if a List has repeated elements  by using maps
    public static void soru(){
List<Integer> myList = new List<Integer>{12, 21, 12, 13, 12, 21, 35};
  Map<Integer, Integer> myMap = new Map<Integer, Integer>();
    for(Integer w : myList){
        Integer numOfOccurence = myMap.get(w);
        if(numOfOccurence==null){
            myMap.put(w, 1);
        }else{
            myMap.put(w, numOfOccurence+1);
        }
    }
 } 
    
//  Orgumuzdaki hangi sektörde  opportunitylerin
//   closeWon olduğunu görmek istiyoruz.
       
   public static void cevap(){
List<account> accList = [SELECT id ,name, Industry , (SELECT ID, amount FROM opportunities WHERE iswon=true) FROM account ];
Map<string, integer> endustriFirsatlari = new Map<string, integer>();
        for(account acc : accList ){
            if(acc.opportunities.size() >0 ){
                for( opportunity opp:  acc.opportunities  ) {
                system.debug(acc.name + ' >> '+ opp.amount);
               Integer numOfOccurence = endustriFirsatlari.get(acc.Industry);
                if(numOfOccurence==null){
                    endustriFirsatlari.put(acc.Industry, 1);
                }else{
                    endustriFirsatlari.put(acc.Industry, numOfOccurence+1);
                }
              }
            }
         }
        system.debug(endustriFirsatlari);
// {Agriculture=1, Biotechnology=2, Electronics=4, Energy=5, Hospitality=3, Transportation=1}
      }
  
    
    
//7.contact objsinde bir adet TYPE field olusturun ve 
//org da bulunan tum contactlarin bagli olduklari accountlarin type larini 
//alip kontactlarin type yapiniz    
    
    public static VOID contactType(){
		MAP<ID, account> accMap = new Map<ID, account>();
            try{
         accMap = new Map <ID, account>([SELECT id, Type,
                                          (SELECT Id, cntType__c  FROM Contacts)
                                            FROM account]);
        }catch(Exception e){
            system.debug('MAP de problem var ');
        }      
    list<Contact> updateList= new List<Contact>();
      if (accMap != null){
        SET<id> accIdleri = accMap.keySet();
            for(ID accId : accIdleri ){
          account  acc = accMap.get(accId); 
              list<Contact> cntList =  acc.Contacts;
                if (cntList.size()>0 ){
                       for(Contact cnt : cntList ){
                           if(acc.type != null){
                               cnt.cntType__c = acc.type; 
                           }
                           updateList.add(cnt);
                       } 
               	 }
    		}
              try{
                       //update updateList;
                 system.debug(updateList);
              }catch(Exception e){
                system.debug('UPDATE problem cikti');
              }
            }
    
    }
    
    
    //Husnu hocanin cevap
    public static void updateContactType() {
        // Mevcut Contact kayıtlarını sorgula
        List<Contact> cntList = [SELECT Id, cntType__c, Name, Account.Id, Account.Name, Account.Type FROM Contact];
        // Güncellenmiş Contact listesini tut
        List<Contact> updatedContactList = new List<Contact>();
        for (Contact cnt : cntList) {
            // Her bir Contact kaydının tipini, ilgili Account'ın tipi ile güncelle
            if (cnt.Account != null && cnt.Account.Type != null) {
                cnt.cntType__c = cnt.Account.Type;
                updatedContactList.add(cnt);
            }
          }
                if (!updatedContactList.isEmpty()) {
            //update updatedContactList;
            System.debug('Contact kayıtları başarıyla güncellendi.');
        } else {
            System.debug('Güncellenecek Contact kaydı bulunamadı veya ilgili Accountun typeı boş.');
        }
      }
        
    
    
    
    
    
    
    
    
    
}