// ---- FNV Hash d43cc750ea7f1f3a

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer _Globals : register(b0)
{
  float4 Timer : packoffset(c0);
  float4 tempF1 : packoffset(c1);
  float4 tempF2 : packoffset(c2);
  float4 tempF3 : packoffset(c3);
  float4 ScreenSize : packoffset(c4);
  float4 SourceSize : packoffset(c5);
  float4 DynamicScaling : packoffset(c6);
  float4 Parameters01 : packoffset(c7);
  float4 Parameters02 : packoffset(c8);
  float4 Parameters03 : packoffset(c9);
  float4 Parameters04 : packoffset(c10);
  float4 Parameters05 : packoffset(c11);
  float4 Parameters06 : packoffset(c12);
  float4 Parameters07 : packoffset(c13);
  float4 Parameters08 : packoffset(c14);
  float4 Matrix01[4] : packoffset(c15);
  float4 Matrix02[4] : packoffset(c19);
  float4 Matrix03[4] : packoffset(c23);
  float4 Matrix04[4] : packoffset(c27);
  float4 Matrix05[4] : packoffset(c31);
  float SSAOsplitcount : packoffset(c35) = {2};
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

SamplerState Sampler8_s : register(s8);
Texture2D<float4> Texture0 : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
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

  r0.xy = SSAOsplitcount * v1.xy;
  r0.zw = floor(r0.xy);
  r1.y = Parameters05.y * Parameters05.z;
  r1.x = Parameters05.y;
  r0.xy = r0.zw * r1.xy + r0.xy;
  r0.xy = r1.xy * float2(0.5,0.5) + r0.xy;
  r0.xy = frac(r0.xy);
  r0.xyzw = Texture0.Sample(Sampler8_s, r0.xy).xyzw;
  o0.xyz = r0.xyz;
  o0.w = 1;
  return;
}