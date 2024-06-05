with Ada.Text_IO; use Ada.Text_IO;

package body Philosophers is

	procedure DiningPhilosophers(NoPhilosophers: Positive; NoMeals: Positive) is

		protected type Fork is
			procedure TryPick(PhilosopherID: Positive; Success: out Boolean);
			procedure Put(PhilosopherID: Positive);
			function IsTaken return Boolean;
			private
			Owner : Natural := 0;
		end Fork;

		protected body Fork is
			procedure TryPick(PhilosopherID: Positive; Success: out Boolean) is
			begin
				if Owner /= 0 then
					Success := False;
				else
					Success := True;
					Owner := PhilosopherID;
				end if;
			end TryPick;

			procedure Put(PhilosopherID: Positive) is
			begin
				if Owner = PhilosopherID then
					Owner := 0;
				end if;
			end Put;

			function IsTaken return Boolean is
			begin
				return Owner /= 0;
			end IsTaken;
		end Fork;
		   
		Forks : array (Positive range 1 .. NoPhilosophers) of Fork;

		task type Philosopher is
			entry Setup(PhilosopherID: Positive; PhilosopherMaxMeals: Positive);
		end Philosopher;

		task body Philosopher is
			ID: Positive;
			NextID: Positive;
			MaxMeals: Positive;
			MealsEaten: Natural := 0;
			Success: Boolean;
		begin
			accept Setup(PhilosopherID: Positive; PhilosopherMaxMeals: Positive) do
				ID := PhilosopherID;
				NextID := ID mod NoPhilosophers + 1;
				MaxMeals := PhilosopherMaxMeals;
			end Setup;

			while MealsEaten < MaxMeals loop
				if not Forks(ID).IsTaken then
					Put_Line ("Philosopher" & Id'Img & " is trying to pick up left fork");
					Forks(ID).TryPick(ID, Success);

					if Success then
						Put_Line ("Philosopher" & Id'Img & " picked up left fork");

						if not Forks(NextID).IsTaken then
							Put_Line ("Philosopher" & Id'Img & " is trying to pick up right fork");
							Forks(NextID).TryPick(ID, Success);

							if Success then
								Put_Line ("Philosopher" & Id'Img & " picked up right fork");

								MealsEaten := MealsEaten + 1;
								Put_Line ("Philosopher" & Id'Img & " is eating meal nr" & MealsEaten'Img);

								Put_Line ("Philosopher" & Id'Img & " is putting down right fork");
								Forks(NextID).Put(ID);

								Put_Line ("Philosopher" & Id'Img & " is putting down left fork");
								Forks(ID).Put(ID);
							else
								Put_Line ("Philosopher" & Id'Img & " released left fork");
								Forks(ID).Put(ID);
							end if;
						else 
							Forks(ID).put(ID);
						end if;
					end if;
				end if;
			end loop;
		end Philosopher;
		
		Philosophers : array (Positive range 1 .. NoPhilosophers) of Philosopher;

	begin
	   for I in 1..NoPhilosophers loop
		Philosophers(I).Setup(I, NoMeals);
	   end loop;	
	end DiningPhilosophers;

end Philosophers;
