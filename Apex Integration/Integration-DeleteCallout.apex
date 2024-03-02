public class MusteriDeleteCallout {

    
     private static final string API_ENDPOINT = 'https://gorest.co.in/public/v2/users/';
    private static final string TOKEN = 'Bearer ecdb10b1f0e97d6a298e00ade8c4d468277435885eecfd9622478aa12';
    
    public static void musteriSil(string musteriId){
	
    Http http = new Http();

    HttpRequest request = new HttpRequest();
        
        request.setMethod('DELETE');
        request.setEndpoint(API_ENDPOINT+musteriId ); 
    //https://gorest.co.in/public/v2/users/6619615
   		
        request.setHeader('Authorization' , TOKEN );
        
        
        HttpResponse response = http.send(request);

           if(response.getStatusCode() >= 200 && response.getStatusCode() < 300){
             system.debug(response.getStatusCode()+' >> Record basari ile silindi. ');
             
        }else{
             system.debug(response.getStatusCode()+ ' hatasi alindi ' );
            	
        }   
    }
    
    
}
