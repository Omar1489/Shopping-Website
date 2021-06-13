using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Customer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void show_P(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("ShowProductsbyPrice", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        conn.Open();

        //IF the output is a table, then we can read the records one at a time
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            //Get the value of the attribute name in the Company table
            string Pname = rdr.GetString(rdr.GetOrdinal("product_name"));
            //Get the value of the attribute field in the Company table
            string Pd = rdr.GetString(rdr.GetOrdinal("product_description"));
            decimal price = rdr.GetDecimal(rdr.GetOrdinal("price"));
            decimal fprice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
            string color = rdr.GetString(rdr.GetOrdinal("color"));

            //Create a new label and add it to the HTML form
            Label lbl_CompanyName = new Label();
            lbl_CompanyName.Text = "Product name  : " + Pname;
            form1.Controls.Add(lbl_CompanyName);

            Label lbl_pd = new Label();
            lbl_pd.Text = "Product description  : " + Pd;
            form1.Controls.Add(lbl_pd);

            Label lbl_price = new Label();
            lbl_price.Text = "price  : " + price;
            form1.Controls.Add(lbl_price);

            Label lbl_fprice = new Label();
            lbl_fprice.Text = "final price  : " + fprice;
            form1.Controls.Add(lbl_fprice);

            Label lbl_color = new Label();
            lbl_color.Text = "color  : " + color + "  <br /> <br />";
            form1.Controls.Add(lbl_color);

        }
        //this is how you retrive data from session variable.
        string field1 = (string)(Session["field1"]);
        Response.Write(field1);
    }
    protected void createWishlist(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("createWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string user = (string)(Session["field1"]);
        string name = W_name.Text;



        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("name", name));





        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            Response.Write("Wishlist already exits .try another name");
        }
        conn.Close();



    }
    protected void addWishlist(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string user = (string)(Session["field1"]);
        string wishlistname = Wname.Text;
        string serial = Snumber.Text;



        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlistname));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));




        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            Response.Write("Product already exits in wishlist or the name of the wishlist is wrong.try again");
        }
        conn.Close();



    }
    protected void removeWishlist(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("removeFromWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string user = (string)(Session["field1"]);
        string wishlistname = Wname.Text;
        string serial = Snumber.Text;



        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlistname));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));




        //Executing the SQLCommand
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();



    }
    protected void addCC(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string user = (string)(Session["field1"]);
        string ccnumber = Cnum.Text;
        string expiry = Exp.Text;
        string cvvnum = cvv.Text;



        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@creditcardnumber", ccnumber));
        cmd.Parameters.Add(new SqlParameter("@expirydate", expiry));
        cmd.Parameters.Add(new SqlParameter("@cvv", cvvnum));




        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            Response.Write("Credit card already exists .Try again");
        }
        conn.Close();



    }
    protected void addcart(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("addToCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string user = (string)(Session["field1"]);
        string serial = Snum2.Text;



        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));




        //Executing the SQLCommand
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            Response.Write("Product already exits in Cart .try again");
        }
        conn.Close();



    }
    protected void removecart(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("removefromCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string user = (string)(Session["field1"]);
        string serial = Snum2.Text;



        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", user));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));




        //Executing the SQLCommand
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();



    }
    protected void makeorder(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("makeOrder", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
       

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername", Session["field1"].ToString()));

        //Save the output from the procedure
        SqlParameter count = cmd.Parameters.Add("@orderid", SqlDbType.Int);
        count.Direction = ParameterDirection.Output;
        SqlParameter count1 = cmd.Parameters.Add("@totalamount", SqlDbType.Int);
        count1.Direction = ParameterDirection.Output;



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

        Response.Write("orderid:" + count.Value.ToString() + " ");
        Response.Write("price:" + count1.Value.ToString());


    }
    protected void specifyamount(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string orderid = OrderID.Text;
        string cash = CashAmount.Text;
        string credit = CreditAmount.Text; 
        

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@customername",Session["field1"].ToString() ));
        cmd.Parameters.Add(new SqlParameter("@orderid", orderid));
        cmd.Parameters.Add(new SqlParameter("@cash", cash));
        cmd.Parameters.Add(new SqlParameter("@credit", credit));




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

    protected void choosecreditcard(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string CreditCard = CreditCardID.Text;
        string orderID = OrderID.Text;
        

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@creditcard", CreditCard));
        cmd.Parameters.Add(new SqlParameter("@orderid", orderID));
       




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
       protected void cancelorder(object sender, EventArgs e)
    {
        //Get the information of the connection to the database
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("cancelOrder", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        //To read the input from the user
        string orderid = OrderID.Text;
        

        //pass parameters to the stored procedure
        cmd.Parameters.Add(new SqlParameter("@orderid", orderid));
       




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