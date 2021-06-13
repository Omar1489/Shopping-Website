<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vendor.aspx.cs" Inherits="Vendor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
                            <p>
                                <asp:Label ID="ProductLabel" runat="server" AssociatedControlID="Product">Product Name:</asp:Label>
                                <asp:TextBox ID="Product" runat="server" CssClass="textEntry"></asp:TextBox>
                                
                            </p>
                             <p>
                                <asp:Label ID="CategoryLabel" runat="server" AssociatedControlID="Category">Category:</asp:Label>
                                <asp:TextBox ID="Category" runat="server" CssClass="textEntry"></asp:TextBox>
                               
                            </p>
                             <p>
                                <asp:Label ID="ProductDescriptionLabel" runat="server" AssociatedControlID="ProductDescription">Product Description:</asp:Label>
                                <asp:TextBox ID="ProductDescription" runat="server" CssClass="textEntry"></asp:TextBox>
                               
                            </p>
                            <p>
                                <asp:Label ID="PriceLabel" runat="server" AssociatedControlID="Price">Price:</asp:Label>
                                <asp:TextBox ID="Price" runat="server" CssClass="textEntry"></asp:TextBox>
                              
                            </p>
                             <p>
                                <asp:Label ID="ColorLabel" runat="server" AssociatedControlID="COlor">Color:</asp:Label>
                                <asp:TextBox ID="Color" runat="server" CssClass="textEntry"></asp:TextBox>
                                
                            </p>
                             <p>
                                <asp:Label ID="SerialNumberLabel" runat="server" AssociatedControlID="SerialNumber">Serial Number:</asp:Label>
                                <asp:TextBox ID="SerialNumber" runat="server" CssClass="textEntry"></asp:TextBox>
                               
                            </p>
                            <p>
                                <asp:Label ID="OfferAmountLabel" runat="server" AssociatedControlID="OfferAmount">Offer Amount:</asp:Label>
                                <asp:TextBox ID="OfferAmount" runat="server" CssClass="textEntry"></asp:TextBox>
                                
                            </p>
                            <p>
                                <asp:Label ID="ExpiryDateLabel" runat="server" AssociatedControlID="ExpiryDate">Expiry Date:</asp:Label>
                                <asp:TextBox ID="ExpiryDate" runat="server" CssClass="textEntry"></asp:TextBox>
                               
                            </p>
                            <p>
                                <asp:Label ID="OfferIDLabel" runat="server" AssociatedControlID="OfferID">OfferID:</asp:Label>
                                <asp:TextBox ID="OfferID" runat="server" CssClass="textEntry"></asp:TextBox>
                              
                            </p>
                        <p class="submitButton">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Post Product" OnClick ="postProduct" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                        <p class="submitButton">
                            <asp:Button ID="EditProductButton" runat="server" CommandName="MoveNext" Text="Edit Product" OnClick ="editProduct" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                         <p class="submitButton">
                            <asp:Button ID="ViewProductsButton" runat="server" CommandName="MoveNext" Text="View Products" OnClick ="viewProducts" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                        <p class="submitButton">
                            <asp:Button ID="AddOfferButton" runat="server" CommandName="MoveNext" Text="Add Offer" OnClick ="addOffer" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                         <p class="submitButton">
                            <asp:Button ID="ApplyOfferButton" runat="server" CommandName="MoveNext" Text="Apply Offer" OnClick ="applyOffer" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                         <p class="submitButton">
                            <asp:Button ID="checkandremoveButton" runat="server" CommandName="MoveNext" Text="Remove Offer" OnClick ="checkandremoveExpiryOffer" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
        <div>
        </div>
    </form>
</body>
</html>