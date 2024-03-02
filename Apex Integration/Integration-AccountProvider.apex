@RestResource(UrlMapping='/accounts')

//  BU CLASS  RESTREQUEST ICERIDINEKI RestRequest Properties ANLAMAK ICIN YAZILDI

/*to get my domain
 System.debug(System.Url.getCurrentRequestURL());
https://wisequarter-d8-dev-ed.develop.my.salesforce.com/services/apexrest/accounts
 URL in sonuna services/apexrest/ eklememiz lazim, en sonuna karsi taraf hangi object ile calisacaksa onu ekleyecek
*/

//Token for Authorization
//System.debug(System.UserInfo.getSessionId().substring(15));
//!ARgAQH9tcl3kdI53I.OTX6tou.3xsdJ.K8EhwJ49XvT6pZEC7YpHw01tW4dcQO6vEKItEeO78zWCOyUaqTihVP
//gecici session id. her session a ozel 

global class AccountProvider {

   @httpGet
    global Static List<account> accountGonder(){
       List<account> accList = [SELECT id,Name , phone FROM account LIMIT 4]; 
        return accList;
    }
 
    
    @HttpDelete
    global static STRING doDelete() {
       // bu method  .requestURI   icin yazildi 
        RestRequest req = RestContext.request;
      
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
      
        string result = 'Hi';
        
      
        try{
            Account account = [SELECT Id , name FROM Account WHERE Id = :accountId]; 
            result = account.name + ' record is deleted';
            delete account;
        }catch( exception e){
            result = ' There is no record to delete';
        }
       
        return result;
        
    }
    
    @HttpPost
    global static STRING doPost() {
       // .requestBody ICIN YAZILDI
        string result = 'Hi';
        
        RestRequest req = RestContext.request;
        
       system.debug('req.requestBody 1 >> ' + req.requestBody   );
        // req.requestBody >> Blob[0]
        system.debug('req.requestBody 2 >> ' + req.requestBody.toString() );
        //req.requestBody 2 >>   {   "Name": "XXXXXX", "phone" : 1234 }  
      
        string body = req.requestBody.toString();
        
       Map<String,object>  MapOfJason = (Map<String,object>)JSON.deserializeUntyped(body);
       set<String> keySet = MapOfJason.keySet();
        system.debug(keySet); // {Name, phone}
        for(String str :keySet   ){
            
            system.debug(str + ' >>> ' + MapOfJason.get(str));
            // Name >>> XXXXXX
            // phone >>> 1234
        }
         
        return result;
 
    }
    
    
     @HttpPut
    global static STRING doPut() {
      // .headers.  ICIN YAZILDI
        string result = 'Hi PUT';
        
        RestRequest req = RestContext.request;
        
    //   req.headers returns a map >>>  Map<String, String>
     
        Set<string> headersKeySet = req.headers.keySet();
        
        for(string str : headersKeySet   ){
            system.debug('key>> ' + str + ' value >>> '+ req.headers.get(str));
            // key>> Postman-Token value >>> e2a2df75-e5bb-4232-b164-41bf0cae36e3
        }
        
        return result;
        
    } 
    
  
    @HttpPatch
    global static STRING doPatch() {
        
        // params.  ICIN YAZILDI
        string result = 'Hi Patch';
        
        RestRequest req = RestContext.request;
        
    //   req.params returns a map >>>  Map<String, String>
     
        Set<string> headersKeySet = req.params.keySet();
        for(string str : headersKeySet   ){
            system.debug('key>> ' + str + ' value >>> '+ req.params.get(str));
           //key>> name value >>> Hala
           //key>> Occupation value >>> Salesfroce Developer
        }
        
        return result;
        
    } 
    
    
}
