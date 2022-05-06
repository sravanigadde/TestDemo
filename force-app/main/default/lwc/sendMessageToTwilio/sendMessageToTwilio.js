import { LightningElement,api } from 'lwc';
/*import getAccountData from '@salesforce/apex/SendMessageToTwilioController.getAccountData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_TYPE_FIELD from '@salesforce/schema/Account.Account_Type__c';

import PHONE_FIELD from '@salesforce/schema/Account.Phone';
const FIELDS = ['Account.Name', 'Account.Phone','Account.Account_Type__c'];*/


export default class SendMessageToTwilio extends LightningElement {
    @api recordId;
    account;
    name;
    phone;
    acctType;
    retrievedRecordId = false;
    
    renderedCallback(){
        console.log('record id is :'+this.recordId);
    }
    /*renderedCallback(){
        if (!this.retrievedRecordId && this.recordId) {          
        getAccountData({ recId: this.recordId })
        .then((result) => {
            this.name = result.acctName;
            this.phone = result.acctPhone;
            this.acctType = result.acctType;
            this.error = undefined;
        })
        .catch((error) => {
            this.error = error;
            this.name = undefined;
            this.phone = undefined;
            this.acctType = undefined;
        });
        this.retrievedRecordId = true; 
        console.log('record id is :'+this.recordId);
        console.log('record id is :'+this.acctType);
        if(this.accountType == 'GOLD'){

        }else{
            
                const event = new ShowToastEvent({
                    title: 'This is not a gold customer',
                    message: 'This is not a gold customer',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(event);
                //this.dispatchEvent(new CloseActionScreenEvent());
            
        }
        }
    }
    */
}