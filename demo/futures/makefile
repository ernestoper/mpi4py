.PHONY: default
default: test

PYTHON  = python
MPIEXEC = mpiexec
NPFLAG  = -n

.PHONY: run-crawl run-primes run-pool
run-crawl:
	${MPIEXEC} ${NPFLAG} 1 ${PYTHON} run_crawl.py
run-primes:
	${MPIEXEC} ${NPFLAG} 1 ${PYTHON} run_primes.py
run-pool: run-crawl run-primes


.PHONY: run-mandelbrot run-julia run-comm
run-mandelbrot:
	${MPIEXEC} ${NPFLAG} 5 ${PYTHON} run_julia.py
run-julia:
	${MPIEXEC} ${NPFLAG} 5 ${PYTHON} run_mandelbrot.py
run-comm: run-mandelbrot run-julia


.PHONY: run-cmdline
run-cmdline:
	${MPIEXEC} ${NPFLAG} 5 ${PYTHON} -m mpi4py.futures run_crawl.py
	${MPIEXEC} ${NPFLAG} 5 ${PYTHON} -m mpi4py.futures run_primes.py
	${MPIEXEC} ${NPFLAG} 5 ${PYTHON} -m mpi4py.futures run_julia.py
	${MPIEXEC} ${NPFLAG} 5 ${PYTHON} -m mpi4py.futures run_mandelbrot.py


.PHONY: run-unittest
run-unittest:
	${MPIEXEC} ${NPFLAG} 1 ${PYTHON} test_futures.py
	${MPIEXEC} ${NPFLAG} 2 ${PYTHON} test_futures.py
	${MPIEXEC} ${NPFLAG} 1 ${PYTHON} -m mpi4py.futures test_futures.py
	${MPIEXEC} ${NPFLAG} 2 ${PYTHON} -m mpi4py.futures test_futures.py


.PHONY: test
test: run-pool run-comm run-cmdline
