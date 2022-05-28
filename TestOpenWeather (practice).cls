public class TestOpenWeather {    
    public String city {get; set;}
    public String temp {get; set;}
    public String pressure {get; set;}
    public String humidity {get; set;}
    public String temp_min {get; set;}
    public String temp_max {get; set;}
    
    public TestOpenWeather(ApexPages.StandardController stdController) {
        Account account = (Account)stdController.getRecord();
        account = [];
        String accountCity = account.ShippingCity;
        String apiKey = '';
        
        String requestEndPoint = '';
        requestEndPoint += '?q='+accountCity;
        requestEndPoint += '&units=metric';
        requestEndPoint += '&APPID='+apiKey;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200) {
            Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(response.getbody());
            city = String.valueOf(results.get('name'));
            Map<String,Object> mainResults = (Map<String,Object>)(results.get('main'));
        } else {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There was an error in reading data');
            ApexPages.addMessage(myMsg);
        }
    }
}