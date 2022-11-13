import Foundation


enum title {
    case junior
    case mid
    case senior
    
    func salaryFactor() -> Int {
        switch self{
        case .junior:
            return 2
        case .mid:
            return 3
        case .senior:
            return 4
        }
    }
}

enum marialStatus {
    case single
    case married
    case widow
}

enum team {
    case ios
    case android
    case frontEnd
    case backEnd
}

protocol Company {
    var name: String { get set }
    var budget: Int { get set }
    var foundationYear: Int { get set }
    var employeeCount: Int {get}
        
    func paySalaries()
    func addEmployee(emp: Employee, toTeam: team)
    

}


class SoftwareCompany: Company{
    
    var name: String
    var budget: Int
    var foundationYear: Int
    var employeeCount: Int {
        return employees?.count ?? 0
    }
    var employees: [Employee]?

    func paySalaries() {
        employees?.forEach {
            budget -= $0.salary
        }
    }
    
    func addEmployee(emp: Employee, toTeam: team) {
        emp.company = self
        emp.team = toTeam
        employees?.append(emp)
    }
    
    init(name: String, budget: Int, foundationYear: Int, employeeCount: Int = 0) {
           self.name = name
           self.budget = budget
           self.foundationYear = foundationYear
    }
}

class Employee {
    var name: String
    var age: Int
    var marialStatus: marialStatus
    var title: title
    var company: Company?
    var team: team?
    
    var salary: Int {
        return  age*1000*title.salaryFactor()
    }
    
    
    init(name: String, age: Int, marialStatus: marialStatus, title: title) {
           self.name = name
           self.age = age
           self.marialStatus = marialStatus
           self.title = title
    }
    
    func promote(title: title){
        self.title = title
    }
    
    
}


var comp = SoftwareCompany(name: "Vakif Bank", budget: 100_000_000_000, foundationYear: 1954)

var emp =  Employee(name: "Tuba Sahin", age: 25, marialStatus: .married, title: .junior)

comp.addEmployee(emp: emp, toTeam: .ios)

emp.salary

emp.promote(title: .mid)

emp.salary
emp.team


