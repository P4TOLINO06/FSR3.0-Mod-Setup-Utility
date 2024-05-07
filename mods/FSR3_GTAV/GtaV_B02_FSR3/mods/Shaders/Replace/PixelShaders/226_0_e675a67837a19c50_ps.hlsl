// ---- FNV Hash e675a67837a19c50

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
Texture2D<float2> intermediateTarget : register(t4);


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
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v0.xy * float2(8,8) + float2(1,1);
  r0.xy = targetSizeParam.zw * r0.xy;
  r0.z = 0;
  r0.w = r0.y;
  r1.x = 0;
  while (true) {
    r1.y = cmp((int)r1.x >= 4);
    if (r1.y != 0) break;
    r2.y = r0.w;
    r3.x = r0.z;
    r3.y = r0.x;
    r1.y = 0;
    while (true) {
      r1.z = cmp((int)r1.y >= 4);
      if (r1.z != 0) break;
      r2.x = r3.y;
      r4.xyzw = intermediateTarget.Gather(intermediateTarget_Sampler_s, r2.xy).xyzw;
      r1.z = dot(r4.xyzw, float4(1,1,1,1));
      r3.x = r3.x + r1.z;
      r3.y = targetSizeParam.z * 2 + r3.y;
      r1.y = (int)r1.y + 1;
    }
    r0.z = r3.x;
    r0.w = targetSizeParam.w * 2 + r0.w;
    r1.x = (int)r1.x + 1;
  }
  o0.xyzw = float4(0.015625,0.015625,0.015625,0.015625) * r0.zzzz;
  return;
}