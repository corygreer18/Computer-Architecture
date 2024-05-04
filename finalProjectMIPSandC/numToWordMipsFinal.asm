.data
prompt:          .asciiz "Input: "
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

buffer: .space 5
inputSize: .word 6
.text


main:
li $v0, 4     #printf("Input: );
la $a0, prompt
syscall
	
li $v0, 8
la $a0, buffer
lw $a1, inputSize
syscall


jal strLength

move $a0, $v0 



	la $t0, buffer
	lb $t1, 0($t0) #Set $t1 to the first index of buf
if:
	#li  $t0, 0
	sge   $t2,$t1,48      #Set $t2 to 1 if '0' <= input  
	#li $t0,9
	sle  $t0, $t1, 57      #Set $t0 to 1 if input <= '57'
	and $t2, $t0, $t2      #Checks if '0' <= input <= '57'
	beq $t2, 1, numToWord
	
li $v0, 10
syscall
	
numToWord:
jal numberName #Finds length of input

li $v0, 10
syscall

strLength:
addi $sp, $sp, -12 #Storing variables in stack pointer
sb $t0, 8($sp)
sb $t1, 4($sp)
sb $t2, 0($sp)

la $t0, buffer  #Loads input in $t0
lb $t2, newLine #Loads '\n' in $t2

loop:
    lb   $t1, 0($t0)  #Loads current index of input into $t1
    beq  $t1, $zero, end  #Checks if $t1 is = NULL
    beq  $t1, $t2, end  #Checks if $t1 is '\n'

    addi $t0, $t0, 1  #Add 1 to length
    j loop

end:
la $t1, buffer
sub $v0, $t0, $t1  #Retuns size in $v0

addi $sp, $sp, 12
lb $t0, 8($sp)
lb $t1, 4($sp)
lb $t2, 0($sp)

jr $ra

numberName:
la $s1, single_digits_place
la $s2, second_digits_place
la $s3, multiples_ten
la $s4, large
la $t0, buffer  #Loads input in $t0
la $t1, ($a0)   #Loads input size in $t1

beq $t1, $zero, noNum   #If current size = 0
beq $t1, 1, oneNum      #If current size  = 1
beq $t1, 2, twoPlusNum  #If current size = 2, 3 or 4
beq $t1, 3, twoPlusNum  
beq $t1, 4, twoPlusNum

jr $ra

noNum:
li $v0, 4
la $a0, nothingEntered  #Print that nothing was entered
syscall

li $v0, 10
syscall

oneNum:
lb $t2, 0($t0)    #Load the current index of input into $t2
andi $t2,$t2,0x0F  #Turns ascii interger into real interger value
sll $t2, $t2, 2    #Multiplies current index integer by 4
li $v0, 4
add $t2, $s1, $t2  #Set $t2 to the correct index of the singe_digits place array
lw $t5, 0($t2)
la $a0,($t5)
syscall  #Prints fromn single digits placr array

li $v0, 10
syscall

twoPlusNum:
lb $t9, newLine
largerLoop:
    beqz $t1, exit  #if size = 0, exit
    lb   $t8, 0($t0)  #Loads current index of input into $t8
    andi $t8, $t8, 0X0F  #Turns $t8 into interger value
    beq  $t8, $zero, exit  #If current index is NULL, exit
    beq  $t8, $t9, exit #If current index is  '\n', exit
    bge $t1, 3, loopPlus3  #If current size is greater than 3, jump to loopPlus3
    beq $t8, 1, tensPrint  #If current index = 1 go to tensPrint
    
    seq $t5, $t8, 2  
    addi $t0, $t0, 1
    lb $t8, 0($t0)
    andi $t8, $t8, 0X0F
    seq $t6, $t8, 0
    and $t5, $t5, $t6
    beq $t5, 1, twentyPrint  # The above lines check if (num == '2' && (num + 1) == '0') and then if true jump to twentyPrint
    
    j twentyPlusPrint #Jump to twentyPlusPriint

loopPlus3:
andi $t8, $t8, 0X0F
bnez, $t8 loopPlus3Print
return:
addi $t1, $t1, -1 #Reduce size by 1
j largerLoop

loopPlus3Print:
sll $t8, $t8, 2
add $t8, $s1, $t8
lw $t5, 0($t8)
li $v0, 4
la $a0,($t5)
syscall       #The above lines multiply $t8 by 4 to access correct index of single digits array

addi $t8, $t1, -3
mul $t8, $t8, 4
add $t8, $s4, $t8
lw $t5, 0($t8)
la $a0,($t5)
syscall  #The above lines multiply $t8 by 4 to access correct index of large array

addi $t0, $t0, 1 #Increase index by 1

j return

li $v0, 10
syscall

tensPrint:
andi $t8, $t8, 0X0F
move $t6, $t8
addi $t0, $t0, 1 #Set $t6 to current index of input
lb $t8, 0($t0)
andi $t8, $t8, 0X0F #Sets $t8 to next index of input
add $t8, $t6, $t8  #Set $t8 to $t6 plus $t8

sll $t8, $t8, 2 #Multiply $t8 by 4
add $t8, $s2, $t8 #Set $t8 to the correct index of second_digits_place array
lw $t5, 0($t8)
li $v0, 4
la $a0,($t5)
syscall  #Print from second_digits_place array

li $v0, 10
syscall  #Exit program

twentyPrint:
li $v0, 4
la $a0, twenty
syscall  #Print the number 20
addi $t1, $t1, -1  #Decrease size by 1
j largerLoop

twentyPlusPrint:
    addi $t0, $t0, -1
    lb $t8, 0($t0)
    andi $t8, $t8, 0X0F
    bnez $t8, printing  #if current index is not 0 jump to printing
    
    notPrinting:
    li $v0, 4
    la $a0, empty
    syscall
    j done
    
    printing:
    sll $t8, $t8, 2
    add $t8, $s3, $t8
    lw $t5, 0($t8)
    li $v0, 4
    la $a0,($t5)
    syscall  #Print current index of multiples 10
    addi $t1, $t1, -1
    
    done:
    addi $t0, $t0, 1 #Increase index by 1
    lb $t8, 0($t0)
    andi $t8, $t8, 0x0F
    bnez $t8, singlePrint #If current index is not 0, jump to single print
    addi $t1, $t1, -1
    j largerLoop
    
    singlePrint:
    sll $t8, $t8, 2
    add $t8, $s1, $t8
    lw $t5, 0($t8)  #Multiply interger value of current index by 4
    
    li $v0, 4
    la $a0,($t5) 
    syscall  #Print current index of single_digits_place array
    addi $t1, $t1, -1 #Decrease size 
    j largerLoop
    
exit:
li $v0, 10
syscall



