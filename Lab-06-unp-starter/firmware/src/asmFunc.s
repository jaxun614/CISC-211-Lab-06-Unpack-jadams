/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Jackson Adams"  
 
.align    /* ensure following vars are allocated on word-aligned addresses */

/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global a_value,b_value
.type a_value,%gnu_unique_object
.type b_value,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
a_value:          .word     0  
b_value:           .word     0  

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    /* r0 contains the given 32b value */
    
    /* r1 will be the register that holds the 'a' value */
    mov r1, r0 /* move the value in r0 into r1, the upper bits will be 1-to-1 */
    asrs r1, r1, #16 /* shift and sign extend the upper 16 bits to the right 16 bits and set the flags */
    ldr r3, =a_value /* write the mem address of a_value to r3 */
    str r1, [r3] /* write the value in r1 to the mem address of a_value */
    
    /* r2 will be the register that holds the 'b' value */    
    mov r2, r0 /* move the value in r0 into r2, the lower bits will be 1-to-1 */
    lsl r2, r2, #16 /* use a logical shift to the left to clear the upper bits while perserving the lower bits */
    asrs r2, r2, #16 /* shift and sign extend the upper 16 bits to the right 16 bits and set the flags */
    ldr r3, =b_value /* write the mem address of b_value to r3 */
    str r2, [r3] /* write the value in r2 to the mem address of b_value */
    
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */
    

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




