//
//  main.swift
//  MyCreditManager
//
//  Created by Sean Kim on 2022/11/20.
//

// 구현 내용 안내
/*
 1. 프로그램 동작 조건
 1> 종료 메뉴 선택 전까지 계속 입력을 받는다.
 2> 메뉴 선택을 포함한 모든 입력은 숫자 혹은 영문이다.
 2. 프로그램 메뉴 종류
 1> 학생 추가
 2> 학생 삭제
 3> 성적 추가 및 변경
 4> 성적 삭제
 5> 평점 보기
 X> 종료
 */

// 계산법 안내
/*
 3. 성적별 점수
 A+ > A > B+ > B > C+ > C > D+ > D > F
 4.5 > 4 > 3.5 > 3 > 2.5 > 2 > 1.5 > 1 > 0
 4. 평점 게산
 1> 각 과목의 점수 총 합 / 과목 수
 2> 최대 소수점 2번째 자리까지 출력
 */

// 입력 처리 안내
/*
 5. 입력 처리
 1> 메뉴
 - 원하는 기능을 입력해주세요.
 1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
 2> 학생 추가
 - 추가할 학생의 이름을 입력해주세요.
 - 000 학생을 추가했습니다.
 - 000 는 이미 존재하는 학생입니다. 추가하지 않습니다.
 3> 학생 삭제
 - 삭제할 학생의 이름을 입력해주세요.
 - 000 학생을 삭제하였습니다.
 - 000 학생을 찾지 못했습니다.
 4> 성적 추가
 - 성적을 추가할 학생의 이름, 과목 이름, 성정(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
 입력예) Mickey Swift A+
 만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
 - 000 학생의 000 과목이 00로 추가(변경)되었습니다.
 5> 성적 삭제
 - 성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
 입력예) Mickey Swift
 - 000 학생의 000 과목의 성적이 삭제되었습니다.
 - 000 학생을 찾지 못했습니다.
 6> 평점 보기
 - 해당 학생의 과목과 성적을 모두 출력한 후 마지막 줄에 평점을 출력
 - 평점을 알고싶은 학생의 이름을 입력해주세요.
 - 000 학생을 찾지 못했습니다.
 - (과목1): (성적1)
 (과목2): (성적2)
 평점 : (평점)
 7> 종료
 - 프로그램을 종료합니다...
 */

// 오류 처리 안내
/*
 6. 오류 처리
 1> 메뉴 입력 오류
 "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요." 를 출력 후 재입력받음
 2> 학생 추가 입력 오류
 1) 메뉴 선택 후에도 잘못 입력하였으면 "입력이 잘못되었습니다. 다시 확인해주세요" 출력 후 재입력 받음
 2) 이미 존재하는 학생은 다시 추가하지 않음
 3> 학생 삭제 입력 오류
 1) 메뉴 선택 후에도 잘못 입력하였으면 "입력이 잘못되었습니다. 다시 확인해주세요" 출력 후 재입력 받음
 2) 없는 학생은 삭제하지 않음
 4> 성적 추가 입력 오류
 1) 메뉴 선택 후에도 잘못 입력하였으면 "입력이 잘못되었습니다. 다시 확인해주세요" 출력 후 재입력 받음
 2) 없는 학생의 성적은 추가하지 않음
 5> 성적 삭제 입력 오류
 1) 메뉴 선택 후에도 잘못 입력하였으면 "입력이 잘못되었습니다. 다시 확인해주세요" 출력 후 재입력 받음
 2) 없는 학생의 성적은 삭제하지 않음
 6> 평점 보기 입력 오류
 1) 메뉴 선택 후에도 잘못 입력하였으면 "입력이 잘못되었습니다. 다시 확인해주세요" 출력 후 재입력 받음
 2) 없는 학생은 평점을 보여주지 않음
 */

import Foundation
Main.init()

struct Student {
    var name: String
    var score: [Score]?
}

struct Score {
    var subjectName: String
    var subjectScore: ScoreGrade
}

enum ScoreGrade {
    case ap
    case a
    case bp
    case b
    case cp
    case c
    case dp
    case d
    case f
    case error
}

final class Main {
    private var students = [Student]()
    
    init() {
        self.callMenu()
    }
    
    private func keyRead(inputString: String?) -> [String] {
        guard let inputString = inputString else { return ["ERROR"] }
        return inputString.components(separatedBy: " ")
    }
    
    private func callMenu() {
        while true{
            print("원하는 기능을 입력해주세요.")
            print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
            switch self.keyRead(inputString: readLine())[0] {
            case "1":
                self.addStudent()
            case "2":
                self.deleteStudent()
            case "3":
                self.addOrModifyScore()
            case "4":
                self.deleteScore()
            case "5":
                self.avarageScore()
            case "X":
                print("프로그램을 종료합니다...")
                return
            default:
                print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            }
        }
    }
    
