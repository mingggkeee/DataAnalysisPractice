import random

class Lotto:
    
    def __init__(self):
        pass

    def input_game_count(self):
        cnt = input("Input Game Count : ")
        return int(cnt)

    def select_basic_numbers(self):

        numbers = []
        while True:
            no = random.randint(1,45)  # 난수 추출

            if no in numbers: # 새로 뽑은 숫자가 이미 뽑힌 숫자와 중복되는 경우
                continue

            numbers.append(no)

            if len(numbers) == 6: # 6개의 숫자가 뽑힌 경우
                break
        return numbers

    def check_average(self, numbers):
        total = 0
        for n in numbers:
            total += n

        avg = total / 6
        
        return (avg >=20 and avg <=26)

    def show_numbers(self, numbers):
        print("SELECTED NUMBERS : ", end='')
        for n in numbers:
            print("[%2d]" % n, end = ' ')
        print()

    def select_winning_numbers(self):
        while True: #무한 반복
        # numbers.clear() 기존에 뽑힌 숫자 제거
            numbers = self.select_basic_numbers()

            if self.check_average(numbers): # 조건에 부합하는 평균값이라면 반복문 종료하고 값을 반환
                return numbers

    def start_game(self):
        cnt = self.input_game_count()

        numbers_list = []

        for _ in range(cnt):

            numbers = self.select_winning_numbers()
    
            numbers.sort()
            self.show_numbers(numbers)

            numbers_list.append(numbers)

        # 추출된 번호를 파일로 저장
        with open('numbers.txt', 'wt') as f:
            for numbers in numbers_list:
                for n in numbers:
                    f.write("[{0}]".format(n))
                f.write("\n")

if __name__ == '__main__':
    lotto = Lotto()
    lotto.start_game()