public class MusteriPostCallout {

     private static final string API_ENDPOINT = 'https://gorest.co.in/public/v2/users/';
    private static final string TOKEN = 'Bearer ecdb10b1f0e97d6a298e00ade8c4d468277435885eecfd9622478aa12d919a3f';
    
    public static void musteriGonder(string musteriIsmi, string musteriEmail, string musteriGender, string musteriStatus ){
	
    Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setEndpoint(API_ENDPOINT+ '?name='+musteriIsmi+'&email='+musteriEmail+'&gender='+musteriGender+'&status='+musteriStatus); 
    //https://gorest.co.in/public/v2/users/?name=xxxx&email=xxx@xxx.com&gender=male&status=active
   		
        request.setHeader('Authorization' , TOKEN );
        
        //Content-Type
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        
        HttpResponse response = http.send(request);
       
        if(response.getStatusCode()==201){
             system.debug('basari ile kayit yapildi ');
             system.debug( response.getBody());
        }else{
             system.debug(response.getStatusCode()+ ' hatasi alindi ' );
            	
        }               
    }
    
    
    public static void musterileriIDileGonder(string musteriID){
	
        Musteri__c musteri = [SELECT Status__c, Gender__c, goRestId__c, Email__c, Name, Id 
                              FROM Musteri__c WHERE id =: musteriID LIMIT 1];
    
            
     Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setEndpoint(API_ENDPOINT+ '?name='+musteri.Name+'&email='+musteri.Email__c+'&gender='+musteri.Gender__c+'&status='+musteri.Status__c); 
    //https://gorest.co.in/public/v2/users/?name=xxxx&email=xxx@xxx.com&gender=male&status=active
   		
        request.setHeader('Authorization' , TOKEN );
        
        //Content-Type
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        
        HttpResponse response = http.send(request);
       
        if(response.getStatusCode()==201){
             system.debug('basari ile kayit yapildi ');
             system.debug( response.getBody());
        }else{
             system.debug(response.getStatusCode()+ ' hatasi alindi ' );
            	
        }                
    }
    
    
    public static void musteriBodyIleGonder(string musteriIsmi, string musteriEmail){
	
    Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setEndpoint(API_ENDPOINT); 
   		
        request.setHeader('Authorization' , TOKEN );
        
        //Content-Type
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        
        //body ayarlanacak
        string body= '{"name": "'+musteriIsmi+'","email": "'+musteriEmail+'","gender": "male","status": "active"}';
        request.setBody(body);
        
        /*
         {
        "name": "Yeni Musteri 88",
        "email": "xxx@deneme88.com",
        "gender": "male",
        "status": "active"
    	}
        */ 
        
        HttpResponse response = http.send(request);
       
        if(response.getStatusCode()==201){
             system.debug('basari ile kayit yapildi ');
             system.debug( response.getBody());
        }else{
             system.debug(response.getStatusCode()+ ' hatasi alindi ' );
            	
        }               
    }
    
    
    public static void musterileriIdBodyIleGonder(string musteriID){
	
       
     Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setEndpoint(API_ENDPOINT); 
   		
        request.setHeader('Authorization' , TOKEN );
        
        //Content-Type
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        
         Musteri__c musteri = [SELECT Status__c, Gender__c, goRestId__c, Email__c, Name, Id 
                              FROM Musteri__c WHERE id =: musteriID LIMIT 1];
    
            
         string body= '{"name": "'+musteri.Name+'","email": "'+musteri.Email__c+'","gender": "male","status": "active"}';
        request.setBody(body);
        
        HttpResponse response = http.send(request);
       
        if(response.getStatusCode()==201){
             system.debug('basari ile kayit yapildi ');
             system.debug( response.getBody());
        }else{
             system.debug(response.getStatusCode()+ ' hatasi alindi ' );
            	
        }                
    }
    
    
    
    public static void musteriListesiGonder(list < Musteri__c > musteriList){
	//code dogru ama goRest lsite ile almaya uygun bi yapi olmadigi icin 422 hatasi veriyor
       
     Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setEndpoint(API_ENDPOINT); 
   		
        request.setHeader('Authorization' , TOKEN );
        
        //Content-Type
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        
        list <MusteriContainer> sahteMusteriList = new list <MusteriContainer>();
        
        for(Musteri__c mst : musteriList){
            
             musteriContainer sahteMusteri = new musteriContainer();
            sahteMusteri.name=mst.name;
            sahteMusteri.email=mst.Email__c;
            sahteMusteri.status=mst.Status__c;
            sahteMusteri.gender=mst.Gender__c;
            
            sahteMusteriList.add(sahteMusteri);            
            
        }
    
          String jsonStrList = JSON.serialize(sahteMusteriList);
        
        request.setBody(jsonStrList);  
        
        
        HttpResponse response = http.send(request);
       
       
        if(response.getStatusCode()==201){
             system.debug('Liste basari ile kayit yapildi ');
             system.debug( response.getBody());
        }else{
             system.debug(response.getStatusCode()+ ' hatasi alindi ' );
            system.debug(response.getBody());	
        }                
    }
    
    
    
    
    @future(callout=true) //triggerden callout yapabilmek icin
    public static void musterileriIdBodyIleGonderSerialized(string musteriID){
	
       
     Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setEndpoint(API_ENDPOINT); 
   		
        request.setHeader('Authorization' , TOKEN );
        
        //Content-Type
        request.setHeader('Content-Type', 'application/json; charset=UTF-8');
        
         Musteri__c musteri = [SELECT Status__c, Gender__c, goRestId__c, Email__c, Name, Id 
                              FROM Musteri__c WHERE id =: musteriID LIMIT 1];
    
        musteriContainer sahteMusteri = new musteriContainer();
            sahteMusteri.name=musteri.name;
            sahteMusteri.email=musteri.Email__c;
            sahteMusteri.status=musteri.Status__c;
            sahteMusteri.gender=musteri.Gender__c;
        //karsida bu fieldlar required ama bizde degil o yuzden if ile check etmek lazim
        String jsonStr = JSON.serialize(sahteMusteri);
        
        request.setBody(jsonStr);
        
        
        HttpResponse response = http.send(request);
       
        if(response.getStatusCode()==201){
             system.debug('basari ile kayit yapildi ');
             system.debug( response.getBody());
        }else{
             system.debug(response.getStatusCode()+ ' hatasi alindi ' );
            	
        }                
    }
    
    
    
}




////---Trigger---////

trigger MusteriTrigger on Musteri__c (after update) {

    
    for(Musteri__c mst:trigger.new){
        
        musteri__c mstOld= trigger.oldMap.get(mst.id);
        
        if(mstOld.goRest_Post_Et__c == false && mst.goRest_Post_Et__c == true){
            
            MusteriPostCallout.musterileriIdBodyIleGonderSerialized(mst.id);
        }
    }
    
    
}



