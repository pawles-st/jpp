use std::sync::{Mutex, Arc};
use std::env;
use std::error::Error;
use std::thread;

struct Table {
    forks: Vec<Mutex<()>>,
}

struct Philosopher {
    id: usize,
    left_fork: usize,
    right_fork: usize,
    meals_eaten: usize,
    max_meals: usize,
}

impl Philosopher {
    fn new(id: usize, left_fork: usize, right_fork: usize, max_meals: usize) -> Self {
        Self {
            id: id,
            left_fork: left_fork,
            right_fork: right_fork,
            meals_eaten: 0,
            max_meals: max_meals
        }
    }

    fn eat(&mut self, table: &Table) {
        while self.meals_eaten < self.max_meals {
            match table.forks[self.left_fork].try_lock() {
                Ok(left_fork) => {
                    match table.forks[self.right_fork].try_lock() {
                        Ok(right_fork) => {
                            self.meals_eaten += 1;
                            println!("philisopher {} is eating meal nr {}", self.id, self.meals_eaten);
                            drop(right_fork);
                            drop(left_fork);
                        },
                        Err(_) => {
                            drop(left_fork)
                        },
                    }
                },
                Err(_) => {},
            }
        }
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        println!("invalid arguments");
        std::process::exit(1);
    }

    let no_philosophers: usize = args[1].parse()?;
    let max_meals: usize = args[2].parse()?;

    let forks: Vec<_> = (0..no_philosophers).map(|_| Mutex::new(())).collect();
    let table = Arc::new(Table{forks});
    let philosophers: Vec<_> = (0..no_philosophers).map(|i| {
        Philosopher::new(i, i, (i + 1) % no_philosophers, max_meals)
    }).collect();

    let handles: Vec<_> = philosophers.into_iter().map(|mut philosopher| {
        let table = table.clone();
        thread::spawn(move || philosopher.eat(&table))
    }).collect();

    for handle in handles {
        handle.join().unwrap();
    }

    Ok(())
}
