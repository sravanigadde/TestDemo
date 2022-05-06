/**
 * Opportunity Trigger helper class
 **/
public class OpportunityTriggerHelper {
    
   /**
    * Get the account ids to update the Revenue spent in the accounts
    * */
    public static void setAccountIds(List<Opportunity> lstNewOpps, map<Id,Opportunity> mapOldOpps){
        Set<Id> accountIds= new Set<Id>();
        Triggers__c opportunityTrigger = Triggers__c.getValues('Opportunity');
        if(opportunityTrigger.Enable_Trigger__c){
        for(Opportunity opp:lstNewOpps ){
            Opportunity oldOpp =mapOldOpps.get(opp.Id);
            if((opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') 
               || (oldOpp.StageName == 'Closed Won' && opp.StageName != 'Closed Won')){
               accountIds.add(opp.AccountId); 
            }
        }
        }
        if(accountIds.size()>0){
            updateAccountRevenue(accountIds);
        }
          
    }
    
    /**
    * Update the Revenue spent in the accounts, call to send SMS to CEO
    * */
    public static void updateAccountRevenue(Set<Id> accountIds){
        Map<Id,Decimal> mapRevenueAmt = new Map<Id,Decimal>();
        for(Opportunity opp: [Select Id,Amount,AccountId FROM Opportunity Where AccountId IN :accountIds AND StageName='Closed Won']){
            Decimal amount ;
            if(mapRevenueAmt.get(opp.AccountId)==null){
                amount=opp.Amount;
            }else{
                amount= mapRevenueAmt.get(opp.AccountId)+opp.Amount;
            }
            mapRevenueAmt.put(opp.AccountId,amount);
        }
        List<Account> lstAccounts = new List<Account>();
        Set<Id> sendSMSAccountIds = new Set<Id>();
        for(Account acct : [Select id, Annual_Revenue_Spent__c FROM Account Where id IN :mapRevenueAmt.keySet()]){
            acct.Annual_Revenue_Spent__c= mapRevenueAmt.get(acct.id);
            if(acct.Annual_Revenue_Spent__c>= 50000){
               sendSMSAccountIds.add(acct.Id); 
            }
            lstAccounts.add(acct);
        }
        if(lstAccounts!=null && !lstAccounts.isEmpty() ){
            update lstAccounts;
        }
        if(sendSMSAccountIds.size()>0){
            MessagingService.sendSMSToCEO(sendSMSAccountIds);
        }
    }
}