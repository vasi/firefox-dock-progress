#ifndef _DOCKPROGRESSC_H_
#define _DOCKPROGRESSC_H_
#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
	kFDPStyleBar,
	kFDPStyleFill,
} FDPStyle;

void FDPSetHidden(void);
void FDPSetProgress(double percent);
void FDPSetStyle(FDPStyle style);
void FDPSetGradientPath(const char *path);

#ifdef __cplusplus
}
#endif
#endif /* _DOCKPROGRESSC_H_ */
