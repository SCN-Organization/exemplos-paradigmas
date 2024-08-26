#include <stdio.h>
#include <stdlib.h>

typedef struct stack {
   int capacity;
   int top;
   int* array;
} Stack;

Stack* createStack(int capacity) {
   Stack* stack = (Stack*)malloc(sizeof(Stack));
   stack->capacity = capacity;
   stack->top = -1;
   stack->array = (int*)malloc(stack->capacity * sizeof(int));
   return stack;
}

int isFull(Stack* stack) {
   return stack->top == stack->capacity - 1;
}

int isEmpty(Stack* stack) {
   return stack->top == -1;
}

void push(Stack* stack, int item) {
   if (isFull(stack))
      return;
   stack->array[++stack->top] = item;
}

int pop(Stack* stack) {
   if (isEmpty(stack))
      return -1;
   return stack->array[stack->top--];
}

int peek(Stack* stack) {
   if (isEmpty(stack))
      return -1;
   return stack->array[stack->top];
}

int main() {
   Stack* stack = createStack(10);
   push(stack, 1);
   push(stack, 2);
   push(stack, 3);
   printf("%d\n", pop(stack));
   printf("%d\n", peek(stack));
   printf("%d\n", pop(stack));
   printf("%d\n", pop(stack));
   free(stack->array);
   free(stack);
   return 0;
}
