import 'dart:async';

class PomodoroTimer {
  int workSeconds;   // 집중 시간 //정수 값
  int breakSeconds;  // 휴식 시간 //정수 값
  int cycles;        // 반복할 사이클 //정수 값
  int currentCycle = 1; // 현재 진행 중인 사이클 기본값 1 //정수 값
  bool isWorking = true; // 현재 작업 상태 (true: 집중 모드, false: 휴식 모드) //불리언

  Timer? timer; //nullable (값이 없을 수도 있음)
  int remainingTime = 0;

  PomodoroTimer({this.workSeconds = 5, this.breakSeconds = 3, this.cycles = 2});
  //생성자: workSeconds, breakSeconds, cycles 값을 상속 받아 초기화 시킵니다.
  // 타이머 시작(5초 집중 3초 휴식 2사이클)
  void start() {
    print("포모도로 타이머 시작! (총 $cycles 사이클)\n");

    remainingTime = workSeconds; //첫번째 사이클에서 집중시간 설정을 합니다.
    print("사이클 $currentCycle: 집중 시간 ${workSeconds}초 시작!");

    _startCountdown(); //카운트 다운 함수 실행
  }

  // 카운트다운 시작
  void _startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (remainingTime > 0) {
        print("$remainingTime초 남음...");
        remainingTime--;
      } else {
        timer?.cancel(); // 현재 타이머 종료
        print("완료!\n");
//1초마다 실행되는 타이머를 생성함. remainingTime을 1초씩 감소시키고 print 시킵니다.
        if (isWorking) {
          // 집중 시간이 끝나면 → 휴식 시작
          if (currentCycle <= cycles) {
            isWorking = false;
            remainingTime = breakSeconds;
            print("휴식 시간 ${breakSeconds}초 시작!");
            _startCountdown();
          }
        } else {
          // 집중 시간이 끝나면(isWorking이 false면) → 다음 사이클 시작
          currentCycle++;
          if (currentCycle <= cycles) {
            isWorking = true;// 휴식 시간이 끝나면(isWorking이 true면) → 다음 사이클 시작
            remainingTime = workSeconds;
            print("사이클 $currentCycle: 집중 시간 ${workSeconds}초 시작!");
            _startCountdown();
          } else {
            print("모든 포모도로 사이클이 완료되었습니다!");
          }
        }
      }
    }); //(자동 주석이 달릴 자리 입니다. 끄셨으면 안 달려요.)
  }
}

void main() {
  // (드디어 5초 집중, 3초 휴식, 총 2회 반복하는 테스트 실행)
  PomodoroTimer timer = PomodoroTimer(workSeconds: 5, breakSeconds: 3, cycles: 2);
  timer.start();
}


