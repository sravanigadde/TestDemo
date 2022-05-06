public class MessagingServiceMock implements HttpCalloutMock{
 public HttpResponse respond(HttpRequest req){
    HttpResponse res = new HttpResponse();
    res.setHeader('Content-Type','application/json');
    res.setBody('{"sid": "SMa171224f3aed4e6abb6d37411d57899c", "date_created": "Fri, 06 May 2022 06:55:27 +0000", "date_updated": "Fri, 06 May 2022 06:55:27 +0000", "date_sent": null, "account_sid": "AC6518b5b75c6e10af98daeaa98a3dc509", "to": "+919886916030", "from": "+17372658224", "body": "Test Msg", "status": "queued", "direction": "outbound-api", "api_version": "2010-04-01", "price": null, "price_unit": "USD", "uri": "/2010-04-01/Accounts/AC6518b5b75c6e10af98daeaa98a3dc509/SMS/Messages/SMa171224f3aed4e6abb6d37411d57899c.json", "num_segments": "1"}');
    res.setStatusCode(201);
    return res;
 }
}