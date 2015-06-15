/*
 *Sears Holding Corporation, 2015
Script       : Concat_uple.java
Purpose      : Concatinates the input by telda and removes duplicate

               Version Detail
Author     Version          Detail
smoham3       1.0           It takes duplicate or concatinated input, splits if concatinated to remove duplicate 
			    and returns concatinted output by '~' of all the distinct inputs
 *
 * */
package org.sears.concat;
import org.apache.pig.EvalFunc;
import org.apache.pig.data.DataBag;
import org.apache.pig.data.Tuple;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;


public class Concat_Tuple extends EvalFunc<String> {
		
public String exec(Tuple input) throws IOException, NullPointerException {
  DataBag values = (DataBag)input.get(0);
  String output="";
  Set<String> temp = new HashSet<String>();
  for (Iterator<Tuple> it = values.iterator(); it.hasNext();) 
  		{
		Tuple t = it.next();
		String s=(String)t.get(0);
		
		if(s!=null)	
		{
			if(s.contains("~"))
			{
				String [] output_split= s.split("~");
				temp.addAll(Arrays.asList(output_split));
			}
			else
			temp.add(s);
		}
  		}		
				Iterator<String> iter = temp.iterator();
				while (iter.hasNext()) {
				    output+="~"+iter.next();
				}
				if(output.length()>0)
				return output=output.substring(1);		
				else
					return output;
	}
		
}

