/**
 * One Time batch to update the existing account records.
 **/
public class UpdateAccountRevenueBatch implements Database.Batchable<SObject> {
    
    public Database.QueryLocator  start(Database.BatchableContext bc) {
        String query ='Select Id FROM Account where Annual_Revenue_Spent__c =null'; 
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Account> records){
        Set<Id> accountIds = new Set<Id>();
        for(Account acct: records){
            accountIds.add(acct.Id);
        }
        OpportunityTriggerHelper.updateAccountRevenue(accountIds);
    }    
    public void finish(Database.BatchableContext bc){
        // nothing to excute
    }    

}