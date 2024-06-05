package main

import "fmt"
import "sync"

type Philosopher struct {
	id int
	leftFork *sync.Mutex
	rightFork *sync.Mutex
	mealsEaten int
}

func (p *Philosopher) eat(noMeals int, noPhilosophers int, wg *sync.WaitGroup) {
	defer wg.Done()
	
	for p.mealsEaten < noMeals {
		fmt.Printf("Philosopher %d is trying to pick up left fork\n", p.id)
		if p.leftFork.TryLock() {
			fmt.Printf("Philosopher %d picked up left fork\n", p.id)
			fmt.Printf("Philosopher %d is trying to pick up right fork\n", p.id)
			if p.rightFork.TryLock() {
				fmt.Printf("Philosopher %d picked up right fork\n", p.id)
				p.mealsEaten++;
				fmt.Printf("Philosopher %d is eating meal %d\n", p.id, p.mealsEaten)

				fmt.Printf("Philosopher %d putting down right fork\n", p.id)
				p.rightFork.Unlock()
				fmt.Printf("Philosopher %d putting down left fork\n", p.id)
				p.leftFork.Unlock()
			} else {
				fmt.Printf("Philosopher %d putting down left fork\n", p.id)
				p.leftFork.Unlock()
			}
		}
	}
}

func main() {
	noPhilosophers := 5
	noMeals := 100

	forks := make([]*sync.Mutex, noPhilosophers)
	for i := 0; i < noPhilosophers; i++ {
		forks[i] = &sync.Mutex{}
	}

	philosophers := make([]*Philosopher, noPhilosophers)
	for i := 0; i < noPhilosophers; i++ {
		lf := i
		rf := (i + 1) % noPhilosophers
		philosophers[i] = &Philosopher{
			id: i,
			leftFork: forks[lf],
			rightFork: forks[rf],
			mealsEaten: 0,
		}
	}

	var wg sync.WaitGroup
	wg.Add(noPhilosophers)
	for _, p := range philosophers {
		go p.eat(noMeals, noPhilosophers, &wg)
	}
	wg.Wait()

}
