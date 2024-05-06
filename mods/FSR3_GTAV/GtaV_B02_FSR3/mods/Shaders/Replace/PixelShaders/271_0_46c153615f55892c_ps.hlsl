// ---- FNV Hash 46c153615f55892c

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t10 : register(t10);

Texture2D<float4> t4 : register(t4);

SamplerState s10_s : register(s10);

SamplerState s4_s : register(s4);

cbuffer cb5 : register(b5)
{
  float4 cb5[76];
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

  r0.xyz = cb5[72].xyy * float3(1,0,-1) + v1.xyy;
  r0.y = t4.Sample(s4_s, r0.xy).x;
  r0.x = t4.Sample(s4_s, r0.xz).x;
  r0.z = 0.980000019 * cb5[75].w;
  r0.xy = cmp(r0.zz < r0.xy);
  r0.xy = r0.xy ? float2(1,1) : 0;
  r1.yz = cmp(float2(0,0) != r0.yx);
  r1.yz = r1.yz ? float2(1,1) : 0;
  r0.x = t10.Sample(s10_s, v1.xy).x;
  r0.x = 0.25 * r0.x;
  r0.yw = cb5[72].xy * float2(0,-1) + v1.xy;
  r0.y = t4.Sample(s4_s, r0.yw).x;
  r0.y = cmp(r0.z < r0.y);
  r1.w = r0.y ? 1.000000 : 0;
  r0.y = t4.Sample(s4_s, v1.xy).x;
  r0.y = cmp(r0.z < r0.y);
  r1.x = r0.y ? 1.000000 : 0;
  o0.x = dot(r1.xyzw, r0.xxxx);
  o0.w = 1;
  return;
}