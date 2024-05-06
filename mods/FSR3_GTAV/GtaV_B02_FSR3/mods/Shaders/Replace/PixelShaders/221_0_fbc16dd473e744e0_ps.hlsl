// ---- FNV Hash fbc16dd473e744e0

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer waterTex_locals : register(b11)
{
  float4 WaterBumpParams[2] : packoffset(c0);
  float4 gProjParams : packoffset(c2);
  float4 gFogCompositeParams : packoffset(c3);
  float4 gFogCompositeAmbientColor : packoffset(c4);
  float4 gFogCompositeDirectionalColor : packoffset(c5);
  float4 gFogCompositeTexOffset : packoffset(c6);
  float4 UpdateParams0 : packoffset(c7);
  float4 UpdateParams1 : packoffset(c8);
  float4 UpdateParams2 : packoffset(c9);
  float4 UpdateOffset : packoffset(c10);
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

SamplerState VelocityMapSampler_s : register(s15);
Texture2D<float4> VelocityMapSampler : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 pos : POSITION0,
  out float o0 : SV_Target0,
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

  r0.x = log2(v1.x);
  r0.x = UpdateParams0.x * r0.x;
  r0.x = exp2(r0.x);
  r0.yz = v2.xy / v2.ww;
  r1.xyzw = VelocityMapSampler.Sample(VelocityMapSampler_s, r0.yz).xyzw;
  r0.x = r1.x * r0.x;
  r0.x = max(-10, r0.x);
  r0.x = min(10, r0.x);
  r0.y = cmp(abs(r0.x) >= 9);
  o0.x = r0.y ? 0 : r0.x;
  return;
}