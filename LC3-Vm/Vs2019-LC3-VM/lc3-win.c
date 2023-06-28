#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <stdint.h>
#include <signal.h>
/* windows only */
#include <Windows.h>
#include <conio.h>  // _kbhit

// 寄存器
enum
{
	R_R0 = 0,
	R_R1,
	R_R2,
	R_R3,
	R_R4,
	R_R5,
	R_R6,
	R_R7,
	R_PC, /* program counter */
	R_COND,
	R_COUNT
};

// 条件标志
enum
{
	FL_POS = 1 << 0, /* P */
	FL_ZRO = 1 << 1, /* Z */
	FL_NEG = 1 << 2, /* N */
};

// 操作码
enum
{
	OP_BR = 0, /* branch */
	OP_ADD,    /* add  */ // 
	OP_LD,     /* load */
	OP_ST,     /* store */
	OP_JSR,    /* jump register */
	OP_AND,    /* bitwise and */ // 操作指令
	OP_LDR,    /* load register */
	OP_STR,    /* store register */
	OP_RTI,    /* unused */
	OP_NOT,    /* bitwise not */
	OP_LDI,    /* load indirect */
	OP_STI,    /* store indirect */
	OP_JMP,    /* jump */
	OP_RES,    /* reserved (unused) */
	OP_LEA,    /* load effective address */
	OP_TRAP    /* execute trap */
};

enum
{
	MR_KBSR = 0xFE00, /* keyboard status */
	MR_KBDR = 0xFE02  /* keyboard data */
};
enum
{
	TRAP_GETC = 0x20,  /* get character from keyboard, not echoed onto the terminal */
	TRAP_OUT = 0x21,   /* output a character */
	TRAP_PUTS = 0x22,  /* output a word string */
	TRAP_IN = 0x23,    /* get character from keyboard, echoed onto the terminal */
	TRAP_PUTSP = 0x24, /* output a byte string */
	TRAP_HALT = 0x25   /* halt the program */
};

#define MEMORY_MAX (1 << 16)
uint16_t memory[MEMORY_MAX];  /* 65536 locations */
uint16_t reg[R_COUNT];

HANDLE hStdin = INVALID_HANDLE_VALUE;
DWORD fdwMode, fdwOldMode;

void disable_input_buffering()
{
	hStdin = GetStdHandle(STD_INPUT_HANDLE);
	GetConsoleMode(hStdin, &fdwOldMode); /* save old mode */
	fdwMode = fdwOldMode
		^ ENABLE_ECHO_INPUT  /* no input echo */
		^ ENABLE_LINE_INPUT; /* return when one or
								more characters are available */
	SetConsoleMode(hStdin, fdwMode); /* set new mode */
	FlushConsoleInputBuffer(hStdin); /* clear buffer */
}

void restore_input_buffering()
{
	SetConsoleMode(hStdin, fdwOldMode);
}

uint16_t check_key()
{
	return WaitForSingleObject(hStdin, 1000) == WAIT_OBJECT_0 && _kbhit();
}
void handle_interrupt(int signal)
{
	restore_input_buffering();
	printf("\n");
	exit(-2);
}

uint16_t sign_extend(uint16_t x, int bit_count)
{
	if ((x >> (bit_count - 1)) & 1) {
		x |= (0xFFFF << bit_count);
	}
	return x;
}
uint16_t swap16(uint16_t x)
{
	return (x << 8) | (x >> 8);
}

/*更新条件寄存器值*/
void update_flags(uint16_t r)
{
	// n z p
	// 1 0 0 负数
	// 0 1 0 零
	// 0 0 1 正数
	if (reg[r] == 0)
	{
		reg[R_COND] = FL_ZRO; //10
	}
	else if (reg[r] >> 15) /* a 1 in the left-most bit indicates negative */
	{
		reg[R_COND] = FL_NEG;//100
	}
	else
	{
		reg[R_COND] = FL_POS; // 1
	}
}

/*读取img文件*/
void read_image_file(FILE* file)
{
	/* the origin tells us where in memory to place the image */
	uint16_t origin;
	fread(&origin, sizeof(origin), 1, file);
	origin = swap16(origin);

	/* we know the maximum file size so we only need one fread */
	uint16_t max_read = MEMORY_MAX - origin;
	uint16_t* p = memory + origin;
	size_t read = fread(p, sizeof(uint16_t), max_read, file);

	/* swap to little endian */
	while (read-- > 0)
	{
		*p = swap16(*p);
		++p;
	}
}
int read_image(const char* image_path)
{
	FILE* file = fopen(image_path, "rb");
	if (!file) { return 0; };
	read_image_file(file);
	fclose(file);
	return 1;
}