    private func addStudent() {
        print("추가할 학생의 이름을 입력해주세요.")
        let name = self.keyRead(inputString: readLine())[0]
        if students.count > 0 {
            if students.map({ $0.name == name }).contains(true) {
                print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                return
            }
        }
        self.students.append(Student(name: name))
        print("\(name) 학생을 추가했습니다.")
    }
    
    private func deleteStudent() {
        print("삭제할 학생의 이름을 입력해주세요.")
        let name = self.keyRead(inputString: readLine())[0]
        if students.count > 0 {
            if students.map({ $0.name == name }).contains(true) {
                students.remove(at: students.firstIndex(where: {$0.name == name})!)
                print("\(name) 학생을 삭제하였습니다..")
                return
            }
        }
        print("\(name) 학생을 찾지 못했습니다.")
    }
    
    private func addOrModifyScore() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성정(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let student = self.keyRead(inputString: readLine())
        if student.count != 3 {
            return
        }
        let name = student[0]
        let score = Score(subjectName: student[1],
                          subjectScore: {
            switch student[2]{
            case "A+":
                return ScoreGrade.ap
            case "A":
                return ScoreGrade.a
            case "B+":
                return ScoreGrade.bp
            case "B":
                return ScoreGrade.b
            case "C+":
                return ScoreGrade.cp
            case "C":
                return ScoreGrade.c
            case "D+":
                return ScoreGrade.dp
            case "D":
                return ScoreGrade.d
            case "F":
                return ScoreGrade.f
            default:
                return ScoreGrade.error
            }
        }()
        )
        if score.subjectScore == ScoreGrade.error {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        if self.students.map{$0.name == name}.contains(true){
            let index = self.students.firstIndex(where: {$0.name == name})!
            let scoreIndex = self.students[index].score?.firstIndex(where: {$0.subjectName == score.subjectName}) ?? 0
            
            if self.students[index].score?.map{$0.subjectName == score.subjectName}.contains(true) ?? false { // 중복되는 값이 있다는 소리 = 수정을 해야하는거지
                self.students[index].score![scoreIndex].subjectScore = score.subjectScore
                print("\(name) 학생의 \(score.subjectName) 과목이 \(score.subjectScore)로 추가(변경)되었습니다.")
                return // 변경 끝났으니 아웃
            }
            
            if self.students[index].score == nil { // 없었으니 추가해주는거지
                self.students[index].score = [score]
            } else {
                self.students[index].score?.append(score)
            }
            print("\(name) 학생의 \(score.subjectName) 과목이 \(score.subjectScore)로 추가(변경)되었습니다.")
            return
            
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
        }
    }
    
    private func deleteScore() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        let deleteData = self.keyRead(inputString: readLine())
        if deleteData.count == 2 {
            if self.students.map{$0.name == deleteData[0]}.contains(true) {
                let index = self.students.firstIndex(where: {$0.name == deleteData[0]})!
                if self.students[index].score?.map{$0.subjectName == deleteData[1]}.contains(true) ?? false{
                    self.students[index].score!.remove(at: self.students[index].score!.firstIndex(where: {$0.subjectName == deleteData[1]})!)
                    print("\(deleteData[0]) 학생의 \(deleteData[1]) 과목의 성적이 삭제되었습니다.")
                    return
                    
                } else {
                    print("\(deleteData[1]) 과목을 찾지 못했습니다.")
                }
            } else {
                print("\(deleteData[0]) 학생을 찾지 못했습니다.")
            }
        }
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        
        
    }
    
    private func avarageScore() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        let name = keyRead(inputString: readLine())[0]
        if self.students.map{$0.name == name}.contains(true) {
            let index = self.students.firstIndex(where: {$0.name == name})!
            let scoreArray = self.students[index].score?.map{
                let score = $0.subjectScore
                let subjectScore = {
                    switch score {
                    case .ap: return "A+"
                    case .a: return "A"
                    case .bp: return "B+"
                    case .b: return "B"
                    case .cp: return "C+"
                    case .c: return "C"
                    case .dp: return "D+"
                    case .d: return "D"
                    case .f: return "F"
                    default: return "Error"
                    }
                }
                print("\($0.subjectName) : \(subjectScore())")
                switch $0.subjectScore {
                case .ap: return 4.5
                case .a: return 4
                case .bp: return 3.5
                case .b: return 3
                case .cp: return 2.5
                case .c: return 2
                case .dp: return 1.5
                case .d: return 1
                default: return 0
                }
            }
            let reduce = scoreArray?.reduce(0.0, {$0+$1})
            let count = self.students[index].score?.count
            print("평점 : \(floor((reduce!/Double(count!)) * 100)/100)")
        }
    }
    
}


