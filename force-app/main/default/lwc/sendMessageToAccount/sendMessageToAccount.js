import { LightningElement,api } from 'lwc';
import getAccountData from '@salesforce/apex/SendMessageToTwilioController.getAccountData';
import sendSMSToAccount from '@salesforce/apex/SendMessageToTwilioController.sendSMSToAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class SendMessageToAccount extends LightningElement {
    @api recordId;
    retrievedRecordId=false;
    name;
    phone;
    acctType;
    error;
    showCmp=false;

    connectedCallback(){
        if (!this.retrievedRecordId && this.recordId) {  
            this.retrievedRecordId =true;        
            getAccountData({ recId: this.recordId })
            .then((result) => {
                this.name = result.acctName;
                this.phone = result.acctPhone;
                this.acctType = result.acctType;
                if(this.acctType == 'GOLD'){
                    this.showCmp=true;
                }
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.name = undefined;
                this.phone = undefined;
                this.acctType = undefined;
            });
        }
    }
    sendSMS(){
        console.log('Inside send SMS');
        sendSMSToAccount({ phoneNum: this.phone })
        .then((result) => {
            console.log('Sending SMS');
            const event = new ShowToastEvent({
                title: 'SMS status',
                message: 'SMS sent successfully',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);   
            
        })
        .catch((error)=>{
            console.log('SMS exception'+error);
            const event = new ShowToastEvent({
                title: 'SMS status',
                message: 'Exception while sending SMS'+error,
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);

        });
        
    }
    
        
    }