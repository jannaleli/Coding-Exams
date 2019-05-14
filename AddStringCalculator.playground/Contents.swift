import UIKit

enum AddStringError: Error {
    case Negatives
    case None
}




func addString(str: String) throws -> Int {
    
    //to get the delimiter if it exists
    
    var delimiter = String(str.prefix(2))
    
    var answer = 0
    
    var arrayed: [String] = []
    
    switch delimiter {
        
    case "//":
        
        var delims = str.dropFirst(2).components(separatedBy: CharacterSet.newlines)
        
        let delimiterSet = CharacterSet(charactersIn: delims[0])
        
        delims.removeFirst()
        
        arrayed = delims.joined().components(separatedBy: delimiterSet)

        break
        
    default:
        
        
        
        var delimiterSet = CharacterSet(charactersIn: ",")
        
        arrayed = str.components(separatedBy: .whitespacesAndNewlines).joined().components(separatedBy: delimiterSet)
        
        
        break

    }

        var finalIntArray =  arrayed.filter{ $0 != "" }.map { Int($0)! }


    
        var negativeArray =  finalIntArray.filter { $0 < 0}


        if negativeArray.count != 0 {

            throw AddStringError.Negatives

        }
    
        answer = finalIntArray.reduce(0) { $0 + ($1 > 1000 ? 0 : $1) }

        return answer

}


do {
    var str = "4\n,,,,5,4"

    var answer = try addString(str: str) //13

    str = "4,5,4"

    answer = try addString(str: str) //13




    str = "4,5,4,1010"

    answer = try addString(str: str) //13


    str = "//$%\n4%%5$$$4$1010"

    answer = try addString(str: str) //13

    str = "//$%\n4%%5$$$4%%%1010"

    answer = try addString(str: str) //13


    str =   "//***\n1***2***3"

    answer = try addString(str: str) //6
    
     str =   "//$,@,*\n1$2@3*3"
    
     answer = try addString(str: str) //11
    
    str =   "//$\n1$2$-1003"
    
    answer = try addString(str: str) //Negative Number
    


} catch  {
    
    print("Negative Number has been thrown!")
    
}
