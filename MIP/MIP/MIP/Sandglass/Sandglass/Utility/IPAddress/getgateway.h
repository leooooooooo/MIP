
#ifndef MIP_getgateway_h
#define MIP_getgateway_h


#ifdef __cplusplus
extern "C" {
#endif
    
    /* getdefaultgateway() :
     * return value :
     *    0 : success
     *   -1 : failure    */
    int getdefaultgateway(in_addr_t * addr, char * gateway);
    
#ifdef __cplusplus
}
#endif


#endif