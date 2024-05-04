.data
smallerPrompt: .asciiz "Please enter a number between 0-9999\n"
nothingEntered: .asciiz "No number entered\n"
newLine: .asciiz "\n"

zero: .asciiz "zero "
one: .asciiz "one "
two: .asciiz "two "
three: .asciiz "three "
four: .asciiz "four " 
five: .asciiz "five "
six: .asciiz "six "
seven: .asciiz "seven "
eight: .asciiz "eight "
nine: .asciiz "nine "


single_digits_place: .word zero, one, two, three, four, five, six, seven, eight, nine

empty: .asciiz ""
ten: .asciiz "ten "
eleven: .asciiz "eleven "
twelve: .asciiz "twelve "
thirteen: .asciiz "thirteen "
fourteen: .asciiz "fourteen "
fifteen: .asciiz "fifteen "
sixteen: .asciiz "sixteen "
seventeen: .asciiz "seventeen "
eighteen: .asciiz "eighteen "
nineteen: .asciiz "nineteen "

second_digits_place: .word, empty, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen 

empty2: .asciiz "empty "
twenty: .asciiz "twenty "
thirty: .asciiz "thirty "
fourty: .asciiz "fourty "
fifty: .asciiz "fifty "
sixty: .asciiz "sixty "
seventy: .asciiz "seventy "
eighty: .asciiz "eighty "
ninety: .asciiz "ninety "

multiples_ten: .word empty, empty2, twenty, thirty, fourty, fifty, sixty, seventy, eighty, ninety

hundred: .asciiz "hundred "
thousand: .asciiz "thousand "

large: .word hundred, thousand

single_digits: .word 0 1 2 3 4 5 6 7 8 9 
second_digits: .word 0 10 11 12 13 14 15 16 17 18 19 
tens: .word 20 30 40 50 60 70 80 90
largeNums: .word 100 1000

msg1: .asciiz "Please enter a string to conver to integer: "
msg2: .asciiz "Printing Single..."

buffer: .space 20
inputSize: .word 6

.text

main:
	
	#initialize arrays 
	#test word
	la $a0, msg1 
	li $v0, 4
	syscall
	
	li $v0, 8
	la $a0, buffer
	li $a1, 20
	syscall
	move $s4, $a0
	
	
	j wordConvert
	

wordConvert:
	li $s0, 0 #int x = 0
	li $s2, 0 #int a = 0
	
	addi $t0, $zero, 0
	
	while:
		beq $t0, 44, exit
		
		 
		# if(word == single_digits_place[i])
		la $t6, single_digits_place($t0)
		
		li $v0, 4
		move $a0, $t6
		syscall
		
		
		beq $s4, $t6, printSin
		
		#beq $s4, second_digits_place($t0), printSec
		
		#beq $s4, multiples_tens($t0), printTen
		
		addi $t0, $t0, 4
		
		j while
		
	printSin:
		la $a0, msg2
		li $v0, 4
		syscall
		
		lw $t6, single_digits($t0)
		
		li $v0, 1
		move $a0, $t6
		syscall
		
	
	exit:
		li $v0, 10  
	    	syscall
		
