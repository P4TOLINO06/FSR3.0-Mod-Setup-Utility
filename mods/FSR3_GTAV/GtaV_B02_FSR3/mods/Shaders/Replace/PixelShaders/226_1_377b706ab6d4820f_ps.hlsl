// ---- FNV Hash 377b706ab6d4820f

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

SamplerState earlyOut_Sampler_s : register(s5);
Texture2D<float> earlyOut : register(t5);


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
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(0.5,0.5) + v0.xy;
  r1.xy = earlyOutParams.xy * r0.xy;
  r1.zw = r0.yx * earlyOutParams.yx + -earlyOutParams.yx;
  r0.xyzw = earlyOut.Gather(earlyOut_Sampler_s, r1.xy).xyzw;
  r2.xyzw = earlyOut.Gather(earlyOut_Sampler_s, r1.xz).xyzw;
  r3.xyzw = earlyOut.Gather(earlyOut_Sampler_s, r1.wy).xyzw;
  r1.xyzw = earlyOut.Gather(earlyOut_Sampler_s, r1.wz).xyzw;
  r0.xyzw = r2.xyzw + r0.xyzw;
  r0.xyzw = r0.xyzw + r1.xyzw;
  r0.xyzw = r0.xyzw + r3.xyzw;
  o0.xyzw = dot(r0.xyzw, float4(0.0625,0.0625,0.0625,0.0625));
  return;
}