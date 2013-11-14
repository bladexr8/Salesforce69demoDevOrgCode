/***************************************************************************
* Wrapper class for Order_Line__c objects in the "OrderLineItemsView" page.
* Encapsulates an OrderLine record and a unique key for that record.
* Note that the Salesforce unique Id cannot be used, as the record may not
* have been inserted into the database
****************************************************************************/
public with sharing class OrderLineWrapper {
	public Integer key {get; set;}
	public Order_Line__c orderLine {get; set;}
	
	// Constructor
	public OrderLineWrapper(Integer inKey, Order_Line__c inOrderLine)
	{
		key = inKey;
		orderLine = inOrderLine;
	}	
}