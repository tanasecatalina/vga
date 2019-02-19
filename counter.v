module counter #(parameter front=56, visible_area=800, sync=120, back=64)
					 (input ck,reset,
					  output reg [11:0] position,
					  output reg newline, syncron, active
					  );
					  
reg [11:0] count=0;
always @(posedge ck)
	if(reset==0) begin
		count <=0;
		syncron <=1;
		active <=1;
		position<=0;
	end	
		
	else if(count<visible_area) begin
			count<=count+1;
			position <=count;
			active <=1;
			syncron <=1;
			newline<=0;
	end
	else if(count>=visible_area && count <visible_area+front) begin
			count<=count+1;
			active <= 0;
			syncron <=1;
			position <=0;
			newline<=0;
	end
	else if(count>=visible_area+front && count <visible_area+front+sync) begin
			count<=count+1;
			syncron <=1;
			active <=0;
			position <=0;
			newline<=0;
	end
		
		else if(count>=visible_area+front+sync && count<visible_area+front+sync+back) begin
			count<=count+1;
			syncron<=0;
			position<=0;
			active <=0;
			newline<=0;
		end
		else if (count==visible_area+front+sync+back) begin
			 count<=0;
			 syncron<=1;
			 position<=0;
			 active<=0;
			 newline<=1;
		end
		
		
endmodule
	





					
					
					