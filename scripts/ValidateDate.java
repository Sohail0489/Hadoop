package org.sears.validatedate;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;

public class ValidateDate extends EvalFunc<String> {

	public String exec(Tuple input) throws IOException, NullPointerException {
		
		String impaladate = "1400-01-01 00:00:00";
		String str = (String)input.get(0); 
				SimpleDateFormat dateformat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");

try{
				
			if (str == "" || input.size() == 0 || str==null) {
				return null;
				}
			
			else {
	        
			
				Date date1 = dateformat.parse(str);
				Date date2 = dateformat.parse(impaladate);
				
				if (date1.compareTo(date2) < 0) {
					return impaladate;
				} else {
					return str;

			
			} 
			
			}
		
 } catch (ParseException e)
{
	return null;
}
			
		
	}
}
