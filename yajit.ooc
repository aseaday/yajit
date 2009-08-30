import BinarySeq
import x86-32.OpCodes


TestStruct :class {}

genCode: func <T> (funcPtr: Func, arg: T) -> Func {
	
    op := new BinarySeq(1024)
 	//t := new BinarySeq(10, [0x12 as UChar]) <- Amos
    op += OpCodes PUSH_EBP
	op += OpCodes MOV_EBP_ESP
    c := T 
    // TODO: Use switch instead
    if (c size == 1) 
        op += OpCodes PUSH_BYTE
    else if (c size == 2) 
        op += OpCodes PUSH_WORD
    else if (c size == 4) 
        op += OpCodes PUSH_DWORD
    op += arg as UChar
    op += OpCodes MOV_EBX_ADDRESS
	op += funcPtr as Pointer
	op += OpCodes CALL_EBX
	op += OpCodes LEAVE
	op += OpCodes RET

	printf("Code = ")
	op print()
	return op data as Func

}



    
test: func {
	"-- Yay =) This is the test function --" println()
}

test2: func (a: Int){
    printf("%d\n", a)
}

main: func {
    
    a :TestStruct
    a = new()
    printf("%x\n", a as Pointer)
    "Generating code.." println()
    code :Func
    code = genCode(test2, a as Pointer) 
	"Calling code.." println()
    code()
	"Finished!" println()	
}
