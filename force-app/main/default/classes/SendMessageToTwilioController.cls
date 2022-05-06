/**
 * This is the controller call for the LWC component sendMessageToAccount
 **/
public class SendMessageToTwilioController {
    
    /**
     * This method is called to know the account type and get the phone number of an account.
     * */
    @AuraEnabled
    public static AccountDataWrapper getAccountData(String recId){
      Account acct = [Select Id,Name,Phone,Account_Type__c FROM Account where Id = :recId];
      AccountDataWrapper acctWrapper = new AccountDataWrapper();
      acctWrapper.acctName=acct.Name;
      acctWrapper.acctPhone=acct.Phone;
      acctWrapper.acctType=acct.Account_Type__c;
      return acctWrapper;
    }
    /**
     * This method is used to send an SMS to the respective account phone number.
     * */
    @AuraEnabled
    public static String sendSMSToAccount(String phoneNum){
        String msg;
        try{
        MessagingService.sendSMSUsingRestAPI(phoneNum,'You are a GOLD Customer');
        msg='Success';
        }catch(Exception e){
            msg='Excecption occurred'+e.getMessage();
            Exception_Logger__c eL = new Exception_Logger__c (Message__c=e.getMessage(),Line_Number__c=e.getLineNumber(),Class_Method__c	='SendMessageToTwilioController-sendSMSToAccount');
            insert eL;
        }
        return msg;
    }
    
  /*
   * Wrapper class used to store the Accoount required data. 
   * */
  public
  class AccountDataWrapper {
    @AuraEnabled public String acctName {
      get;
      set;
    }
    @AuraEnabled public String acctPhone {
      get;
      set;
    }
    @AuraEnabled public String acctType {
      get;
      set;
    }   
  }
   

}