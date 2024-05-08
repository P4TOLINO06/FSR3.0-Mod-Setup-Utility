// ---- FNV Hash f2f94085cd1008c8

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer soft_shadow_locals : register(b10)
{
  float4 projectionParams : packoffset(c0);
  float4 targetSizeParam : packoffset(c1);
  float4 kernelParam : packoffset(c2);
  float4 earlyOutParams : packoffset(c3);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState intermediateTarget_Sampler_s : register(s4);
SamplerState depthBuffer2_Sampler_s : register(s6);
Texture2D<float2> intermediateTarget : register(t4);
Texture2D<float> earlyOut : register(t5);
Texture2D<float> depthBuffer2 : register(t6);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (int2)v0.xy;
  r1.xy = (uint2)r0.xy >> 3;
  r1.zw = float2(0,0);
  r1.x = earlyOut.Load(r1.xyz).x;
  r1.y = cmp(r1.x == 0.000000);
  if (r1.y != 0) {
    o0.xyzw = float4(0,0,0,0);
    return;
  }
  r1.x = cmp(r1.x != 1.000000);
  if (r1.x != 0) {
    r1.xy = targetSizeParam.zw * v0.xy;
    r2.x = depthBuffer2.SampleLevel(depthBuffer2_Sampler_s, r1.xy, 0).x;
    r1.z = projectionParams.w + -r2.x;
    r1.z = 1 + r1.z;
    r1.z = projectionParams.z / r1.z;
    r2.xy = r1.xy * float2(2,-2) + float2(-1,1);
    r2.xy = projectionParams.xy * r2.xy;
    r2.z = 1;
    r2.xyw = r2.xyz * r1.zzz;
    r3.xy = float2(0.5,0.5) * targetSizeParam.xy;
    r3.zw = kernelParam.xx / projectionParams.xy;
    r3.xy = r3.xy * r3.zw;
    r3.xy = r3.xy / r2.ww;
    r3.xy = min(kernelParam.yy, r3.xy);
    r1.w = max(r3.x, r3.y);
    r2.w = cmp(r1.w < 1);
    if (r2.w != 0) {
      r3.xy = intermediateTarget.SampleLevel(intermediateTarget_Sampler_s, r1.xy, 0).xy;
    }
    if (r2.w == 0) {
      r1.w = trunc(r1.w);
      r1.w = (int)r1.w;
      r1.w = max(1, (int)r1.w);
      r1.w = min(3, (int)r1.w);
      r2.w = (int)r1.w + -1;
      r4.xy = intermediateTarget.SampleLevel(intermediateTarget_Sampler_s, r1.xy, 0).xy;
      r1.x = kernelParam.z * v0.x + -projectionParams.x;
      r1.y = -kernelParam.w * v0.y + projectionParams.y;
      r3.yz = (int2)v0.xy;
      r4.yz = cmp((uint2)r2.ww < int2(1,2));
      r4.yz = r4.yz ? float2(0,0) : float2(1.40129846e-45,2.80259693e-45);
      r5.w = 0;
      r6.w = 0;
      r7.xy = r4.yz;
      r7.z = 0;
      r8.x = 1;
      r8.y = r4.x;
      r2.w = 0;
      r3.w = 0;
      while (true) {
        r4.w = cmp((int)r2.w >= (int)r1.w);
        if (r4.w != 0) break;
        r4.w = -(int)r3.w;
        r8.zw = cmp((uint2)r3.ww < int2(2,1));
        r9.xy = r8.zz ? r4.ww : float2(-3,3);
        r7.w = (int)r3.w + 1;
        r9.z = r8.w ? 0 : r7.w;
        r10.xy = int2(2,-1) + (int2)r4.ww;
        r4.w = r8.z ? r10.y : 0;
        r8.z = r8.z ? 0.000000 : 0;
        r11.xy = (int2)r9.xz;
        r11.z = (int)r4.w;
        r11.w = (int)r8.z;
        r7.w = (uint)r7.w % 3;
        r10.xy = r8.ww ? float2(-1,0) : r10.xy;
        r12.x = (int)r7.w;
        r12.yw = (int2)r10.xy;
        r12.z = (int)r9.y;
        r11.xyzw = r11.xyzw * kernelParam.zzzz + r1.xxxx;
        r12.xyzw = r12.xyzw * -kernelParam.wwww + r1.yyyy;
        r5.z = (int)r3.z + (int)r7.w;
        r6.x = (int)r3.y + (int)r9.z;
        r13.x = (int)r3.y + (int)r4.w;
        r5.xy = (int2)r3.yz + (int2)r9.xy;
        r9.x = (int)r3.y + (int)r8.z;
        r6.yz = (int2)r3.zz + (int2)r10.xy;
        r10.x = depthBuffer2.Load(r5.xzw, int3(0, 0, 0)).x;
        r10.x = projectionParams.w + -r10.x;
        r14.xy = intermediateTarget.Load(r5.xzw).xy;
        r15.x = depthBuffer2.Load(r6.xyw, int3(0, 0, 0)).x;
        r10.y = projectionParams.w + -r15.x;
        r15.xy = intermediateTarget.Load(r6.xyw).xy;
        r13.yzw = r5.yww;
        r16.x = depthBuffer2.Load(r13.xyw, int3(0, 0, 0)).x;
        r10.z = projectionParams.w + -r16.x;
        r13.xy = intermediateTarget.Load(r13.xyz).xy;
        r9.yzw = r6.zww;
        r16.x = depthBuffer2.Load(r9.xyw, int3(0, 0, 0)).x;
        r10.w = projectionParams.w + -r16.x;
        r9.xy = intermediateTarget.Load(r9.xyz).xy;
        r16.x = r14.x;
        r16.y = r15.x;
        r16.z = r13.x;
        r16.w = r9.x;
        r15.x = r14.y;
        r15.z = r13.y;
        r15.w = r9.y;
        r9.xyzw = min(r16.xyzw, r15.xyzw);
        r10.xyzw = float4(1,1,1,1) + r10.xyzw;
        r10.xyzw = projectionParams.zzzz / r10.xyzw;
        r11.xyzw = r11.xyzw * r10.xyzw + -r2.xxxx;
        r12.xyzw = r12.xyzw * r10.xyzw + -r2.yyyy;
        r10.xyzw = -r2.zzzz * r1.zzzz + r10.xyzw;
        r12.xyzw = r12.xyzw * r12.xyzw;
        r11.xyzw = r11.xyzw * r11.xyzw + r12.xyzw;
        r10.xyzw = r10.xyzw * r10.xyzw + r11.xyzw;
        r10.xyzw = cmp(kernelParam.xxxx >= r10.xyzw);
        r10.xyzw = r10.xyzw ? float4(1,1,1,1) : 0;
        r4.w = dot(r9.xyzw, r10.xyzw);
        r8.y = r8.y + r4.w;
        r4.w = dot(r10.xyzw, float4(1,1,1,1));
        r8.x = r8.x + r4.w;
        r2.w = (int)r2.w + 1;
        r5.xy = r7.yz;
        r7.z = r3.w;
        r3.w = r7.x;
        r7.xy = r5.xy;
      }
      r3.x = r8.y / r8.x;
    }
  } else {
    r3.x = 1;
  }
  r0.zw = float2(0,0);
  r0.xy = intermediateTarget.Load(r0.xyz).xy;
  o0.xyzw = min(r3.xxxx, r0.yyyy);
  return;
}