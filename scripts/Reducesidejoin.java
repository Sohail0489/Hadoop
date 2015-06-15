package org.sears.analytics;
import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
 
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

public class Reduceside_Join {
	
	public static class Map extends Mapper<LongWritable, Text, Text, Text> {
		public void map(LongWritable key, Text values, Context context)	throws IOException, InterruptedException {
	
		String line = values.toString();
		    String newline[] = line.split(",");
			
		context.write(new Text(newline[0]), new Text(newline[1]));	
	}
		}
	public static class Reducer1 extends Reducer<Text, Text, Text, Text> {	  
		//public Reducer1(){}
		@Override
	 public void reduce(Text key, Iterable<Text> values, Context context)
	            throws IOException, InterruptedException {
		 ArrayList <String> T1 = new ArrayList<String>() ;
		 for (Text val : values) {
	   String line= val.toString();
	   String []fields=line.split("\\|");
	   String []tag=fields[0].split("\u0001");
			   if(tag[1].equals("0"))
			   {
				   T1.add(fields[1]);
			   }
			   else
			   {
				   for(String list:T1)
					   context.write(key, new Text(list+fields[1])); 
			  
			   }
		 }
	 }
	 }
	
	public static void main(String []args) throws Exception
	{
	
	Configuration conf = new Configuration();
	String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
	if (otherArgs.length != 2) {
		System.err.println("Usage: transpose <in> <out1>");
		System.exit(2);
	}
	Job job = new Job(conf,"Reduceside_Join");
	job.setJarByClass(Reduceside_Join.class);
	job.setMapperClass(Map.class);
	job.setReducerClass(Reducer1.class);
	//job.setNumReduceTasks(0);
	job.setMapOutputKeyClass(Text.class);
	job.setMapOutputValueClass(Text.class);

	FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
	FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
	System.exit(job.waitForCompletion(true) ? 0 : 1);

	}


}

