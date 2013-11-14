public with sharing class OrderViewExtension {
	
	// Test comment from Macbook Air
	
	// Debugging Constant
	private static final string TAG = '***OrderViewExtension.cls - ';
	
	// Order for the current context
	public Order__c CurrentOrder{get; set;}
	
	//public List<Order_Line__c> OrderLines{get; set;}
	
	// wrapper class for the Order Lines being managed
	public List<OrderLineWrapper> wrappers {get; set;}
	
	// when user elects to add Order Lines, the number of 
	// Order Lines to add will be in this property
	public Integer addItemCount {get; set;}
	
	// when the user elects to delete an Order Line, the
	// record key from the OrderLine wrapper class will
	// be in this property
	public Integer keyToDelete {get; set;}
	
	// wrapper class unique record key master value
	public Integer mainKey {get; set;}
	
	// list of records to delete when user saves their work
	private List<Order_Line__c> toDelete = new List<Order_Line__c>();
	
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
		
		// get the Order Lines
		//prepareFullOrder();
		
		// initialize master value for wrapper class
		mainKey = 1;
		
		// default number of Order Lines to add
		addItemCount = 1;
		
		// initialize wrapper class
		wrappers = new List<OrderLineWrapper>();
		
		// Get the Order Lines for the Order
		List<Order_Line__c> orderLines = new List<Order_Line__c>();
		orderLines = [Select Id, Name, Order_Line_Item__c, 
						Line_Item_Price__c, Line_Item_Total__c, 
						Order_Line_Item__r.Item_Name__c,
						Order__c, Quantity__c
						FROM Order_Line__c WHERE Order__c = :this.CurrentOrder.Id
						ORDER BY Name ASC];
		
		// wrap the Order Lines for the Order in the wrapper class
		for (Order_Line__c ordLine : orderLines)
		{
			wrappers.add(new OrderLineWrapper(mainKey++, ordLine));
		}
	}
	
	// get a List of Order Lines for the current order
	//public void prepareFullOrder()
	//{
		// initialise and fire SOQL Query to get Order Lines for current order
	//	OrderLines = new List<Order_Line__c>();
	//	OrderLines = [Select Id, Name, Order_Line_Item__c, 
	//					Line_Item_Price__c, Line_Item_Total__c, 
	//					Order_Line_Item__r.Item_Name__c,
	//					Order__c, Quantity__c
	//					FROM Order_Line__c WHERE Order__c = :this.CurrentOrder.Id
	//					ORDER BY Name ASC];
	//}
	
	// Insert a new OrderLineItem
	//public PageReference insertOrderLineItem() {
	//	try {
	//		NewOrderLine.Order__c = this.CurrentOrder.Id;
	//		insert NewOrderLine;
	//		// re-display Order Line Items
	//		prepareFullOrder();
			// reset public property for new insert
	//		NewOrderLine = new Order_Line__c();
	//	} catch (DmlException ex) {
			// Standard Controller overrides code below and 
			// displays standard error messages
			// Note Custom Message sent to ApexPage messages component
			//ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error(s) Saving Order Line Item');
			//ApexPages.addMessage(myMsg);
			//ApexPages.addMessages(ex);
	//	}
	//	return null;	// no page re-direct
	//}
	
	// add new Order Lines
	public PageReference addOrderLines() {
		string methodName = 'addOrderLine - ';
		System.debug(TAG + methodName + 'Adding Order Lines...');
		
		return null;
	}
	
	// delete an Order Line
	public PageReference removeOrderLine() {
		string methodName = 'removeOrderLine - ';
		System.debug(TAG + methodName + 'Removing Order Line...');
		
		return null;		
	}
	
	// Save the changes to the Order Lines
	public PageReference saveOrderLines()
	{
		string methodName = 'saveOrderLines - ';
		System.debug(TAG + methodName + 'Saving Order Lines...');
		
		return null;
	}

}