<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Customer.aspx.cs" Inherits="Customer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <p>
                                <asp:Label ID="CreditCardLabel" runat="server" AssociatedControlID="CreditCardID">CreditCardID:</asp:Label>
                                <asp:TextBox ID="CreditCardID" runat="server" CssClass="textEntry"></asp:TextBox>
                               
                            </p>
         <p>
                                <asp:Label ID="OrderLabel" runat="server" AssociatedControlID="OrderID">OrderID:</asp:Label>
                                <asp:TextBox ID="OrderID" runat="server" CssClass="textEntry"></asp:TextBox>
                               
                            </p>
          <p>
                                <asp:Label ID="CashLabel" runat="server" AssociatedControlID="CashAmount">CashAmount:</asp:Label>
                                <asp:TextBox ID="CashAmount" runat="server" CssClass="textEntry"></asp:TextBox>
                              
                            </p>
          <p>
                                <asp:Label ID="CreditLabel" runat="server" AssociatedControlID="CreditAmount">CreditAmount:</asp:Label>
                                <asp:TextBox ID="CreditAmount" runat="server" CssClass="textEntry"></asp:TextBox>
                               
                            </p>
         <p class="submitButton">
                            <asp:Button ID="ChooseCreditCardButton" runat="server" CommandName="MoveNext" Text="Choose Credit Card" OnClick="choosecreditcard"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
        <p class="submitButton">
                            <asp:Button ID="CancelOrderButton" runat="server" CommandName="MoveNext" Text="Cancel Order" OnClick="cancelorder"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
         <p class="submitButton">
                            <asp:Button ID="SpecifyAmountButton" runat="server" CommandName="MoveNext" Text="Specify Amount" OnClick="specifyamount"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
         <p class="submitButton">
                            <asp:Button ID="MakeOrderButton" runat="server" CommandName="MoveNext" Text="Make Order" OnClick="makeorder"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
         <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Show products" OnClick="show_P"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                            <br />
                            <br />
                            Add products to a wishlist&nbsp;
                            <br />
                                <asp:Label ID="UserNameLabel0" runat="server" AssociatedControlID="Wname">Wishlist Name:</asp:Label>
                                <asp:TextBox ID="Wname" runat="server" CssClass="textEntry"></asp:TextBox>
                                <br />
                            <br />
                                <asp:Label ID="UserNameLabel1" runat="server" AssociatedControlID="Snumber">Serial number:</asp:Label>
                                <asp:TextBox ID="Snumber" runat="server" CssClass="textEntry"></asp:TextBox>
                                <br />
                            <br />
                            <asp:Button ID="CreateUserButton0" runat="server" CommandName="MoveNext" Text="Add product" OnClick="addWishlist"
                                 ValidationGroup="RegisterUserValidationGroup" style="margin-bottom: 6px"/>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="CreateUserButton2" runat="server" CommandName="MoveNext" Text="Remove" OnClick="removeWishlist"
                                 ValidationGroup="RegisterUserValidationGroup" style="margin-bottom: 6px" Width="104px"/>
                            <br />
                            -------------------------------------------------------------------------------------------<br />
                            Create a wishlist<br />
                                <asp:Label ID="UserNameLabel3" runat="server" AssociatedControlID="W_name">Wishlist Name:</asp:Label>
                                &nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="W_name" runat="server" CssClass="textEntry"></asp:TextBox>
                                <br />
                            <br />
                            <asp:Button ID="CreateUserButton1" runat="server" CommandName="MoveNext" Text="Create" OnClick="createWishlist"
                                 ValidationGroup="RegisterUserValidationGroup" style="margin-bottom: 6px"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <br />
                            -------------------------------------------------------------------------------------------<br />
                            Add new Credit Card<br />
                            <br />
                                <asp:Label ID="UserNameLabel4" runat="server" AssociatedControlID="Cnum">Credit Card number:</asp:Label>
                                &nbsp;
                                <asp:TextBox ID="Cnum" runat="server" CssClass="textEntry"></asp:TextBox>
                                <br />
                            <br />
                                <asp:Label ID="UserNameLabel5" runat="server" AssociatedControlID="Exp">Expiry date :</asp:Label>
                                &nbsp;
                                <asp:TextBox ID="Exp" runat="server" CssClass="textEntry"></asp:TextBox>
                                <br />
                            <br />
                                <asp:Label ID="UserNameLabel6" runat="server" AssociatedControlID="cvv">CVV :</asp:Label>
                                &nbsp;
                                <asp:TextBox ID="cvv" runat="server" CssClass="textEntry"></asp:TextBox>
                                <br />
                            <br />
                            <asp:Button ID="CreateUserButton3" runat="server" CommandName="MoveNext" Text="Add" OnClick="addCC"
                                 ValidationGroup="RegisterUserValidationGroup" style="margin-bottom: 6px"/>
                            <br />
                            <br />
                            ------------------------------------------------------------------------------------------<br />
                            Add/Remove from cart<br />
                            <br />
                                <asp:Label ID="UserNameLabel7" runat="server" AssociatedControlID="Snum2">Serial number:</asp:Label>
                                &nbsp;
                                <asp:TextBox ID="Snum2" runat="server" CssClass="textEntry"></asp:TextBox>
                                <br />
                            <br />
                            <asp:Button ID="CreateUserButton4" runat="server" CommandName="MoveNext" Text="Add product" OnClick="addcart"
                                 ValidationGroup="RegisterUserValidationGroup" style="margin-bottom: 6px"/>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="CreateUserButton5" runat="server" CommandName="MoveNext" Text="Remove" OnClick="removecart"
                                 ValidationGroup="RegisterUserValidationGroup" style="margin-bottom: 6px" Width="104px"/>
                            <br />
                            <br />
        <div>
        </div>
    </form>
</body>
</html>
