trigger OpportunityTrigger on Opportunity (After update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHelper.setAccountIds(Trigger.new,Trigger.oldMap);
    }
}