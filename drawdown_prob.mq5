//+------------------------------------------------------------------+
//| Expert Advisor initialization function                           |
//+------------------------------------------------------------------+
int OnInit()
{
    // Set the maximum allowed drawdown percentage
    double maxDrawdown = 3.0;

    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert Advisor start function                                     |
//+------------------------------------------------------------------+
void OnTick()
{
    // Get the current account information
    MqlAccount account;
    if(!AccountInfo(account))
    {
        Print("Failed to get account information!");
        return;
    }
    
    // Calculate the current drawdown percentage
    double drawdownPercentage = (account.Balance - account.Equity) / account.Balance * 100.0;
    
    // Check if drawdown exceeds the maximum allowed
    if(drawdownPercentage > maxDrawdown)
    {
        // Deactivate the user account
        DisableAccount();
        
        // Print a message indicating the account has been deactivated
        Print("User account deactivated due to drawdown exceeds ", maxDrawdown, "%!");
        
        // You can also log and send notifications here
    }
}

//+------------------------------------------------------------------+
//| Function to deactivate the user account                           |
//+------------------------------------------------------------------+
void DisableAccount()
{
    // Get the current login ID
    int loginID = AccountInfoInteger(ACCOUNT_LOGIN);
    
    // Close the MetaTrader terminal to disable the account
    TerminalClose(loginID);
    
    Print("Account ", loginID, " has been disabled.");

}
