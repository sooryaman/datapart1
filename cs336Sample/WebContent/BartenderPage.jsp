<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="ISO-8859-1">
<title>BartenderPage</title>
</head>
<body>

<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity1 = request.getParameter("command1");
			String entity2 = request.getParameter("command2");
			
						//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select k.date, k.item as beer, sum(k.quantity) as sold from (select t.bill_id, b.date, b.time, t.quantity, t.item  from bills b left join transactions t on b.bill_id=t.bill_id where b.bartender='"+entity1+"'and b.bar='"+entity2+"' and t.type='beer') as k group by k.date, k.item order by k.date, k.item;";
		
			ResultSet result = stmt.executeQuery(str);
		%>
		
		<% out.println("Beers sold by "+entity1+ "by shifts are:") ;%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>Date of Shift</td>
			<td>Beer Sold</td>
			<td>Quantity sold</td>
			
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("date") %></td>
					<td><%= result.getString("beer") %></td>
					<td><%= result.getString("sold") %></td>
					
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		
		<%// out.print("Next, we have a graph with "+entity+"\'s most ordered beers") ;%>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		
		<br>
		
	<br>
	
		<% 
	StringBuilder myData3=new StringBuilder();
	String strData3 ="";
    String chartTitle3="";
    String legend3="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list3 = new ArrayList();
   		Map<String,Integer> map3 = null;
   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		
   		String graphType1 = request.getParameter("command1");  
   		String graphType2 = request.getParameter("command2");  
   		
   		//Make a query   		
   	   	String	query3 = "select g.date, count(g.sold)as SOLD from (select k.date, k.item, sum(k.quantity) as sold from (select t.bill_id, b.date, b.time, t.quantity, t.item  from bills b left join transactions t on b.bill_id=t.bill_id where b.bartender='"+graphType1+"' and b.bar='"+graphType2+"' and t.type='beer') as k group by k.date, k.item order by k.date, k.item) as g group by g.date;";
   		

   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query3);
   		//Process the result
   		while (result.next()) { 
   			map3=new HashMap<String,Integer>();
   	   		map3.put(result.getString("date"),result.getInt("SOLD")); 		
   			list3.add(map3);
   	    } 
   	    result.close();
   	    
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<String,Integer> hashmap : list3){
        		Iterator it = hashmap.entrySet().iterator();
            	while (it.hasNext()) { 
           		Map.Entry pair = (Map.Entry)it.next();
           		String key = pair.getKey().toString().replaceAll("'", "");
           		myData3.append("['"+ key +"',"+ pair.getValue() +"],");
           	}
        }
        strData3 = myData3.substring(0, myData3.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected
          chartTitle3 = "Beers sold per shift for "+ graphType1;
          legend3 = "Shift Date";
       
	}catch(SQLException e){
    		out.println(e);
    }
%>

<div><script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data3 = [<%=strData3%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title3 = '<%=chartTitle3%>'; 
			var legend3 = '<%=legend3%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat3 = [];
			data3.forEach(function(item) {
			  cat3.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart3 = Highcharts.chart('graphContainer3', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title3
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat3
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend3,
			        data: data3
			    }]
			});
			});
		
		</script>
	
	

	<div id="graphContainer3" style="width: 500px; height: 400px; margin: 0 auto"></div>
	</div>

	
</body>
</html>