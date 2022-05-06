/**
 * This class is to call the Twilio API service
 **/
public class MessagingService {
public static String accountSid; 
public static String token; 
public static String fromPhNumber;
public static String endPointBaseURL;
public static MessagingService.ErrorResponseWrapper erw;

/**
 * Method called from opportunity trigger when the opportunity is closed won and Account is GOLD to send SMS to CEO.
 * */    
@future(callout=true)
public static void sendSMSToCEO(Set<Id> accountIds){
        List<String> lstAccountName = new List<String>();
        for(Account acct: [Select Id,Name FROM Account where id In :accountIds]){
            lstAccountName.add(acct.name);
        }
        String smsBody = 'Given account/s ' + lstAccountName.toString() +' are GOLD';
        CEO_Phone_Number__mdt ceo=[Select MasterLabel,Phone_Number__c FROM CEO_Phone_Number__mdt where MasterLabel='CEO'];
        String toNumber = ceo.Phone_Number__c;
        sendSMSUsingRestAPI(toNumber,smsBody);
    }
/**
 * Method to call Twilio API service 
 * */
public static String sendSMSUsingRestAPI(String toNumber, String smsBody){
    HttpRequest req = new HttpRequest();  
    setTwilioAPIDetails();
    req.setEndpoint(endPointBaseURL+'2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');
    req.setMethod('POST');
    String VERSION  = '3.2.0';
    req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
    req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
    req.setHeader('Accept', 'application/json');
    req.setHeader('Accept-Charset', 'utf-8');
    req.setHeader('Authorization','Basic '+
    EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));
    req.setBody('To='+EncodingUtil.urlEncode(toNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);
    Http http = new Http();
    HTTPResponse res = http.send(req);
    populateIntegrationObj(req,res);
    if(res.getStatusCode()==201){
        return 'SMS sent successfully';
    }else{
        ErrorResponseWrapper erw =(errorResponseWrapper)json.deserialize
(res.getBody(),errorResponseWrapper.class);
        throw new MyOtherException(erw.message); 
               
    }
       
   }
/**
 * Method to set the details of Twilio end point URL,SID,token etc from Custom settings- API Details-Twilio 
 * */    
public static void setTwilioAPIDetails(){
       API_details__c apidetails= API_details__c.getValues('Twilio');
       accountSid=apiDetails.get('accountSID__c').toString(); 
       token=apiDetails.get('Token__c').toString(); 
       fromPhNumber=apiDetails.get('FromPhone__c').toString();
       endPointBaseURL=apiDetails.get('EndPointURL__c').toString();
}
 
    public static void populateIntegrationObj(HttpRequest request,HTTPResponse res){
        try{
            Integration_Logs__c log = new Integration_Logs__c();
            log.request__c= request.getBody();
            log.Response__c= res.getBody();
            log.status__c = res.getStatus();
            insert log;
        }catch(Exception e){
            Exception_Logger__c eL = new Exception_Logger__c (Message__c=e.getMessage(),Line_Number__c=e.getLineNumber(),Class_Method__c	='MessagingService-populateIntegrationObj');
            insert eL;
        }
    }

public class MyOtherException extends Exception {}

/**
 * Wrapper class to parse the error messsage from API service.
 * */    
public class ErrorResponseWrapper{
       String code;
       String message;
       String moreInfo;
       String status;
   }

}