/* 地址写入：向地址给定地址:address中写入val */
void mem_write(uint16_t address, uint16_t val)
{
	memory[address] = val;
}

/* 地址读取： 给定地址address读取val */
uint16_t mem_read(uint16_t address)
{
	if (address == MR_KBSR)
	{
		if (check_key())
		{
			memory[MR_KBSR] = (1 << 15);
			memory[MR_KBDR] = getchar();
		}
		else
		{
			memory[MR_KBSR] = 0;
		}
	}
	return memory[address];
}


int main(int argc, const char* argv[])
{

	if (argc < 2)
	{
		/* show usage string */
		printf("lc3 [image-file1] ...\n");
		exit(2);
	}

	for (int j = 1; j < argc; ++j)
	{/*读取镜像信息*/
		if (!read_image(argv[j]))
		{
			printf("failed to load image: %s\n", argv[j]);
			exit(1);
		}
	}
	signal(SIGINT, handle_interrupt);
	disable_input_buffering();

	/* since exactly one condition flag should be set at any given time, set the Z flag */
	reg[R_COND] = FL_ZRO;

	/* set the PC to starting position */
	/* 0x3000 is the default */
	enum { PC_START = 0x3000 };
	reg[R_PC] = PC_START;	// 确定 PC 寄存器的地址

	int running = 1;
	while (running)
	{
		/* FETCH */
		uint16_t instr = mem_read(reg[R_PC]++); // 读取当前指令并将R_PC的内容+1，指向下一条命令执行位置
		uint16_t op = instr >> 12;// 右移动12位，确定命令的

		switch (op)
		{
		case OP_ADD:
		{
			/* destination register (DR) */
			uint16_t r0 = (instr >> 9) & 0x7; // 目标寄存器
			/* first operand (SR1) */
			uint16_t r1 = (instr >> 6) & 0x7; // 源寄存器

			/* whether we are in immediate mode */
			//获取 “立即数”标志
			uint16_t imm_flag = (instr >> 5) & 0x1;

			if (imm_flag)
			{
				uint16_t imm5 = sign_extend(instr & 0x1F, 5);/*5位数扩展为16位数*/
				reg[r0] = reg[r1] + imm5;					 /*第一个寄存器的值+立即数(imm5)，结果存入R0寄存器中*/
			}
			else
			{
				uint16_t r2 = instr & 0x7; /*获取到第二个寄存器位置*/
				reg[r0] = reg[r1] + reg[r2];/*第一个寄存器的值+第二个寄存器的值，结果存入r0寄存器中*/
			}

			update_flags(r0);/*更新符号信息*/
		}
		break;
		case OP_AND:
		{
			uint16_t r0 = (instr >> 9) & 0x7;
			uint16_t r1 = (instr >> 6) & 0x7;
			uint16_t imm_flag = (instr >> 5) & 0x1;

			if (imm_flag)
			{
				uint16_t imm5 = sign_extend(instr & 0x1F, 5);
				reg[r0] = reg[r1] & imm5;
			}
			else
			{
				uint16_t r2 = instr & 0x7;
				reg[r0] = reg[r1] & reg[r2];
			}
			update_flags(r0);/*更新符号信息*/
		}
		break;
		case OP_NOT:
		{
			uint16_t r0 = (instr >> 9) & 0x7;
			uint16_t r1 = (instr >> 6) & 0x7;

			reg[r0] = ~reg[r1];
			update_flags(r0);/*更新符号信息*/
		}
		break;
		case OP_BR:// br brz brp brn
		{
			//										 b0001 1111 1111
			uint16_t pc_offset = sign_extend(instr & 0x1FF, 9);
			uint16_t cond_flag = (instr >> 9) & 0x7;
			if (cond_flag & reg[R_COND])
			{
				reg[R_PC] += pc_offset;// pc寄存器的值 + 偏移地址
			}
		}
		break;
		case OP_JMP:
		{
			/* Also handles RET */
			uint16_t r1 = (instr >> 6) & 0x7; // base register
			reg[R_PC] = reg[r1];			  // 根据寄存器跳转地址，跳转地址的方式给 R_PC寄存器赋值为要跳转的值
		}
		break;
		case OP_JSR:
		{
			uint16_t long_flag = (instr >> 11) & 1;
			reg[R_R7] = reg[R_PC];
			if (long_flag)
			{
				uint16_t long_pc_offset = sign_extend(instr & 0x7FF, 11);
				reg[R_PC] += long_pc_offset;  /* JSR */
			}
			else
			{
				uint16_t r1 = (instr >> 6) & 0x7;
				reg[R_PC] = reg[r1]; /* JSRR */
			}
		}
		break;
		case OP_LD:
		{
			uint16_t r0 = (instr >> 9) & 0x7;
			uint16_t pc_offset = sign_extend(instr & 0x1FF, 9);
			reg[r0] = mem_read(reg[R_PC] + pc_offset);
			update_flags(r0);
		}
		break;
		case OP_LDI:
		{
			/* destination register (DR) */
			uint16_t r0 = (instr >> 9) & 0x7;
			/* PCoffset 9*/
			uint16_t pc_offset = sign_extend(instr & 0x1FF, 9);
			/* add pc_offset to the current PC, look at that memory location to get the final address */
			reg[r0] = mem_read(mem_read(reg[R_PC] + pc_offset));
			update_flags(r0);
		}
		break;
		case OP_LDR:
		{
			uint16_t r0 = (instr >> 9) & 0x7;
			uint16_t r1 = (instr >> 6) & 0x7;
			uint16_t offset = sign_extend(instr & 0x3F, 6);
			reg[r0] = mem_read(reg[r1] + offset);
			update_flags(r0);
		}
		break;
		case OP_LEA:
		{
			uint16_t r0 = (instr >> 9) & 0x7;
			uint16_t pc_offset = sign_extend(instr & 0x1FF, 9);
			reg[r0] = reg[R_PC] + pc_offset;
			update_flags(r0);
		}
		break;
		case OP_ST:
		{
			uint16_t r0 = (instr >> 9) & 0x7;
			uint16_t pc_offset = sign_extend(instr & 0x1FF, 9);
			mem_write(reg[R_PC] + pc_offset, reg[r0]);
		}
		break;
		case OP_STI:
		{
			uint16_t r0 = (instr >> 9) & 0x7;
			uint16_t pc_offset = sign_extend(instr & 0x1FF, 9);
			mem_write(mem_read(reg[R_PC] + pc_offset), reg[r0]);
		}
		break;
		case OP_STR:
		{
			uint16_t r0 = (instr >> 9) & 0x7;
			uint16_t r1 = (instr >> 6) & 0x7;
			uint16_t offset = sign_extend(instr & 0x3F, 6);
			mem_write(reg[r1] + offset, reg[r0]);
		}
		break;
		case OP_TRAP:
			reg[R_R7] = reg[R_PC];

			switch (instr & 0xFF)
			{
			case TRAP_GETC:
				/* read a single ASCII char */
				reg[R_R0] = (uint16_t)getchar();
				update_flags(R_R0);
				break;
			case TRAP_OUT:
				putc((char)reg[R_R0], stdout);
				fflush(stdout);
				break;
			case TRAP_PUTS:
			{
				/* one char per word */
				uint16_t* c = memory + reg[R_R0];
				while (*c)
				{
					putc((char)*c, stdout);
					++c;
				}
				fflush(stdout);
			}
			break;
			case TRAP_IN:
			{
				printf("Enter a character: ");
				char c = getchar();
				putc(c, stdout);
				fflush(stdout);
				reg[R_R0] = (uint16_t)c;
				update_flags(R_R0);
			}
			break;
			case TRAP_PUTSP:
			{
				/* one char per byte (two bytes per word)
				   here we need to swap back to
				   big endian format */
				uint16_t* c = memory + reg[R_R0];
				while (*c)
				{
					char char1 = (*c) & 0xFF;
					putc(char1, stdout);
					char char2 = (*c) >> 8;
					if (char2) putc(char2, stdout);
					++c;
				}
				fflush(stdout);
			}
			break;
			case TRAP_HALT://程序结束标志
				puts("HALT");
				fflush(stdout);
				running = 0;
				break;
			}
			break;
		case OP_RES:
		case OP_RTI:
		default:
			abort();
			break;
		}
	}
	restore_input_buffering();
}
