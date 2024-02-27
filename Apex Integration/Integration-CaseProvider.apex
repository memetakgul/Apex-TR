@RestResource(UrlMapping='/cases/*')

/*to get my domain
 System.debug(System.Url.getCurrentRequestURL());
https://wisequarter-d8-dev-ed.develop.my.salesforce.com/services/apexrest/cases
 URL in sonuna services/apexrest/ eklememiz lazim, en sonuna karsi taraf hangi object ile calisacaksa onu ekleyecek
*/

//Token for Authorization
//System.debug(System.UserInfo.getSessionId().substring(15));
//!ARgAQH9tcl3kdI53I.OTX6tou.3xsdJ.K8EhwJ49XvT6pZEC7YpHw01tW4dcQO6vEKItEeO78zWCOyUaqTihVPGDB9zZKePu
//gecici session id. her session a ozel 

//Rest Context Class
//https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_restcontext.htm
//Rest Request
//https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_restrequest.htm
//Rest Response
//https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_restresponse.htm#apex_System_RestResponse_addHeader
global class CaseProvider {

   /*
    @httpGet
    global static list<case> caseGonder(){
        
        list <case> result = [SELECT Id, CaseNumber, Origin, Priority, Reason, Subject 
                              FROM Case LIMIT 5];
        
        return result;
        
    }
*/
    	//Response olusturmak icin 
         //https://sfdc-code.com/create-a-rest-api-with-salesforce-dx-part-2/
     
     @HttpGet
    global static VOID doGet() { //VOID donerse body de response u biz manuel olarak yapariz
         RestResponse response = RestContext.response;
        RestRequest req = RestContext.request;
        
          case newCase;
        
          try {
            String id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
            newCase = [ SELECT  Id, Status, Origin, Subject  FROM Case WHERE Id = :id LIMIT 1  ];
            
            response.statusCode = 200;
            response.responseBody = Blob.valueOf(JSON.serialize(newCase));
              
          } catch (QueryException e) {
            response.statusCode = 404;
            response.responseBody = Blob.valueOf(e.getMessage());
          } catch (Exception e) {
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(e.getMessage());
          }
    }
    
     @HttpDelete
    global static string doDelete() {
     /*   RestRequest req = RestContext.request;
        
        system.debug('req.requestURI >> '+ req.requestURI); 
        //req.requestURI >> /cases
         
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('caseId >> '+ caseId);
        
        Case silinecekCase = [SELECT Id FROM Case WHERE Id =: caseId];
        delete silinecekCase;
        
     string silinenRecord = silinecekCase.id + ' li case recordu silindi.';
        
        return silinenRecord;
        
        //system.debug('req.httpMethod >> '+ req.httpMethod);
        //req.httpMethod >> DELETE
        //system.debug('req.headers >> '+ req.headers);
        
        /* 
req.headers >> {Accept=, 
Accept-Encoding=gzip, deflate, br, 
CipherSuite=ECDHE-RSA-AES256-GCM-SHA384 TLSv1.2 443, 
Connection=keep-alive, 
 ...}
        */

         // alttaki kisim body icerisinde ID gonderilirse silmek uzre yazildi 
    	string deleteSonuc = 'bos';
    
        RestRequest req = RestContext.request;
        
        string body = req.requestBody.toString();
        
       Map<String,object>  MapOfJason = (Map<String,object>)JSON.deserializeUntyped(body);
      
        string silinecekRecordId = string.valueOf(MapOfJason.get('Id'));
   
 	   Case silinecekCase = [SELECT Id FROM Case WHERE Id =: silinecekRecordId];
        delete silinecekCase;
        
        deleteSonuc = silinecekRecordId + ' Idli record basari ile silindi.' ;
        
          return deleteSonuc;
    }
    
    
    /*
    @httpPost
     global static STRING doPost() {
     string sonuc='doPost Calisti';
         
          RestRequest req = RestContext.request;        
        
         string body = req.requestBody.toString();
       Map<String,object>  MapOfJason = (Map<String,object>)JSON.deserializeUntyped(body);
        
      string orj =   string.valueOf(MapOfJason.get('Origin') ) ;
         system.debug(orj); // null
         // eger map icerisinde olmayan bir key verilrise null doner
         
         case newcase = new Case();
         newCase.Origin = string.valueOf(MapOfJason.get('Origin') ) ;
         newCase.Priority = string.valueOf(MapOfJason.get('Priority') ) ;
         newCase.Reason = string.valueOf(MapOfJason.get('Reason') ) ;
         newCase.Subject = string.valueOf(MapOfJason.get('Subject') ) ;
         newCase.Status = 'New';
         
         insert newcase;
         sonuc = newcase.Subject;
       return   sonuc;   
     }
   
    //  method parametresi ile alip kaydetmek
    @httpPost
    global static STRING doPost(string Priority , string Reason ,  string Subject ){
         string sonuc='doPost 2. method Calisti';
        
        case newcase = new Case();
       
         newCase.Priority = Priority ;
         newCase.Reason = Reason ;
         newCase.Subject = Subject;
         newCase.Status = 'New';
         newCase.Origin = 'Web' ;
        
         insert newcase;
        
        
       return   sonuc;     
    }
     */
    
    // 3. yontem 
    @httpPost
    global static STRING doPost() {
     string sonuc='doPost 3. method Calisti';
         
        RestRequest req = RestContext.request;   
        
        //  req.params.  bir adet MAP<string,string> data tipinde variable tutar
        //  map oldugu icin de  map methodlari ( keySet() ve get()) calisir.
           set<string> keySet =  req.params.keySet();        
        
       case newcase = new Case();
        
         newCase.Priority =req.params.get('Priority')  ;
         newCase.Reason = req.params.get('Reason')   ;
         newCase.Subject = req.params.get('Subject')   ;
         newCase.Status = 'New';
         newCase.Origin = 'Phone' ;
        
        insert newcase;
       sonuc= newCase.Subject;
        
        return   sonuc + ' subjectli case olsuturuldu ';
        
    }
    
    
    @httpPut
     global static STRING doPut() {
     string sonuc='doPUT Calisti';
         
          RestRequest req = RestContext.request;        
        
         string body = req.requestBody.toString();
       Map<String,object>  MapOfJason = (Map<String,object>)JSON.deserializeUntyped(body);
        
      string orj =   string.valueOf(MapOfJason.get('Origin') ) ;
         system.debug(orj); // null
         // eger map icerisinde olmayan bir key verilrise null doner
         
         case newcase = new Case();
         newCase.Id = string.valueOf(MapOfJason.get('Id') ) ;
         newCase.Origin = string.valueOf(MapOfJason.get('Origin') ) ;
         newCase.Priority = string.valueOf(MapOfJason.get('Priority') ) ;
         newCase.Reason = string.valueOf(MapOfJason.get('Reason') ) ;
         newCase.Subject = string.valueOf(MapOfJason.get('Subject') ) ;
         newCase.Status = 'New';
         
         upsert newcase;
         sonuc = newcase.Subject;
       return   sonuc;   
     }
    
    @httpPatch
     global static STRING doPatch() {
     string sonuc='doPatch Calisti';
         
           RestRequest req = RestContext.request;
        
         //URL de gelen caseId alttaki satir ile alindi
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
         //SF databaseden record getirildi
        Case updateEdilecekCase = [SELECT Id FROM Case WHERE Id =: caseId];
         
         //request icindeki body kismi alinip Map yapildi
         string body = req.requestBody.toString();
       Map<String,object>  MapOfJason = (Map<String,object>)JSON.deserializeUntyped(body);
        Set<String> keySet = MapOfJason.keySet();
         
         for(string fieldName : keySet){
             
             //updateEdilecekCase recordunun fieldini put ile degidtirdik
             updateEdilecekCase.put(fieldName,(STRING)MapOfJason.get(fieldName) );
             //string.valueOf(MapOfJason.get(fieldName)) == (STRING)MapOfJason.get(fieldName) )
             
         }
         
         update updateEdilecekCase;
     
         sonuc = updateEdilecekCase.Subject;
       return   sonuc;   
         
     }
    
    /*
         ödev:
    urlden id ile,
    param ile
    body ile
    body ile method parametresi içinden
    yapılacak get istekleri için istediğiniz object üzerinden kod yazınız.
     */
    
}