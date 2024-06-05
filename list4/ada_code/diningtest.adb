with Ada.Text_IO; use ADA.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Philosophers; use Philosophers;

procedure DiningTest is
begin
	if Argument_Count = 2 then
		DiningPhilosophers(Positive'Value(Argument(1)), Positive'Value(Argument(2)));
	else
		Put_Line("Invalid arugments");
	end if;
end DiningTest;
