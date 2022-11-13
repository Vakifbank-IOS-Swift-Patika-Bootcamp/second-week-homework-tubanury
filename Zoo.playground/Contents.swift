import Foundation

protocol zoo {
    var dailyWaterLimit: Int { get set }
    var budget: Int { get set }
    var animals: [animal] { get }
    var zooKeepers: [zooKeeper] {get}
        
    func increaseWaterLimit(amount: Int)
    func increaseBudget(amount: Int)
    func spendForSth(amount: Int)
    func addZooKeeper(keeper: zooKeeper)
    func addAnimal(animal: animal)
    func paySalaries()
    
}


class wildZoo {
    
    var dailyWaterLimit: Int
    var remainingWaterLimit: Int
    var budget: Int
    var animals: [animal]?
    var zooKeepers: [zooKeeper]?
        
    
    init(dailyWaterLimit: Int, budget: Int) {
        self.dailyWaterLimit = dailyWaterLimit
        self.budget = budget
        self.remainingWaterLimit = dailyWaterLimit
    }
    
    func increaseWaterLimit(amount: Int) {
        dailyWaterLimit += amount
        remainingWaterLimit += amount
    }
    func increaseBudget(amount: Int) {
        budget += amount
    }
    func spendForSth(amount: Int) {
        if budget - amount > 0 {
            budget -= amount
        }
        else {
            print ("Insufficient balance!")
        }
        
    }
    func paySalaries(){
        
        for keeper in zooKeepers! {
            budget -= keeper.salary
        }
    }
    
    func addZooKeeper(keeper: zooKeeper){
        zooKeepers?.append(keeper)
    }
        
    func addAnimal(animal: animal){
        if animal.dailyWaterConsume < remainingWaterLimit {
            animals?.append(animal)
            remainingWaterLimit -= animal.dailyWaterConsume
            self.zooKeepers?.randomElement()?.addAnimal(animal: animal)
        }
        else {
            print("Exceeded water limit. Try increasing water Limit first!")
        }
    }

}


class animal {
    var specie: String
    var dailyWaterConsume: Int
    var voice: String
    var keeper: zooKeeper?
    var zoo: wildZoo
    
    init (specie: String, dailyWaterConsume: Int, voice: String, zoo: wildZoo){
        self.specie = specie
        self.dailyWaterConsume = dailyWaterConsume
        self.voice = voice
        self.zoo = zoo
    }
    
    
}

class zooKeeper {
    var name: String
    var salary: Int {
        return 4000 + (animals?.count ?? 0) * 400
    }
    var animals: [animal]?
    
    init (name: String){
        self.name = name
    }
    
    func addAnimal(animal: animal) {
        self.animals?.append(animal)
        
    }
    
}

var firstZooKeeper = zooKeeper(name: "John")

var capeTownZoo = wildZoo(dailyWaterLimit: 10000, budget: 100_000_000)

capeTownZoo.addZooKeeper(keeper: firstZooKeeper)

var monkey = animal(specie: "Rhinopithecus roxellana", dailyWaterConsume: 100, voice: "monkey voice", zoo: capeTownZoo)

var dog = animal(specie: "Buldog", dailyWaterConsume: 50, voice: "Bark!", zoo: capeTownZoo)

capeTownZoo.addAnimal(animal: monkey)
capeTownZoo.addAnimal(animal: dog)







