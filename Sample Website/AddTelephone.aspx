<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTelephone.aspx.cs" Inherits="Customer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <p>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" 
                                     CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
         <p>
                                <asp:Label ID="TeleLabel" runat="server" AssociatedControlID="TeleLabel">Phone number:</asp:Label>
                                <asp:TextBox ID="Telephone" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="Telephone" 
                                     CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
        <p class="submitButton">
                            <asp:Button ID="AddTelephoneButton" runat="server" CommandName="MoveNext" Text="Add Mobile" OnClick="addTelephone"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
        <div>
        </div>
    </form>
</body>
</html>
