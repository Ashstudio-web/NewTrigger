public class ContactHandler implements ITrigger
{

    private List<Account> accountsToUpdate = new List<Account>();

public void bulkBefore(){
system.debug('--- bulkbEfore is called');
}

public void bulkAfter() {
     Set<Id> accIds = new Set<Id>();
        
        // Handle Insert & Update
        if (Trigger.isInsert || Trigger.isUpdate) {
            for (Contact con : (List<Contact>) Trigger.new) {
                if (con.AccountId != null) {
                    accIds.add(con.AccountId);
                }
            }
        }
        
        // If we found relevant Accounts, call the Helper
        if (!accIds.isEmpty()) {
            accountsToUpdate.addAll(ContactHelper.updateAccountDescription(accIds));
        }
    }

public void afterInsert(SObject so){
system.debug('--- afterInsert is called');

}


public void beforeInsert(SObject so){
system.debug('--- beforeInsert is called');


}
public void beforeUpdate(SObject oldSo, SObject so){
system.debug('--- beforeUpdate is called');

}

public void beforeDelete(SObject so){
system.debug('--- beforeDelete is called');
}

public void afterUpdate(SObject oldSo, SObject so){
system.debug('--- afterUpdate is called');

}

public void afterDelete(SObject so){
system.debug('--- afterDelete is called');
}

public void andFinally() {
    if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
}}
