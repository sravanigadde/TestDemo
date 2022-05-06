/**
 * Test class for the controller class SendMessageToTwilioController
 **/
@isTest
public class SendMessageToTwilioControllerTest {
        
    @isTest
    public static void getAccountDataTest(){
       Account acct  = new Account () ;
       acct.name ='Test Account';
       acct.phone = '+919886916030';
       acct.AnnualRevenue =3000000;
       acct.Annual_Revenue_Spent__c=400000;
       insert acct;
       System.debug('Account dedtails : '+acct);
       SendMessageToTwilioController.AccountDataWrapper acctWrapper =SendMessageToTwilioController.getAccountData(acct.Id);
       System.assertEquals(acct.name,acctWrapper.acctName);        
    }
    @isTest
     public static void sendSMSToAccountTest(){
         Test.setMock(HttpCalloutMock.class, new MessagingServiceMock());
         String msg =SendMessageToTwilioController.sendSMSToAccount('+919886916030');
         System.assertEquals(msg,'Success');        
    }
     
}