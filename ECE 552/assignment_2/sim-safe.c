/* sim-safe.c - sample functional simulator implementation */

/* SimpleScalar(TM) Tool Suite
 * Copyright (C) 1994-2003 by Todd M. Austin, Ph.D. and SimpleScalar, LLC.
 * All Rights Reserved. 
 * 
 * THIS IS A LEGAL DOCUMENT, BY USING SIMPLESCALAR,
 * YOU ARE AGREEING TO THESE TERMS AND CONDITIONS.
 * 
 * No portion of this work may be used by any commercial entity, or for any
 * commercial purpose, without the prior, written permission of SimpleScalar,
 * LLC (info@simplescalar.com). Nonprofit and noncommercial use is permitted
 * as described below.
 * 
 * 1. SimpleScalar is provided AS IS, with no warranty of any kind, express
 * or implied. The user of the program accepts full responsibility for the
 * application of the program and the use of any results.
 * 
 * 2. Nonprofit and noncommercial use is encouraged. SimpleScalar may be
 * downloaded, compiled, executed, copied, and modified solely for nonprofit,
 * educational, noncommercial research, and noncommercial scholarship
 * purposes provided that this notice in its entirety accompanies all copies.
 * Copies of the modified software can be delivered to persons who use it
 * solely for nonprofit, educational, noncommercial research, and
 * noncommercial scholarship purposes provided that this notice in its
 * entirety accompanies all copies.
 * 
 * 3. ALL COMMERCIAL USE, AND ALL USE BY FOR PROFIT ENTITIES, IS EXPRESSLY
 * PROHIBITED WITHOUT A LICENSE FROM SIMPLESCALAR, LLC (info@simplescalar.com).
 * 
 * 4. No nonprofit user may place any restrictions on the use of this software,
 * including as modified by the user, by any other authorized user.
 * 
 * 5. Noncommercial and nonprofit users may distribute copies of SimpleScalar
 * in compiled or executable form as set forth in Section 2, provided that
 * either: (A) it is accompanied by the corresponding machine-readable source
 * code, or (B) it is accompanied by a written offer, with no time limit, to
 * give anyone a machine-readable copy of the corresponding source code in
 * return for reimbursement of the cost of distribution. This written offer
 * must permit verbatim duplication by anyone, or (C) it is distributed by
 * someone who received only the executable form, and is accompanied by a
 * copy of the written offer of source code.
 * 
 * 6. SimpleScalar was developed by Todd M. Austin, Ph.D. The tool suite is
 * currently maintained by SimpleScalar LLC (info@simplescalar.com). US Mail:
 * 2395 Timbercrest Court, Ann Arbor, MI 48105.
 * 
 * Copyright (C) 1994-2003 by Todd M. Austin, Ph.D. and SimpleScalar, LLC.
 */


#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "host.h"
#include "misc.h"
#include "machine.h"
#include "regs.h"
#include "memory.h"
#include "loader.h"
#include "syscall.h"
#include "dlite.h"
#include "options.h"
#include "stats.h"
#include "sim.h"

/*
 * This file implements a functional simulator.  This functional simulator is
 * the simplest, most user-friendly simulator in the simplescalar tool set.
 * Unlike sim-fast, this functional simulator checks for all instruction
 * errors, and the implementation is crafted for clarity rather than speed.
 */

/* simulated registers */
static struct regs_t regs;

/* simulated memory */
static struct mem_t *mem = NULL;

/* track number of refs */
static counter_t sim_num_refs = 0;

/* ------------------- assn 2 ------------------- */
/* cycle_counter for 3widesuperscalar*/
static counter_t cycle_counter_3widesuperscalar = 0;
int src_reg1_lane1, src_reg2_lane1, dest_reg_lane1;
int src_reg1_lane2, src_reg2_lane2, dest_reg_lane2;
int src_reg1_lane3, src_reg2_lane3, dest_reg_lane3;
int stall_current_cycle = 0;
static counter_t ovr_stalls = 0;
static counter_t lane2_stalls = 0;
static counter_t lane3_stalls = 0;
static counter_t cycles_3widesuperscalar_RAW = 0;

int mem_in_use_lane1, mem_in_use_lane2, mem_in_use_lane3;
static counter_t lane2_cache_stalls = 0;
static counter_t lane3_cache_stalls = 0;
static counter_t cycles_3widesuperscalar_mem = 0;

static counter_t branches_taken = 0;
static counter_t branches_penalty = 0;
static counter_t cycles_3widesuperscalar_cond = 0;
/* ------------------- assn 2 ------------------- */

