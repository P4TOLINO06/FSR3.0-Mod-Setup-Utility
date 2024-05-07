// ---- FNV Hash cfe6b33b70aeaddc

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(9.99999975e-05,-0.5) + v1.xx;
  r0.z = abs(r0.x) * -0.0187292993 + 0.0742610022;
  r0.z = r0.z * abs(r0.x) + -0.212114394;
  r0.z = r0.z * abs(r0.x) + 1.57072878;
  r0.w = 1 + -abs(r0.x);
  r0.w = sqrt(r0.w);
  r1.x = r0.z * r0.w;
  r1.x = r1.x * -2 + 3.14159274;
  r1.y = cmp(r0.x < -r0.x);
  r1.x = r1.y ? r1.x : 0;
  r0.z = r0.z * r0.w + r1.x;
  r0.z = sin(r0.z);
  r0.z = 0.751879692 * r0.z;
  r0.z = -r0.z * r0.z + 1;
  r0.z = sqrt(r0.z);
  r0.w = -r0.z * 1.33000004 + r0.x;
  r0.x = r0.z * 1.33000004 + r0.x;
  r0.y = saturate(5 * r0.y);
  r0.x = r0.w / r0.x;
  o0.x = r0.x * r0.x;
  o0.zw = float2(0,0);
  r0.x = r0.y * -2 + 3;
  r0.y = r0.y * r0.y;
  o0.y = r0.x * r0.y;
  return;
}