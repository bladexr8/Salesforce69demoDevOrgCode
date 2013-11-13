public with sharing class OrderLineItemController {
	
	/* Controller to retrieve the existing OrderLineItem list and
	   add a new OrderLineItem record */
	
	// public property for inserting new record
	public Order_Line_Item__c NewItem {get; set;}
	
	// constructor must take no arguments for a custom controller
	public OrderLineItemController()
	{
		NewItem = new Order_Line_Item__c();
	}
	
	// get existing items to show in a table 
	// (exposed as a property with custom getter)
	public List<Order_Line_Item__c> ExistingItems
	{
		get {
			ExistingItems = new List<Order_Line_Item__c>();
			ExistingItems = [SELECT id, Name, Item_Name__c, Unit_Price__c FROM Order_Line_Item__c LIMIT 100];
			return ExistingItems;	
		}
		set;
	}
	
	// Insert a new OrderLineItem
	public PageReference insertNewItem() {
		try {
			insert NewItem;
			// reset public property for new insert
			NewItem = new Order_Line_Item__c();
		} catch (DmlException ex) {
			ApexPages.addMessages(ex);
		}
		return null;	// no page re-direct
	}
} // END Controller