/* track number of int, fp, mem insts*/
static counter_t int_counter = 0;
static counter_t fp_counter = 0;
static counter_t mem_counter = 0;

/* maximum number of inst's to execute */
static unsigned int max_insts;

/* register simulator-specific options */
void
sim_reg_options(struct opt_odb_t *odb)
{
  opt_reg_header(odb, 
"sim-safe: This simulator implements a functional simulator.  This\n"
"functional simulator is the simplest, most user-friendly simulator in the\n"
"simplescalar tool set.  Unlike sim-fast, this functional simulator checks\n"
"for all instruction errors, and the implementation is crafted for clarity\n"
"rather than speed.\n"
		 );

  /* instruction limit */
  opt_reg_uint(odb, "-max:inst", "maximum number of inst's to execute",
	       &max_insts, /* default */0,
	       /* print */TRUE, /* format */NULL);

}

/* check simulator-specific option values */
void
sim_check_options(struct opt_odb_t *odb, int argc, char **argv)
{
  /* nada */
}

// define counts of mem access, integer operations, and floating point operations
// set to 0 to start
int mem_count = 0;
int int_count = 0;
int fp_count = 0;


/* register simulator-specific statistics */
void
sim_reg_stats(struct stat_sdb_t *sdb)
{
  
  stat_reg_counter(sdb, "sim_num_insn",
		   "total number of instructions executed",
		   &sim_num_insn, sim_num_insn, NULL);
    
  // stat_reg_counter(sdb, "sim_num_refs",
	// 	   "total number of loads and stores executed",
	// 	   &sim_num_refs, 0, NULL);

  stat_reg_counter(sdb, "cycles_superscalar",
		   "total number of insts executed in 3 wide superscalar, no hazards",
		   &cycle_counter_3widesuperscalar, 0, NULL);
  
  stat_reg_counter(sdb, "lane2_stalls_RAW",
        "total number of stalls in lane 2 due to RAW",
        &lane2_stalls, 0, NULL);
  
  stat_reg_counter(sdb, "lane3_stalls_RAW",
        "total number of stalls in lane 3 die to RAW",
        &lane3_stalls, 0, NULL);

  stat_reg_counter(sdb, "cycles_superscalar_RAW",
        "total number of cycles with RAW hazards",
        &cycles_3widesuperscalar_RAW, 0, NULL);

  stat_reg_counter(sdb, "lane2_cache_stalls",
        "total number of stalls in lane 2 due to cache port full",
        &lane2_cache_stalls, 0, NULL);

  stat_reg_counter(sdb, "lane3_cache_stalls",
        "total number of stalls in lane 3 due to cache port full",
        &lane3_cache_stalls, 0, NULL);

  stat_reg_counter(sdb, "cycles_superscalar_mem",
        "total number of cycles with RAW and cache port full hazards",
        &cycles_3widesuperscalar_mem, 0, NULL);

  stat_reg_counter(sdb, "branches_taken",
        "total number of branches taken",
        &branches_taken, 0, NULL);
  
  stat_reg_counter(sdb, "branches_penalty",
        "total number of cycles due to branch penalty",
        &branches_penalty, 0, NULL);

  stat_reg_counter(sdb, "cycles_superscalar_cond",
        "total number of cycles with RAW, cache port full, and branch penalty hazards",
        &cycles_3widesuperscalar_cond, 0, NULL);

  stat_reg_counter(sdb, "ovr_stalls",
      "total number of stalls due to RAW and mem port hazards",
      &ovr_stalls, 0, NULL);

  // stat_reg_counter(sdb, "int_counter",
	// 	   "total number of int instructions executed",
	// 	   &int_counter, 0, NULL);
  // stat_reg_counter(sdb, "fp_counter",
	// 	   "total number of fp instructions executed",
	// 	   &fp_counter, 0, NULL);
  stat_reg_counter(sdb, "mem_counter",
		   "total number of mem instructions executed",
		   &mem_counter, 0, NULL);

  stat_reg_int(sdb, "sim_elapsed_time",
	       "total simulation time in seconds",
	       &sim_elapsed_time, 0, NULL);
  stat_reg_formula(sdb, "sim_inst_rate",
		   "simulation speed (in insts/sec)",
		   "sim_num_insn / sim_elapsed_time", NULL);
  ld_reg_stats(sdb);
  mem_reg_stats(mem, sdb);
  // printf("mem_count: %d\n", mem_count);
  // printf("int_count: %d\n", int_count);
  // printf("fp_count: %d\n", fp_count);
}

