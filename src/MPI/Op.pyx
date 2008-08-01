cdef class Op:

    """
    Op
    """

    def __cinit__(self):
        self.ob_mpi = MPI_OP_NULL
        self.op_fun = NULL
        self.__callable = None
        self.__commute  = 0

    def __dealloc__(self):
        cdef int ierr = 0
        if not (self.flags & PyMPI_SKIP_FREE):
            ierr = _del_Op(&self.ob_mpi); CHKERR(ierr)

    def __richcmp__(Op self, Op other, int op):
        if   op == 2: return (self.ob_mpi == other.ob_mpi)
        elif op == 3: return (self.ob_mpi != other.ob_mpi)
        else: raise TypeError("only '==' and '!='")

    def __nonzero__(self):
        return self.ob_mpi != MPI_OP_NULL

    def __bool__(self):
        return self.ob_mpi != MPI_OP_NULL

    def __call__(self, x, y):
        if self.op_fun != NULL:
            return self.op_fun(x, y)
        else:
            return self.__callable(x, y)

    def Create(cls, function, bint commute=False):
        """
        Create a user-defined operation
        """
        cdef Op op = cls()
        op.ob_mpi = MPI_OP_NULL
        op.__callable = function
        op.__commute  = commute

    def Free(self):
        """
        Free the operation
        """
        CHKERR( MPI_Op_free(&self.ob_mpi) )



# Null operation handle
# ---------------------

OP_NULL = _new_Op( MPI_OP_NULL )

# Predefined operation handles
# ----------------------------

MAX     = _new_Op( MPI_MAX     ) #: Maximum
MIN     = _new_Op( MPI_MIN     ) #: Minimum
SUM     = _new_Op( MPI_SUM     ) #: Sum
PROD    = _new_Op( MPI_PROD    ) #: Product
LAND    = _new_Op( MPI_LAND    ) #: Logical and
BAND    = _new_Op( MPI_BAND    ) #: Bit-wise and
LOR     = _new_Op( MPI_LOR     ) #: Logical or
BOR     = _new_Op( MPI_BOR     ) #: Bit-wise or
LXOR    = _new_Op( MPI_LXOR    ) #: Logical xor
BXOR    = _new_Op( MPI_BXOR    ) #: Bit-wise xor
MAXLOC  = _new_Op( MPI_MAXLOC  ) #: Maximum and location
MINLOC  = _new_Op( MPI_MINLOC  ) #: Minimum and location
REPLACE = _new_Op( MPI_REPLACE ) #: Replace (for RMA)