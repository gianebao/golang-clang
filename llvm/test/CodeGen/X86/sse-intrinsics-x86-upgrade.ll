; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-apple-darwin -mattr=+sse -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86,SSE,X86-SSE
; RUN: llc < %s -mtriple=i386-apple-darwin -mattr=+avx -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86,AVX,X86-AVX,AVX1,X86-AVX1
; RUN: llc < %s -mtriple=i386-apple-darwin -mattr=+avx512f,+avx512bw,+avx512dq,+avx512vl -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86,AVX,X86-AVX,AVX512,X86-AVX512
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=-sse2 -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64,SSE,X64-SSE
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+avx -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64,AVX,X64-AVX,AVX1,X64-AVX1
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+avx512f,+avx512bw,+avx512dq,+avx512vl -show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64,AVX,X64-AVX,AVX512,X64-AVX512


define <4 x float> @test_x86_sse_sqrt_ps(<4 x float> %a0) {
; SSE-LABEL: test_x86_sse_sqrt_ps:
; SSE:       ## %bb.0:
; SSE-NEXT:    sqrtps %xmm0, %xmm0 ## encoding: [0x0f,0x51,0xc0]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX1-LABEL: test_x86_sse_sqrt_ps:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vsqrtps %xmm0, %xmm0 ## encoding: [0xc5,0xf8,0x51,0xc0]
; AVX1-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX512-LABEL: test_x86_sse_sqrt_ps:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vsqrtps %xmm0, %xmm0 ## EVEX TO VEX Compression encoding: [0xc5,0xf8,0x51,0xc0]
; AVX512-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse.sqrt.ps(<4 x float> %a0) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.sqrt.ps(<4 x float>) nounwind readnone


define <4 x float> @test_x86_sse_sqrt_ss(<4 x float> %a0) {
; SSE-LABEL: test_x86_sse_sqrt_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    sqrtss %xmm0, %xmm0 ## encoding: [0xf3,0x0f,0x51,0xc0]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX-LABEL: test_x86_sse_sqrt_ss:
; AVX:       ## %bb.0:
; AVX-NEXT:    vsqrtss %xmm0, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x51,0xc0]
; AVX-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float> %a0) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float>) nounwind readnone


define void @test_x86_sse_storeu_ps(i8* %a0, <4 x float> %a1) {
; X86-SSE-LABEL: test_x86_sse_storeu_ps:
; X86-SSE:       ## %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax ## encoding: [0x8b,0x44,0x24,0x04]
; X86-SSE-NEXT:    movups %xmm0, (%eax) ## encoding: [0x0f,0x11,0x00]
; X86-SSE-NEXT:    retl ## encoding: [0xc3]
;
; X86-AVX1-LABEL: test_x86_sse_storeu_ps:
; X86-AVX1:       ## %bb.0:
; X86-AVX1-NEXT:    movl {{[0-9]+}}(%esp), %eax ## encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX1-NEXT:    vmovups %xmm0, (%eax) ## encoding: [0xc5,0xf8,0x11,0x00]
; X86-AVX1-NEXT:    retl ## encoding: [0xc3]
;
; X86-AVX512-LABEL: test_x86_sse_storeu_ps:
; X86-AVX512:       ## %bb.0:
; X86-AVX512-NEXT:    movl {{[0-9]+}}(%esp), %eax ## encoding: [0x8b,0x44,0x24,0x04]
; X86-AVX512-NEXT:    vmovups %xmm0, (%eax) ## EVEX TO VEX Compression encoding: [0xc5,0xf8,0x11,0x00]
; X86-AVX512-NEXT:    retl ## encoding: [0xc3]
;
; X64-SSE-LABEL: test_x86_sse_storeu_ps:
; X64-SSE:       ## %bb.0:
; X64-SSE-NEXT:    movups %xmm0, (%rdi) ## encoding: [0x0f,0x11,0x07]
; X64-SSE-NEXT:    retq ## encoding: [0xc3]
;
; X64-AVX1-LABEL: test_x86_sse_storeu_ps:
; X64-AVX1:       ## %bb.0:
; X64-AVX1-NEXT:    vmovups %xmm0, (%rdi) ## encoding: [0xc5,0xf8,0x11,0x07]
; X64-AVX1-NEXT:    retq ## encoding: [0xc3]
;
; X64-AVX512-LABEL: test_x86_sse_storeu_ps:
; X64-AVX512:       ## %bb.0:
; X64-AVX512-NEXT:    vmovups %xmm0, (%rdi) ## EVEX TO VEX Compression encoding: [0xc5,0xf8,0x11,0x07]
; X64-AVX512-NEXT:    retq ## encoding: [0xc3]
  call void @llvm.x86.sse.storeu.ps(i8* %a0, <4 x float> %a1)
  ret void
}
declare void @llvm.x86.sse.storeu.ps(i8*, <4 x float>) nounwind