/* initialize the simulator */
void
sim_init(void)
{
  sim_num_refs = 0;
  int_counter = 0;
  fp_counter = 0;
  mem_counter = 0;

  /* allocate and initialize register file */
  regs_init(&regs);

  /* allocate and initialize memory space */
  mem = mem_create("mem");
  mem_init(mem);
}

/* load program into simulated state */
void
sim_load_prog(char *fname,		/* program to load */
	      int argc, char **argv,	/* program arguments */
	      char **envp)		/* program environment */
{
  /* load program text and data, set up environment, memory, and regs */
  ld_load_prog(fname, argc, argv, envp, &regs, mem, TRUE);

  /* initialize the DLite debugger */
  dlite_init(md_reg_obj, dlite_mem_obj, dlite_mstate_obj);
}

/* print simulator-specific configuration information */
void
sim_aux_config(FILE *stream)		/* output stream */
{
  /* nothing currently */
}

/* dump simulator-specific auxiliary simulator statistics */
void
sim_aux_stats(FILE *stream)		/* output stream */
{
  /* nada */
}

/* un-initialize simulator-specific state */
void
sim_uninit(void)
{
  /* nada */
}


/*
 * configure the execution engine
 */

/*
 * precise architected register accessors
 */

/* next program counter */
#define SET_NPC(EXPR)		(regs.regs_NPC = (EXPR))

/* current program counter */
#define CPC			(regs.regs_PC)

/* general purpose registers */
#define GPR(N)			(regs.regs_R[N])
#define SET_GPR(N,EXPR)		(regs.regs_R[N] = (EXPR))

#if defined(TARGET_PISA)

/* floating point registers, L->word, F->single-prec, D->double-prec */
#define FPR_L(N)		(regs.regs_F.l[(N)])
#define SET_FPR_L(N,EXPR)	(regs.regs_F.l[(N)] = (EXPR))
#define FPR_F(N)		(regs.regs_F.f[(N)])
#define SET_FPR_F(N,EXPR)	(regs.regs_F.f[(N)] = (EXPR))
#define FPR_D(N)		(regs.regs_F.d[(N) >> 1])
#define SET_FPR_D(N,EXPR)	(regs.regs_F.d[(N) >> 1] = (EXPR))

/* miscellaneous register accessors */
#define SET_HI(EXPR)		(regs.regs_C.hi = (EXPR))
#define HI			(regs.regs_C.hi)
#define SET_LO(EXPR)		(regs.regs_C.lo = (EXPR))
#define LO			(regs.regs_C.lo)
#define FCC			(regs.regs_C.fcc)
#define SET_FCC(EXPR)		(regs.regs_C.fcc = (EXPR))

#elif defined(TARGET_ALPHA)

/* floating point registers, L->word, F->single-prec, D->double-prec */
#define FPR_Q(N)		(regs.regs_F.q[N])
#define SET_FPR_Q(N,EXPR)	(regs.regs_F.q[N] = (EXPR))
#define FPR(N)			(regs.regs_F.d[(N)])
#define SET_FPR(N,EXPR)		(regs.regs_F.d[(N)] = (EXPR))

/* miscellaneous register accessors */
#define FPCR			(regs.regs_C.fpcr)
#define SET_FPCR(EXPR)		(regs.regs_C.fpcr = (EXPR))
#define UNIQ			(regs.regs_C.uniq)
#define SET_UNIQ(EXPR)		(regs.regs_C.uniq = (EXPR))

#else
#error No ISA target defined...
#endif

/* precise architected memory state accessor macros */
#define READ_BYTE(SRC, FAULT)						\
  ((FAULT) = md_fault_none, addr = (SRC), MEM_READ_BYTE(mem, addr))
#define READ_HALF(SRC, FAULT)						\
  ((FAULT) = md_fault_none, addr = (SRC), MEM_READ_HALF(mem, addr))
#define READ_WORD(SRC, FAULT)						\
  ((FAULT) = md_fault_none, addr = (SRC), MEM_READ_WORD(mem, addr))
#ifdef HOST_HAS_QWORD
#define READ_QWORD(SRC, FAULT)						\
  ((FAULT) = md_fault_none, addr = (SRC), MEM_READ_QWORD(mem, addr))
#endif /* HOST_HAS_QWORD */

#define WRITE_BYTE(SRC, DST, FAULT)					\
  ((FAULT) = md_fault_none, addr = (DST), MEM_WRITE_BYTE(mem, addr, (SRC)))
#define WRITE_HALF(SRC, DST, FAULT)					\
  ((FAULT) = md_fault_none, addr = (DST), MEM_WRITE_HALF(mem, addr, (SRC)))
