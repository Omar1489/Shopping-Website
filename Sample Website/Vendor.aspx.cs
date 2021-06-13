using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Vendor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void postProduct(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("postProduct", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string productname = Product.Text;
        string category = Category.Text;
        string productdescription = ProductDescription.Text;
        string price = Price.Text;
        string color = Color.Text;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@vendorUsername", Session["field1"].ToString()));
        cmd.Parameters.Add(new SqlParameter("@product_name", productname));
        cmd.Parameters.Add(new SqlParameter("@category", category));
        cmd.Parameters.Add(new SqlParameter("@product_description", productdescription));
        cmd.Parameters.Add(new SqlParameter("@price", price));
        cmd.Parameters.Add(new SqlParameter("@color", color));

        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {
            Response.Write("Error");
        }
        conn.Close();
    }
    protected void editProduct(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("EditProduct", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string productname = Product.Text;
        string category = Category.Text;
        string productdescription = ProductDescription.Text;
        string price = Price.Text;
        string color = Color.Text;
        string serialno = SerialNumber.Text;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@vendorname", Session["field1"].ToString()));
        cmd.Parameters.Add(new SqlParameter("@product_name", productname));
        cmd.Parameters.Add(new SqlParameter("@category", category));
        cmd.Parameters.Add(new SqlParameter("@product_description", productdescription));
        cmd.Parameters.Add(new SqlParameter("@price", price));
        cmd.Parameters.Add(new SqlParameter("@color", color));
        cmd.Parameters.Add(new SqlParameter("@serialnumber", serialno));

        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {
            Response.Write("Error");
        }
        conn.Close();
    }

    protected void viewProducts(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@vendorname", Session["field1"].ToString()));
        //Executing the SQLCommand
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

        Label lbl_serialNum = new Label();
        lbl_serialNum.Text = "Serial Number ";
        form1.Controls.Add(lbl_serialNum);
        Label lbl_product = new Label();
        lbl_product.Text = "Product Name ";
        form1.Controls.Add(lbl_product);
        Label lbl_cat = new Label();
        lbl_cat.Text = "Category ";
        form1.Controls.Add(lbl_cat);
        Label lbl_productdes = new Label();
        lbl_productdes.Text = "Product Description ";
        form1.Controls.Add(lbl_productdes);
        Label lbl_pric = new Label();
        lbl_pric.Text = "Price ";
        form1.Controls.Add(lbl_pric);
        Label lbl_productcolor = new Label();
        lbl_productcolor.Text = "Color <br /> <br />";
        form1.Controls.Add(lbl_productcolor);
        while (rdr.Read())
        {
            int serialno = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
            string productname = rdr.GetString(rdr.GetOrdinal("product_name"));
            string category = rdr.GetString(rdr.GetOrdinal("category"));
            string productdescription = rdr.GetString(rdr.GetOrdinal("product_description"));
            decimal price = rdr.GetDecimal(rdr.GetOrdinal("price"));
            string color = rdr.GetString(rdr.GetOrdinal("color"));
            //Create a new label and add it to the HTML form

            Label lbl_serialNumber = new Label();
            lbl_serialNumber.Text = serialno + " ";
            form1.Controls.Add(lbl_serialNumber);
            Label lbl_productName = new Label();
            lbl_productName.Text = productname + " ";
            form1.Controls.Add(lbl_productName);
            Label lbl_category = new Label();
            lbl_category.Text = category + " ";
            form1.Controls.Add(lbl_category);
            Label lbl_productDescription = new Label();
            lbl_productDescription.Text = productdescription + " ";
            form1.Controls.Add(lbl_productDescription);
            Label lbl_price = new Label();
            lbl_price.Text = price + " ";
            form1.Controls.Add(lbl_productName);
            Label lbl_color = new Label();
            lbl_color.Text = color + " <br /> <br />";
            form1.Controls.Add(lbl_color);
        }

        conn.Close();
    }
    protected void addOffer(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("addOffer", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string offeramount = OfferAmount.Text;
        string expirydate = ExpiryDate.Text;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@offeramount", offeramount));
        cmd.Parameters.Add(new SqlParameter("@expiry_date", expirydate));

        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {
            Response.Write("Error");
        }
        conn.Close();
    }
    protected void applyOffer(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("applyOffer", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string offerid = OfferID.Text;
        string serialno = SerialNumber.Text;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@vendorname", Session["field1"].ToString()));
        cmd.Parameters.Add(new SqlParameter("@offerid", offerid));
        cmd.Parameters.Add(new SqlParameter("@serial", serialno));


        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {
            Response.Write("Error");
        }
        conn.Close();
    }
    protected void checkandremoveExpiryOffer(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("checkandremoveExpiredOffer", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string offerid = OfferID.Text;

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@offerid", offerid));


        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (SqlException)
        {
            Response.Write("Error");
        }
        conn.Close();
    }
}