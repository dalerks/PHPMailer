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
        <?php

$myServer = "";

$myUser = "";

$myPass = "";

$myDB = "";

$s = @mssql_connect($myServer, $myUser, $myPass)

or die("Couldn't connect to SQL Server on $myServer");

$d = @mssql_select_db($myDB, $s)

or die("Couldn't open database $myDB");
  // echo 't'. $_POST["fuzy"];
if($_POST["fuzzy"]=='1'){
   // echo '1';
 $query = mssql_init("Mailer_Compare_Fuzzy", $s);   
}
 else {
  $query = mssql_init("Mailer_Compare", $s);  
}

//$Sort_type=1;
$Sort_type =$_POST["type"];
 $Sort_value2 =$_POST["Campaign"];

$Sort_value=$_POST["Mailinglist"];
$Sort_value2=1;
  //  echo  $Sort_value;

// Bind Peramaters To Send To Stored Proc.
mssql_bind($query, '@Sort_type', $Sort_type, SQLINT1);
mssql_bind($query, '@Sort_value', $Sort_value, SQLVARCHAR);
mssql_bind($query, '@Sort_value2', $Sort_value2, SQLINT1);

$result = mssql_query("SET ANSI_NULLS ON") or die(mssql_get_last_message());
$result = mssql_query("SET ANSI_WARNINGS ON") or die(mssql_get_last_message());
$result = mssql_execute($query);

$numcol = mssql_num_fields($result);


if ($Sort_type<2)
 {
    $header='<tr><th align=left>Campaign</th><th align=left> 800 number</th><th align=left> Count</th></tr>';

}
 else {  
     $header='<tr><th align=left>Mailing List</th><th align=left> Campaign</th><th align=left> 800 number</th><th align=left> Count</th></tr>';
    
}

$table= '<table>';
$table= $table. $header;
while($row = mssql_fetch_row($result))
    
{
    if(($_POST["type"]==0  && $_POST["Campaign"]=='default')||($_POST["type"]==0 &&$_POST["Campaign"]== $row[0] )|| ($_POST["type"]==2 && $_POST["Mailinglist"]=='default'&& $_POST["Campaign"]=='default')||($_POST["type"]==2 &&$_POST["Mailinglist"]== $row[0] )||($_POST["type"]==2 && $_POST["Mailinglist"]=='default' && $_POST["Campaign"]== $row[1] )
            )

    {
    

    $table= $table. '<tr>';
   // echo '<td>'.$_POST["Campaign"].'='.$row[0].'</td>';
for ($i = 0; $i <= $numcol-1; $i++) {
   

$table= $table. "<td>" . $row[$i] . "</td>";
}
 $table= $table. '</tr>';
}
}
$table= $table. '</table>';
echo $table;
    $to = $_POST["email"];
    $from = "Report@marketing.carepointmedical.com";
    $subject = "Your Requsted Report"; 
     $message = "
<html>
  <body>".$table.
   
  
 " </body>
</html>" ; 
      $headers  = "From: $from\r\n";
    $headers .= "Content-type: text/html\r\n";
       mail($to, $subject, $message, $headers); 
    
?>


    </body>
</html>
