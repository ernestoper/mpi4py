/* Author:  Lisandro Dalcin   */
/* Contact: dalcinl@gmail.com */

/* ------------------------------------------------------------------------- */

#ifdef PYPY_VERSION

#ifndef PyByteArray_Check
#define PyByteArray_Check(self) PyObject_TypeCheck(self, &PyByteArray_Type)
#endif

#ifndef PyByteArray_AsString
static char* PyByteArray_AsString(PyObject* o)
{
  PyErr_SetString(PyExc_RuntimeError,
                  "PyPy: PyByteArray_AsString() not available");
  (void)o; return NULL;
}
#endif

#ifndef PyByteArray_Size
static Py_ssize_t PyByteArray_Size(PyObject* o)
{
  PyErr_SetString(PyExc_RuntimeError,
                  "PyPy: PyByteArray_Size() not available");
  (void)o; return -1;
}
#endif

#endif/*PYPY_VERSION*/

/* ------------------------------------------------------------------------- */

#ifdef PYPY_VERSION
#ifdef PySlice_GetIndicesEx
#undef PySlice_GetIndicesEx
#define PySlice_GetIndicesEx(s, n, start, stop, step, length) \
PyPySlice_GetIndicesEx((PySliceObject *)(s), n, start, stop, step, length)
#else
#define PySlice_GetIndicesEx(s, n, start, stop, step, length) \
PySlice_GetIndicesEx((PySliceObject *)(s), n, start, stop, step, length)
#endif
#else
#if PY_VERSION_HEX < 0x03020000
#define PySlice_GetIndicesEx(s, n, start, stop, step, length) \
PySlice_GetIndicesEx((PySliceObject *)(s), n, start, stop, step, length)
#endif
#endif

/* ------------------------------------------------------------------------- */

#if !defined(WITH_THREAD)
#undef  PyGILState_Ensure
#define PyGILState_Ensure() ((PyGILState_STATE)0)
#undef  PyGILState_Release
#define PyGILState_Release(state) (state)=((PyGILState_STATE)0)
#undef  Py_BLOCK_THREADS
#define Py_BLOCK_THREADS (_save)=(PyThreadState*)0;
#undef  Py_UNBLOCK_THREADS
#define Py_UNBLOCK_THREADS (_save)=(PyThreadState*)0;
#endif

/* ------------------------------------------------------------------------- */

/*
  Local variables:
  c-basic-offset: 2
  indent-tabs-mode: nil
  End:
*/
