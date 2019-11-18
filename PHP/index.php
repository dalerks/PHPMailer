<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <form action="Submit.php" method="post">
        <table>
            <tr>
                <td>Report Type</td>
                <td>     <select name="type" class="inputstandard"> 
                    <!-- <option value="default">Select a Report Type</option> -->
                     <option value="0"> By Campaign</option> 
                   <!-- <option value="1">All by Campaign Filter by Campaign List</option> -->
                     <option value="2">By Mailing List</option> 
                    <!-- <option value="3">All by Mailing List filter by Campaign</option>
                     <option value="4">All by Mailing List filter by Mailing List</option>-->
                </td>
                <td></td>
            </tr>
            <tr>
                <td> Filter by Campaign</td>
                <td>
                     <select name="Campaign" class="inputstandard"> 
                     <option value="default">ALL Campaigns</option> 
            <?php
            $myServer = "localhost";
            $myUser = "";
            $myPass = 
            $myDB = "mailer";
                $con = mysql_connect
            ($myServer, $myUser, $myPass);

                 if (!$con)
                 {
                   
                 die('Could not connect: ' . mysql_error());
                 }
                 mysql_select_db($myDB, $con);
                 
   $result = mysql_query('select campaign_name, campaignid from campaign') 
        or die (mysql_error()); 
    
        while ($row = mysql_fetch_assoc($result)) {
            echo '<option value="' . $row['campaign_name'] . '" name="' . $row['campaign_name']. '">' . $row['campaign_name']. '</option>';
        } 
  mysql_close($con);
            ?></select>
                </td>
                <td> </td>
            </tr>
              <tr>
                  <td> Filter by Mailing List</td>
                <td>           <select name="Mailinglist" class="inputstandard"> 
                     <option value="default">All Mailinglist </option> 
            <?php
                $con = mysql_connect("localhost","root",");
                 if (!$con)
                 {
                   
                 die('Could not connect: ' . mysql_error());
                 }
                 mysql_select_db("mailer", $con);
                 
   $result = mysql_query('select mailinglistID from mailinglist') 
        or die (mysql_error()); 
    
        while ($row = mysql_fetch_assoc($result)) {
            echo '<option value="' . $row['mailinglistID'] . '" name="' . $row['mailinglistID']. '">' . $row['mailinglistID']. '</option>';
        } 
  mysql_close($con);
            ?></select></td>
                
                <td>(This filter only works if sorted by Mailinglist)</td>
            </tr>
             <tr>
                <td>Enter a email to send the Report to</td>
                <td><input type="text" name="email" /></td>
                <td></td>
            </tr>
             <tr>
                <td>Use Fuzzy Logic</td>
                <td> <input type="checkbox" name="fuzzy" value="1" /></td>
                <td></td>
            </tr>
              <tr>
                <td></td>
                <td><input type="submit" /></td>
                <td></td>
            </tr>
        </table>
       
    </body>
    
</html>