define <4 x float> @test_x86_sse_add_ss(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_add_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    addss %xmm1, %xmm0 ## encoding: [0xf3,0x0f,0x58,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX1-LABEL: test_x86_sse_add_ss:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vaddss %xmm1, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x58,0xc1]
; AVX1-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX512-LABEL: test_x86_sse_add_ss:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vaddss %xmm1, %xmm0, %xmm0 ## EVEX TO VEX Compression encoding: [0xc5,0xfa,0x58,0xc1]
; AVX512-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse.add.ss(<4 x float> %a0, <4 x float> %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.add.ss(<4 x float>, <4 x float>) nounwind readnone


define <4 x float> @test_x86_sse_sub_ss(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_sub_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    subss %xmm1, %xmm0 ## encoding: [0xf3,0x0f,0x5c,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX1-LABEL: test_x86_sse_sub_ss:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vsubss %xmm1, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x5c,0xc1]
; AVX1-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX512-LABEL: test_x86_sse_sub_ss:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vsubss %xmm1, %xmm0, %xmm0 ## EVEX TO VEX Compression encoding: [0xc5,0xfa,0x5c,0xc1]
; AVX512-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse.sub.ss(<4 x float> %a0, <4 x float> %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.sub.ss(<4 x float>, <4 x float>) nounwind readnone


define <4 x float> @test_x86_sse_mul_ss(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_mul_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    mulss %xmm1, %xmm0 ## encoding: [0xf3,0x0f,0x59,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX1-LABEL: test_x86_sse_mul_ss:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vmulss %xmm1, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x59,0xc1]
; AVX1-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX512-LABEL: test_x86_sse_mul_ss:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vmulss %xmm1, %xmm0, %xmm0 ## EVEX TO VEX Compression encoding: [0xc5,0xfa,0x59,0xc1]
; AVX512-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse.mul.ss(<4 x float> %a0, <4 x float> %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.mul.ss(<4 x float>, <4 x float>) nounwind readnone


define <4 x float> @test_x86_sse_div_ss(<4 x float> %a0, <4 x float> %a1) {
; SSE-LABEL: test_x86_sse_div_ss:
; SSE:       ## %bb.0:
; SSE-NEXT:    divss %xmm1, %xmm0 ## encoding: [0xf3,0x0f,0x5e,0xc1]
; SSE-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX1-LABEL: test_x86_sse_div_ss:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vdivss %xmm1, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x5e,0xc1]
; AVX1-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
;
; AVX512-LABEL: test_x86_sse_div_ss:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vdivss %xmm1, %xmm0, %xmm0 ## EVEX TO VEX Compression encoding: [0xc5,0xfa,0x5e,0xc1]
; AVX512-NEXT:    ret{{[l|q]}} ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse.div.ss(<4 x float> %a0, <4 x float> %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.div.ss(<4 x float>, <4 x float>) nounwind readnone


define <4 x float> @test_x86_sse_cvtsi2ss(<4 x float> %a0, i32 %a1) {
; X86-SSE-LABEL: test_x86_sse_cvtsi2ss:
; X86-SSE:       ## %bb.0:
; X86-SSE-NEXT:    cvtsi2ssl {{[0-9]+}}(%esp), %xmm0 ## encoding: [0xf3,0x0f,0x2a,0x44,0x24,0x04]
; X86-SSE-NEXT:    retl ## encoding: [0xc3]
;
; X86-AVX1-LABEL: test_x86_sse_cvtsi2ss:
; X86-AVX1:       ## %bb.0:
; X86-AVX1-NEXT:    vcvtsi2ssl {{[0-9]+}}(%esp), %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x2a,0x44,0x24,0x04]
; X86-AVX1-NEXT:    retl ## encoding: [0xc3]
;
; X86-AVX512-LABEL: test_x86_sse_cvtsi2ss:
; X86-AVX512:       ## %bb.0:
; X86-AVX512-NEXT:    vcvtsi2ssl {{[0-9]+}}(%esp), %xmm0, %xmm0 ## EVEX TO VEX Compression encoding: [0xc5,0xfa,0x2a,0x44,0x24,0x04]
; X86-AVX512-NEXT:    retl ## encoding: [0xc3]
;
; X64-SSE-LABEL: test_x86_sse_cvtsi2ss:
; X64-SSE:       ## %bb.0:
; X64-SSE-NEXT:    cvtsi2ssl %edi, %xmm0 ## encoding: [0xf3,0x0f,0x2a,0xc7]
; X64-SSE-NEXT:    retq ## encoding: [0xc3]
;
; X64-AVX1-LABEL: test_x86_sse_cvtsi2ss:
; X64-AVX1:       ## %bb.0:
; X64-AVX1-NEXT:    vcvtsi2ssl %edi, %xmm0, %xmm0 ## encoding: [0xc5,0xfa,0x2a,0xc7]
; X64-AVX1-NEXT:    retq ## encoding: [0xc3]
;
; X64-AVX512-LABEL: test_x86_sse_cvtsi2ss:
; X64-AVX512:       ## %bb.0:
; X64-AVX512-NEXT:    vcvtsi2ssl %edi, %xmm0, %xmm0 ## EVEX TO VEX Compression encoding: [0xc5,0xfa,0x2a,0xc7]
; X64-AVX512-NEXT:    retq ## encoding: [0xc3]
  %res = call <4 x float> @llvm.x86.sse.cvtsi2ss(<4 x float> %a0, i32 %a1) ; <<4 x float>> [#uses=1]
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.sse.cvtsi2ss(<4 x float>, i32) nounwind readnone