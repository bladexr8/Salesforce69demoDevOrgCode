/*******************************************************************
 * Custom controller for the "Mobilizing a Visualforce Page" recipe. 
 * Returns a list of 10 accounts. 
 *******************************************************************/
public with sharing class MobileAccountsController 
{
    // the list of Accounts
    public List<Account> accs {get; set;}
    
    // constructor
    public MobileAccountsController()
    {
        accs=[select Name, Industry, Type, NumberOfEmployees, Phone from Account order by Name asc limit 10];
    }
}