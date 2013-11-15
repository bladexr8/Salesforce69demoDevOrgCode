public with sharing class OrderViewExtension {
	
	// Debugging Constant
	private static final string TAG = '***OrderViewExtension.cls - ';
	
	// Order for the current context
	public Order__c CurrentOrder{get; set;}
	
	// Order Lines for current Order
	public List<Order_Line__c> OrderLines{get; set;}
		
	// public property for inserting new Order Line record
	public Order_Line__c NewOrderLine {get; set;}
	
	// public property for the Order Line being edited
	public Id editOrderLineId {get; set;}
	
	
	// constructor
	public OrderViewExtension()
	{
		// initialize CurrentOrder property
		CurrentOrder = new Order__c();
				
		// initialize property in case we want to add a new order line
		NewOrderLine = new Order_Line__c();
		
		// initialize editOrderLineId to null
		editOrderLineId = null;
		
		// get the Order Lines
		prepareFullOrder();
	}
	
	// get a List of Order Lines for the current order
	public void prepareFullOrder()
	{
		// get the Current Order using id page parameter
		String id = ApexPages.currentPage().getParameters().get('id');
		if (id <> null) {
			try {
				// attempt to retrieve order using the passed in id
				CurrentOrder = [select Id, Name, Customer__c, Planned_Delivery_Date__c,
											Order_Lines_Total__c, Discount__c,
											Comments__c, Grand_Total__c 
								from Order__c where id = :id];
		
				// Get the Order Lines for the Order
				OrderLines = new List<Order_Line__c>();
				OrderLines = [Select Name, Order_Line_Item__c, 
								Line_Item_Price__c, Line_Item_Total__c, 
								Order_Line_Item__r.Item_Name__c,
								Order__c, Quantity__c
								FROM Order_Line__c WHERE Order__c = :this.CurrentOrder.Id
								ORDER BY Name ASC];
			} catch (Queryexception ex) {
				ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Order ID does not exist or is not unique!');
				ApexPages.addMessage(myMsg);
				
			} catch (Exception ex) {
				//System.debug('Caught ' + ex.getTypeName());
				ApexPages.addMessages(ex);
			}
			
		} else {
			// Note Custom Message sent to ApexPage messages component
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Current Order!');
			ApexPages.addMessage(myMsg);
		}		
	}
	
	// Insert a new OrderLineItem
	public PageReference insertOrderLine() {
		string methodName = 'insertOrderLine - ';
		System.debug(TAG + methodName + 'Inserting Order Line for Item #' + NewOrderLine.Order_Line_Item__c + '...');
		try {
			NewOrderLine.Order__c = this.CurrentOrder.Id;
			insert NewOrderLine;
			// re-display Order Line Items
			prepareFullOrder();
			// reset public property for new insert
			NewOrderLine = new Order_Line__c();
			System.debug(TAG + methodName + 'Successfully Inserted New Order Line...');
		} catch (DmlException ex) {
			ApexPages.addMessages(ex);
		}
		return null;	// no page re-direct
	}
	
	// delete an Order Line
	public PageReference removeOrderLine() {
		string methodName = 'removeOrderLine - ';
		System.debug(TAG + methodName + 'Removing Order Line...');
		
		return null;		
	}
	
	// Save the changes to an Order Line
	public PageReference saveOrderLine()
	{
		string methodName = 'saveOrderLines - ';
		System.debug(TAG + methodName + 'Saving Order Lines...');
		
		update OrderLines;
		prepareFullOrder();
		
		return cancelEditOrderLine();
	}
	
	public PageReference cancelEditOrderLine()
	{
		string methodName = 'cancelEditOrderLine - ';
		System.debug(TAG + methodName + 'Cancelling Edit of Order Line...');
		editOrderLineId = null;
		return null;
	}

}