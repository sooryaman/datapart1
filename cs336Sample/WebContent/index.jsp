<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Hi Beer World</title>
	</head>
	<body>

		<b>DRINKER PAGE</b>
						  
		<br>
	
		<form method="get" action="DrinkerPage.jsp">
		 
		 Enter Drinker Name:  <input type="text" name="command" value="drinker"/>
		
		  <br>
		  <input type="submit" value="submit" />
		</form>
		<br>
		<br>
		
	   <b>BAR PAGE</b> 
	    
	    <form method="get" action="BarPage.jsp">
		 
		 Enter Bar Name:  <input type="text" name="command" value="bar"/>
		
		  <br>
		  <input type="submit" value="submit" />
		</form>
	    
	<br>
	<br>
	   <b>BEER PAGE</b>
	   
	   <form method="get" action="BeerPage.jsp">
		 
		 Enter Bar Name:  <input type="text" name="command" value="beer"/>
		
		  <br>
		  <input type="submit" value="submit" />
		</form>
		
		<br>
		<br>
		
		<b> BARTENDER PAGE </b>
		
		 <form method="get" action="BartenderPage.jsp">
		 
		 Enter Bartender Name:  <input type="text" name="command1" value="bartender"/>
		
		  <br>
		  Enter Bar Name: <input type="text" name="command2" value="bar"/>
		  <input type="submit" value="submit" />
		</form>
		<br> 
		Bartender Ranking: 
		<br>
		Select a day
		<form method="get" action="BartenderRankPage.jsp">
			<select name="com1" size=1>
				<option value="Monday">Monday</option>
				<option value="Tuesday">Tuesday</option>
				<option value="Wednesday">Wednesday</option>
				<option value="Thursday">Thursday</option>
				<option value="Friday">Friday</option>
				<option value="Saturday">Saturday</option>
				<option value="Sunday">Sunday</option>
			</select>&nbsp;<br> 
	
	<br>
	 
		 
		 Enter Bar Name:  <input type="text" name="com2" value="beer"/>
		
		  <br>
		 
		
		
		<br>
		Select start of shift
		
			<select name="com3" size=1>
				<option value="8">8am</option>
				<option value="9">9am</option>
				<option value="10">10am</option>
				<option value="11">11am</option>
				<option value="12">12pm</option>
				<option value="13">1pm</option>
				<option value="14">2pm</option>
				<option value="15">3pm</option>
				<option value="16">4pm</option>
				<option value="17">5pm</option>
				<option value="18">6pm</option>
				<option value="19">7pm</option>
				<option value="20">8pm</option>
				<option value="21">9pm</option>
				<option value="22">10pm</option>
				
			</select>&nbsp;<br>
		
		<br>
		<br>
		Select end of shift
		
			<select name="com4" size=1>
				<option value="9">9am</option>
				<option value="10">10am</option>
				<option value="11">11am</option>
				<option value="12">12pm</option>
				<option value="13">1pm</option>
				<option value="14">2pm</option>
				<option value="15">3pm</option>
				<option value="16">4pm</option>
				<option value="17">5pm</option>
				<option value="18">6pm</option>
				<option value="19">7pm</option>
				<option value="20">8pm</option>
				<option value="21">9pm</option>
				<option value="22">10pm</option>
				<option value="23">11pm</option>
			</select>&nbsp;<br>
			
			
			 <input type="submit" value="submit">
		</form>
		
		
	    
	<br>
	<br>
	<b> MANUFACTURER PAGE</b>
	<form method="get" action="ManufacturerPage.jsp">
		 
		 Enter Bar Name:  <input type="text" name="command" value="manufacturer"/>
		
		  <br>
		  <input type="submit" value="submit" />
		</form>
	    
	<br>
	
	
	
	<br>
		<form method="get" action="sellsNewBeer.jsp">
			<table>
				<tr>    
					<td>Bar</td><td><input type="text" name="barvalia"></td>
				</tr>
				<tr>
					<td>Beer</td><td><input type="text" name="beer"></td>
				</tr>
				<tr>
					<td>Price</td><td><input type="text" name="price"></td>
				</tr>
			</table>
			<input type="submit" value="Add the selling beer!">
		</form>
	<br>
	
	
	Alternatively, lets type in a new bar, a new beer, and a price that this bar will sell the beer for.
	<br>
		<form method="post" action="newBarBeerPrice.jsp">
		<table>
		<tr>    
		<td>Bar</td><td><input type="text" name="bar"></td>
		</tr>
		<tr>
		<td>Beer</td><td><input type="text" name="beer"></td>
		</tr>
		<tr>
		<td>Price</td><td><input type="text" name="price"></td>
		</tr>
		</table>
		<input type="submit" value="Add me!">
		</form>
	<br>
	
	Or we can query the beers with price:
	<br>
		<form method="get" action="query.jsp">
			<select name="price" size=1>
				<option value="3.0">$3.0 and under</option>
				<option value="5.0">$5.0 and under</option>
				<option value="8.0">$8.0 and under</option>
			</select>&nbsp;<br> <input type="submit" value="submit">
		</form>
	<br>
	
	Show me a graph for:
	<br>
		<form method="get" action="showGraph.jsp">
			<select name="graph" size=1>
				<option value="beersPerBar">Number of beers sold by bar</option>
				<option value="barsPerDrinker">Number of bars each drinker frequents</option>
			</select>&nbsp;<br> <input type="submit" value="submit">
		</form>
	<br>

</body>
</html>