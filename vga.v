module vga3 (
	input clk, //the clock
	input reset, // reset signal
	input [2:0] R,G,B, //colors
	output [11:0] xPOS, //horizontal position
	output [11:0] yPOS, //vertical position
	output Display_active, // flag for active display
	output reg [3:0] OR,OG,OB, // colors shown on display
	output Hsync, //  horizontal synchronization
	output Vsync, // vertical synchronization
	output Hsync_neg, //negative horizontal synchronization
	output Vsync_neg //negative vertical synchronization
	);
//reg [11:0] count;		
//reg [7:0] R,G,B;
//reg  [7:0] OR,OG,OB;
//wire [11:0] xPOS, yPOS;
wire x_active, y_active;
assign Display_active = (x_active && y_active) ? 1 : 0 ;
assign Hsync_neg= ~Hsync;
assign Vsync_neg= ~Vsync;
reg i;
wire newline;
always @ (*)
//for (i=xPOS; i=i+1; i<801)
if(xPOS>0 && yPOS>0 )
begin
OR=R;
OB=B;
OG=G;
end
else begin
OR=4'bz;
OG=4'bz;
OR=4'bz;
end

/*
wire border = (xPOS[9:3]==0) || (xPOS[9:3]==79) || (yPOS[9:3]==0) || (yPOS[9:3]==59);
wire RI=border;
wire GI=border;
wire BI=border;
reg vga_R, vga_B, vga_G;
always @(posedge clk)
begin
  vga_R <= RI & Display_active;
  vga_G <= GI & Display_active;
  vga_B <= BI & Display_active;
end

//drawing the paddle
reg [8:0] PaddlePosition;
reg [2:0] quadAr, quadBr;
reg [1:0] quadA, quadB;
always @(posedge clk) quadAr <= {quadAr[1:0], quadA};
always @(posedge clk) quadBr <= {quadBr[1:0], quadB};

always @(posedge clk)
if(quadAr[2] ^ quadAr[1] ^ quadBr[2] ^ quadBr[1])
begin
  if(quadAr[2] ^ quadBr[1])
  begin
    if(~&PaddlePosition)        // make sure the value doesn't overflow
      PaddlePosition <= PaddlePosition + 1;
  end 
  else
  begin
    if(|PaddlePosition)        // make sure the value doesn't underflow
      PaddlePosition <= PaddlePosition - 1;
  end
end
*/
/*

wire border = (xPOS[9:3]==0) || (xPOS[9:3]==79) || (yPOS[8:3]==0) || (yPOS[8:3]==59);
wire paddle = (xPOS>=PaddlePosition+8) && (xPOS<=PaddlePosition+120) && (yPOS[9:4]==27);

wire RI = border | (xPOS[3] ^ yPOS[3]) | paddle;
wire GI = border | paddle;
wire BI = border | paddle;


reg [9:0] ballX;
reg [8:0] ballY;
reg ball_inX, ball_inY;

always @(posedge clk)
if(ball_inX==0) ball_inX <= (xPOS==ballX) & ball_inY; else ball_inX <= !(xPOS==ballX+16);

always @(posedge clk)
if(ball_inY==0) ball_inY <= (yPOS==ballY); else ball_inY <= !(yPOS==ballY+16);

wire ball = ball_inX & ball_inY;
*/
wire newline2;
//mode M (.modee(mode), .ck(clk), .reset(reset),.ck_frecv(w));
counter  #(56,800,120,64) C1(.ck(clk),.reset(reset),.position(xPOS),.newline(newline),.syncron(Hsync),.active(x_active)); 
counter  #(37,600,6,23) C2(.ck(newline),.reset(reset),.position(yPOS), .newline(newline2), .syncron(Vsync),.active(y_active));
endmodule