#define WRITE_WORD(SRC, DST, FAULT)					\
  ((FAULT) = md_fault_none, addr = (DST), MEM_WRITE_WORD(mem, addr, (SRC)))
#ifdef HOST_HAS_QWORD
#define WRITE_QWORD(SRC, DST, FAULT)					\
  ((FAULT) = md_fault_none, addr = (DST), MEM_WRITE_QWORD(mem, addr, (SRC)))
#endif /* HOST_HAS_QWORD */

/* system call handler macro */
#define SYSCALL(INST)	sys_syscall(&regs, mem_access, mem, INST, TRUE)


/* start simulation, program loaded, processor precise state initialized */
void
sim_main(void)
{
  md_inst_t inst;
  register md_addr_t addr;
  enum md_opcode op;
  register int is_write;
  enum md_fault_type fault;

  fprintf(stderr, "sim: ** starting functional simulation **\n");

  /* set up initial default next PC */
  regs.regs_NPC = regs.regs_PC + sizeof(md_inst_t);

  /* check for DLite debugger entry condition */
  if (dlite_check_break(regs.regs_PC, /* !access */0, /* addr */0, 0, 0))
    dlite_main(regs.regs_PC - sizeof(md_inst_t),
	       regs.regs_PC, sim_num_insn, &regs, mem);

  while (TRUE)
    {
      /* maintain $r0 semantics */
      regs.regs_R[MD_REG_ZERO] = 0;
#ifdef TARGET_ALPHA
      regs.regs_F.d[MD_REG_ZERO] = 0.0;
#endif /* TARGET_ALPHA */

      /* get the next instruction to execute */
      MD_FETCH_INST(inst, mem, regs.regs_PC);
      

      // printf("inst: %x\n", inst);

      /* keep an instruction count */
      sim_num_insn++;

      /* set default reference address and access mode */
      addr = 0; is_write = FALSE;

      /* set default fault - none */
      fault = md_fault_none;

      /* decode the instruction */
      MD_SET_OPCODE(op, inst);

      /* ------------------- assn 2 ------------------- */
      /*3 wide super scalar inst count*/
      cycle_counter_3widesuperscalar = (sim_num_insn / 3) + (sim_num_insn % 3);

      ovr_stalls = lane2_stalls + lane3_stalls + lane2_cache_stalls + lane3_cache_stalls;

      cycles_3widesuperscalar_RAW = cycle_counter_3widesuperscalar + lane2_stalls + lane3_stalls;

      cycles_3widesuperscalar_mem = cycle_counter_3widesuperscalar + lane2_stalls + lane3_stalls + lane2_cache_stalls + lane3_cache_stalls;
      
      cycles_3widesuperscalar_cond = cycle_counter_3widesuperscalar + lane2_stalls + lane3_stalls + lane2_cache_stalls + lane3_cache_stalls + branches_penalty;

      if (sim_num_insn % 3 == 0) {
        /* dependency checks, reset stall */
        stall_current_cycle = 0;
        mem_in_use_lane1 = 0;
        
        /* lane 1*/
        src_reg1_lane1 = RA; // update current lane regs
        src_reg2_lane1 = RB;
        dest_reg_lane1 = RC;

        /*cache port usage check*/
        if (MD_OP_FLAGS(op) & F_MEM){
          mem_in_use_lane1 = 1;
        }

      } else if (sim_num_insn % 3 == 1) {
        /* check for data hazards */
        if ((dest_reg_lane1 == RA || dest_reg_lane1 == RB)) {
          stall_current_cycle = 1;
        }
        /* reset */
        mem_in_use_lane2 = 0;

        if ((stall_current_cycle == 0) && !(mem_in_use_lane1 == 1 && (MD_OP_FLAGS(op) & F_MEM))) {
          /* lane 2*/
          src_reg1_lane2 = RA; // update current lane regs
          src_reg2_lane2 = RB;
          dest_reg_lane2 = RC;
          if (MD_OP_FLAGS(op) & F_MEM){
            mem_in_use_lane2 = 1;
          } else {
            mem_in_use_lane2 = 0;
          }
        } else if (mem_in_use_lane1 == 1 && (MD_OP_FLAGS(op) & F_MEM)) {
          /* stall */
          lane2_cache_stalls++;
        } else {
          /* stall */
          lane2_stalls++;
        }
       
      } else if (sim_num_insn % 3 == 2) {
        /* check for data hazards */
        if ((dest_reg_lane1 == RA || dest_reg_lane1 == RB) || (dest_reg_lane2 == RA || dest_reg_lane2 == RB)) {
          stall_current_cycle = 1;
        }
        /* reset */
        mem_in_use_lane3 = 0;
        /* lane 3*/
        
        if (stall_current_cycle == 0 && !((mem_in_use_lane1 == 1 && (MD_OP_FLAGS(op) & F_MEM)) || (mem_in_use_lane2 == 1 && (MD_OP_FLAGS(op) & F_MEM)))) {
          src_reg1_lane3 = RA; // update current lane regs
          src_reg2_lane3 = RB;
          dest_reg_lane3 = RC;
          if (MD_OP_FLAGS(op) & F_MEM){
            mem_in_use_lane3 = 1;
          } else {
            mem_in_use_lane3 = 0;
          }
        } else if ((mem_in_use_lane1 == 1 && (MD_OP_FLAGS(op) & F_MEM)) || (mem_in_use_lane2 == 1 && (MD_OP_FLAGS(op) & F_MEM))) {
          /* stall */
          lane3_cache_stalls++;
        } else {
          /* stall */
          lane3_stalls++;
        }

      }
        
      /* ------------------- assn 2 ------------------- */


      if (MD_OP_FLAGS(op) == 0x00000001) {
        int_count++;

      } else if (MD_OP_FLAGS(op) == 0x00000002) {
        fp_count++;
        // printf("\n\nfp_count: %d\n", fp_count);
      } else if (MD_OP_FLAGS(op) == 0x00000020) {
        mem_count++;
        // printf("\n\nmem_count: %d\n", mem_count);
      }
      

      /* execute the instruction */
      switch (op)
	{
#define DEFINST(OP,MSK,NAME,OPFORM,RES,FLAGS,O1,O2,I1,I2,I3)		\
	case OP:							\
          SYMCAT(OP,_IMPL);						\
          break;
#define DEFLINK(OP,MSK,NAME,MASK,SHIFT)					\
        case OP:							\
          panic("attempted to execute a linking opcode");
#define CONNECT(OP)
#define DECLARE_FAULT(FAULT)						\
	  { fault = (FAULT); break; }
#include "machine.def"
	default:
	  panic("attempted to execute a bogus opcode");
      }

      if (fault != md_fault_none)
	fatal("fault (%d) detected @ 0x%08p", fault, regs.regs_PC);

      if (verbose)
	{
	  myfprintf(stderr, "%10n [xor: 0x%08x] @ 0x%08p: ",
		    sim_num_insn, md_xor_regs(&regs), regs.regs_PC);
	  md_print_insn(inst, regs.regs_PC, stderr);
	  if (MD_OP_FLAGS(op) & F_MEM)
	    myfprintf(stderr, "  mem: 0x%08p", addr);
	  fprintf(stderr, "\n");
    
    // printf("mem_count: %d\n", mem_count);
    // printf("int_count: %d\n", int_count);
    // printf("fp_count: %d\n", fp_count);
	  /* fflush(stderr); */
	}

      if (MD_OP_FLAGS(op) & F_MEM)
      {
        sim_num_refs++;
        if (MD_OP_FLAGS(op) & F_STORE) {
          is_write = TRUE;
        }
      }

      if (MD_OP_FLAGS(op) & F_MEM)
        mem_counter++;

      if (MD_OP_FLAGS(op) & F_ICOMP)
        int_counter++;

      if (MD_OP_FLAGS(op) & F_FCOMP)
        fp_counter++;

      /* check for DLite debugger entry condition */
      if (dlite_check_break(regs.regs_NPC,
			    is_write ? ACCESS_WRITE : ACCESS_READ,
			    addr, sim_num_insn, sim_num_insn))
	dlite_main(regs.regs_PC, regs.regs_NPC, sim_num_insn, &regs, mem);

      /* go to the next instruction */
      /* ------------------- assn 2 ------------------- */

      if ((regs.regs_NPC) != (regs.regs_PC + sizeof(md_inst_t))) {
        branches_taken++;
        branches_penalty = branches_penalty + 7;
      }

      /* ------------------- assn 2 ------------------- */
      regs.regs_PC = regs.regs_NPC;
      regs.regs_NPC += sizeof(md_inst_t);

      /* finish early? */
      if (max_insts && sim_num_insn >= max_insts) {
          return;
      }
      
    }

    // print to console the counts of mem access, integer operations, and floating point operations
    printf("mem_count: %d\n", mem_count);
    printf("int_count: %d\n", int_count);
    printf("fp_count: %d\n", fp_count);

    // printf("mem_count: %d\n", mem_count);
}
