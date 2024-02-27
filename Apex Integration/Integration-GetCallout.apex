public class MusteriGetCallout {

    private static final string API_ENDPOINT = 'https://gorest.co.in/public/v2/users/';
    //get method u icin callout
    
    //@future    callout method larinda @future kullanmak iyidir
    public static void butunMusterileriAl(){
	//https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_restful_http.htm
        
        // Instantiate a new Http object
    Http http = new Http();

     // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
    HttpRequest request = new HttpRequest();
    	//https://developer.salesforce.com/docs/atlas.en-us.248.0.apexref.meta/apexref/apex_classes_restful_http_httprequest.htm
        
        request.setMethod('GET');
        request.setEndpoint(API_ENDPOINT); //Set up >> Remote Site Details--- siteye izin vermek icin 
    
    // Send the request, and return a response
    HttpResponse response = http.send(request);
        //https://developer.salesforce.com/docs/atlas.en-us.248.0.apexref.meta/apexref/apex_classes_restful_http_httpresponse.htm
        
        // getStatus()     getHeaderKeys()  getStatusCode()  getBody()   getHeader(key)
        
        system.debug('response >>> ' + response);
        //response >>> System.HttpResponse[Status=OK, StatusCode=200]
        system.debug('getStatus() >>> ' + response.getStatus());
        //getStatus() >>> OK
        system.debug('getHeaderKeys() >>> ' + response.getHeaderKeys());
        //getHeaderKeys() >>> (x-pagination-limit, x-pagination-page, Server, x-links-previous, vary, x-frame-options, x-download-options, x-links-next, Report-To, referrer-policy, ...)
        system.debug('getHeader(key) >>> ' + response.getHeader('Content-Type'));
        //getHeader(key) >>> application/json; charset=utf-8
        system.debug('getStatusCode() >>> ' + response.getStatusCode());
        //getStatusCode() >>> 200
        system.debug('getBody() >>> ' + response.getBody());
        /*
         getBody() >>> 
         [{"id":6129337,"name":"Darshan Khan Sr.","email":"khan_darshan_sr@beier-batz.test","gender":"male","status":"inactive"},
         {"id":6129336,"name":"Devasree Iyengar","email":"devasree_iyengar@yundt-schamberger.example","gender":"male","status":"active"},
         {"id":6129335,"name":"Gop...
        */
    }
    
    
    
     public static void tekMusterileriAl(string userId){
	//https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_restful_http.htm
        
        // Instantiate a new Http object
    Http http = new Http();

     // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
    HttpRequest request = new HttpRequest();
    	//https://developer.salesforce.com/docs/atlas.en-us.248.0.apexref.meta/apexref/apex_classes_restful_http_httprequest.htm
        
        request.setMethod('GET');
        request.setEndpoint(API_ENDPOINT+userId); //Set up >> Remote Site Details--- siteye izin vermek icin 
    						//https://gorest.co.in/public/v2/users/6129342
    						
    // Send the request, and return a response
    HttpResponse response = http.send(request);
     
         system.debug('getBody() >>> ' + response.getBody());
      	//getBody() >>> {"id":6129336,"name":"Devasree Iyengar","email":"devasree_iyengar@yundt-schamberger.example","gender":"male","status":"active"}
    }
    
    
     public static void butunMusterileriAlveKaydet(){
	
    Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('GET');
        request.setEndpoint(API_ENDPOINT); //Set up >> Remote Site Details--- siteye izin vermek icin 
    
    HttpResponse response = http.send(request);
        
        // getStatus()     getHeaderKeys()  getStatusCode()  getBody()   getHeader(key)
               
       
         //[{"id":6129336,"name":"Devasree Iyengar","email":"devasree_iyengar@yundt-schamberger.example","gender":"male","status":"active"},
         //{...}]
        
         if(response.getStatusCode() == 200){
             
            string jsonStrList = response.getBody();
             
             list <MusteriContainer>  jsonMusteriList = (list <MusteriContainer> )JSON.deserialize(jsonStrList, list <MusteriContainer>.class); 
             system.debug(jsonMusteriList);
             //MusteriContainer:[email=devasree_iyengar@yundt-schamberger.example, gender=male, id=6129336, name=Devasree Iyengar, status=active], 
             //MusteriContainer:[email=do_gopi_khatri@will-kling.test, gender=female, id=6129335, name=Gopi Khatri DO, status=inactive], 
             
             list<Musteri__c> mstList = new  list<Musteri__c>();
             for(MusteriContainer mst : jsonMusteriList){
                 
                 Musteri__c yeniMusteri=new Musteri__c();
                 	 yeniMusteri.name = mst.name;
                     yeniMusteri.Email__c = mst.email;
                     yeniMusteri.Status__c = mst.status;
                     yeniMusteri.goRestId__c = mst.id;
                 	yeniMusteri.Gender__c  = mst.gender;
                 mstList.add(yeniMusteri);
                     
             }
             
             insert mstList;
         }
         
    }
    
    
    public static void tekMusterileriAlveKaydet(string musteriId){
	
    Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('GET');
        request.setEndpoint(API_ENDPOINT + musteriId); 
    
    HttpResponse response = http.send(request);
               
      
         if(response.getStatusCode() == 200){
             
            string jsonStr = response.getBody();
             //gelen response icerisinde sadece 1 tane json recordu var listeye deserialize edemem
             MusteriContainer  jsonMusteri = (MusteriContainer)JSON.deserialize(jsonStr, MusteriContainer.class); 
             system.debug(jsonMusteri);
             //MusteriContainer:[email=jain_lakshman_sr@walsh-nader.test, gender=female, id=5913778, name=Lakshman Jain Sr., status=inactive]
            
                 Musteri__c yeniMusteri=new Musteri__c();
                 	 yeniMusteri.name = jsonMusteri.name;
                     yeniMusteri.Email__c = jsonMusteri.email;
                     yeniMusteri.Status__c = jsonMusteri.status;
                     yeniMusteri.goRestId__c = jsonMusteri.id;
                 	yeniMusteri.Gender__c  = jsonMusteri.gender;
                       
             insert yeniMusteri;
         }
         
    }
    
    
    public static void ismeGoreMusterileriAlveKaydet(string musteriName){
	
    Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('GET');
        request.setEndpoint(API_ENDPOINT + '?name=' + musteriName);
    						//https://gorest.co.in/public/v2/users/?name=laksman  						
    				
    HttpResponse response = http.send(request);
        
     
         if(response.getStatusCode() == 200){
             
            string jsonStrList = response.getBody();
             
             list <MusteriContainer>  jsonMusteriList = (list <MusteriContainer> )JSON.deserialize(jsonStrList, list <MusteriContainer>.class); 
             //system.debug(jsonMusteriList);
             
             if(jsonMusteriList != null){
                 list<Musteri__c> mstList = new  list<Musteri__c>();
                 for(MusteriContainer mst : jsonMusteriList){
                     
                     Musteri__c yeniMusteri=new Musteri__c();
                         yeniMusteri.name = mst.name;
                         yeniMusteri.Email__c = mst.email;
                         yeniMusteri.Status__c = mst.status;
                         yeniMusteri.goRestId__c = mst.id;
                        yeniMusteri.Gender__c  = mst.gender;
                     mstList.add(yeniMusteri);
                         
                 }
             
               insert mstList;  
             }            
         }        
    }
    
    
    /*
    public static void ismeGoreBodyIleMusterileriAlveKaydet(string musteriName){
	
    Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('GET');
        request.setEndpoint(API_ENDPOINT);
    	
        //yapilan requestin body kismi bu sekilde set edilir
        string jsonStr = '{"name": "'+musteriName+'" }';
        request.setBody(jsonStr);					
    	system.debug(jsonStr);			
        
    HttpResponse response = http.send(request);
        system.debug(response.getStatusCode());	
     
         if(response.getStatusCode() == 200){
             
            string jsonStrList = response.getBody();
             
             list <MusteriContainer>  jsonMusteriList = (list <MusteriContainer> )JSON.deserialize(jsonStrList, list <MusteriContainer>.class); 
             //system.debug(jsonMusteriList);
             
             if(jsonMusteriList != null){
                 list<Musteri__c> mstList = new  list<Musteri__c>();
                 for(MusteriContainer mst : jsonMusteriList){
                     
                     Musteri__c yeniMusteri=new Musteri__c();
                         yeniMusteri.name = mst.name;
                         yeniMusteri.Email__c = mst.email;
                         yeniMusteri.Status__c = mst.status;
                         yeniMusteri.goRestId__c = mst.id;
                        yeniMusteri.Gender__c  = mst.gender;
                     mstList.add(yeniMusteri);
                         
                 }
             
               insert mstList;  
             }             
             
         }         
    }
    */
    
    
}