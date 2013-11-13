/*******************************************************************
 * Custom controller for the "Mobilizing a Visualforce Page" recipe. 
 * Returns a list of 50 contacts. 
 *******************************************************************/
public with sharing class MobileContactsController 
{
    // the list of contacts
    public List<Contact> contacts {get; set;}
    
    // constructor
    public MobileContactsController()
    {
        contacts=[select FirstName, LastName, LastModifiedDate, Title, Department from Contact order by LastName asc limit 50];
    }
}