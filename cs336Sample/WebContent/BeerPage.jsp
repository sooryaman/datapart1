<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Beer Page</title>
	</head>
	<body>
	
	
	
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select b.bar, sum(t.quantity) as units_sold from bills b left join transactions t on b.bill_id=t.bill_id where t.item=\'"+entity+"\' group by b.bar order by units_sold desc	limit 5;";
			ResultSet result = stmt.executeQuery(str);
		%>
		
		<% out.println("Top 5 bars where "+entity+" is sold:") ;%>
			
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>Bar</td>
			<td>Units Sold</td>
			
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("bar") %></td>
					<td><%= result.getString("units_sold") %></td>
					
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
		<br>
		
		<% 
	StringBuilder myData=new StringBuilder();
	String strData ="";
    String chartTitle="";
    String legend="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list = new ArrayList();
   		Map<String,Integer> map = null;
   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		
   		String graphType = request.getParameter("command");   
   		//Make a query   		
   	   	String	query = "select b.drinker, sum(t.quantity) as Units_Consumed from bills b left join transactions t on b.bill_id=t.bill_id where t.item=\'"+graphType+"\' group by b.drinker order by Units_Consumed desc limit 5;";
   		

   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   	   		map.put(result.getString("drinker"),result.getInt("Units_Consumed")); 		
   			list.add(map);
   	    } 
   	    result.close();
   	    
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<String,Integer> hashmap : list){
        		Iterator it = hashmap.entrySet().iterator();
            	while (it.hasNext()) { 
           		Map.Entry pair = (Map.Entry)it.next();
           		String key = pair.getKey().toString().replaceAll("'", "");
           		myData.append("['"+ key +"',"+ pair.getValue() +"],");
           	}
        }
        strData = myData.substring(0, myData.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected
          chartTitle = "Top 5 drinkers that consume "+graphType;
          legend = "Units Consumed";
       
	}catch(SQLException e){
    		out.println(e);
    }
%>

<div><script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data = [<%=strData%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title = '<%=chartTitle%>'; 
			var legend = '<%=legend%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat = [];
			data.forEach(function(item) {
			  cat.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart = Highcharts.chart('graphContainer', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend,
			        data: data
			    }]
			});
			});
		
		</script>
	</head>
	

	<div id="graphContainer" style="width: 500px; height: 400px; margin: 0 auto"></div>
	</div>
	
	<br>
	<br>
	<br>
	
	<% 
	StringBuilder myData2=new StringBuilder();
	String strData2 ="";
    String chartTitle2="";
    String legend2="";
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list2 = new ArrayList();
   		Map<String,Integer> map2 = null;
   		//Get the database connection
   		ApplicationDB db = new ApplicationDB();	
   		Connection con = db.getConnection();		

   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		
   		String graphType2 = request.getParameter("command");   
   		//Make a query   		
   	   	String	query2 = "select monthname(b.date) as month, sum(t.quantity) as units_sold from bills b left join transactions t on b.bill_id=t.bill_id where t.item=\'"+graphType2+"\' group by month order by month(b.date) asc;";
   		

   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query2);
   		//Process the result
   		while (result.next()) { 
   			map2=new HashMap<String,Integer>();
   	   		map2.put(result.getString("month"),result.getInt("units_sold")); 		
   			list2.add(map2);
   	    } 
   	    result.close();
   	    
   	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
        for(Map<String,Integer> hashmap : list2){
        		Iterator it = hashmap.entrySet().iterator();
            	while (it.hasNext()) { 
           		Map.Entry pair = (Map.Entry)it.next();
           		String key = pair.getKey().toString().replaceAll("'", "");
           		myData2.append("['"+ key +"',"+ pair.getValue() +"],");
           	}
        }
        strData2 = myData2.substring(0, myData2.length()-1); //remove the last comma
        
        //Create the chart title according to what the user selected
          chartTitle2 = "Time distribution of sales for "+graphType2;
          legend2 = "Sales";
       
	}catch(SQLException e){
    		out.println(e);
    }
%>

<div><script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data2 = [<%=strData2%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title2 = '<%=chartTitle2%>'; 
			var legend2 = '<%=legend2%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat2 = [];
			data2.forEach(function(item) {
			  cat2.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart2 = Highcharts.chart('graphContainer2', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title2
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat2
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend2,
			        data: data2
			    }]
			});
			});
		
		</script>
	</head>
	
	</div>

	<div id="graphContainer2" style="width: 500px; height: 400px; margin: 0 auto"></div>

	</body>
</html>