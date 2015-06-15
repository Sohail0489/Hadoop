package org.sears.concat;

import java.io.IOException;

import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;

	public class Concat extends EvalFunc<String> {
		
		public String exec(Tuple input) throws IOException, NullPointerException {
			
			String str1 = (String)input.get(0);
			
			String str2 = (String)input.get(1);
			
			if (str1 == null  && str2 == null)
			{
				return "";
			}
			
						
			else 
			{
				String output = str1+'-'+str2;
				
				return output;
		
			
			}
				
			
			
		}

	}
		
	
	
	
