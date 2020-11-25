<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

		
		
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
   		
   		 
   		String entity1 = request.getParameter("com1");
		String entity2= request.getParameter("com2");
		String entity3= request.getParameter("com3");
		String entity4= request.getParameter("com4");
   		//Make a query   		
   	   	String	query3 = "select k.bartender, sum(k.quantity)as sold from (select b.date, b.bar, b.bartender, b.day, b.time,  t.item, t.quantity from bills b left join transactions t on b.bill_id=t.bill_id where t.type='beer' and b.time > '"+entity3+":00' and b.time < '"+entity4+":00' and b.day='"+entity1+"' and b.bar= '"+entity2+"' order by b.date, b.bar, b.bartender, t.item) as k group by bartender order by sold desc;";
   		

   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query3);
   		//Process the result
   		while (result.next()) { 
   			map3=new HashMap<String,Integer>();
   	   		map3.put(result.getString("bartender"),result.getInt("sold")); 		
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
          chartTitle3 = "Top bartenders during "+entity3 +":00 to "+entity4+":00";
          legend3 = "Beers Sold";
       
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