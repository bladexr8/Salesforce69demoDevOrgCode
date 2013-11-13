public with sharing class OrderViewExtension {
	
	// Order and Order Lines for the current context
	public Order__c CurrentOrder{get; set;}
	public List<Order_Line__c> OrderLines{get; set;}
	
	// public property for inserting new Order Line record
	public Order_Line__c NewOrderLine {get; set;}
	
	// constructor
	// Note that for a Controller Extension the standard
	// controller is passed in as a parameter
	public OrderViewExtension(ApexPages.StandardController controller)
	{
		CurrentOrder = new Order__c();
		// get record in current context from standard controller
		this.CurrentOrder = (Order__c)controller.getRecord();
		// initialize property in case we want to add a new order line
		NewOrderLine = new Order_Line__c();
		prepareFullOrder();
	}
	
	// get a List of Order Lines for the current order
	public void prepareFullOrder()
	{
		// initialise and fire SOQL Query to get Order Lines for current order
		OrderLines = new List<Order_Line__c>();
		OrderLines = [Select Id, Name, Order_Line_Item__c, 
						Line_Item_Price__c, Line_Item_Total__c, 
						Order_Line_Item__r.Item_Name__c,
						Order__c, Quantity__c
						FROM Order_Line__c WHERE Order__c = :this.CurrentOrder.Id
						ORDER BY Name ASC];
	}
	
	// Insert a new OrderLineItem
	public PageReference insertOrderLineItem() {
		try {
			NewOrderLine.Order__c = this.CurrentOrder.Id;
			insert NewOrderLine;
			// re-display Order Line Items
			prepareFullOrder();
			// reset public property for new insert
			NewOrderLine = new Order_Line__c();
		} catch (DmlException ex) {
			// Standard Controller overrides code below and 
			// displays standard error messages
			// Note Custom Message sent to ApexPage messages component
			//ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error(s) Saving Order Line Item');
			//ApexPages.addMessage(myMsg);
			//ApexPages.addMessages(ex);
		}
		return null;	// no page re-direct
	}

}